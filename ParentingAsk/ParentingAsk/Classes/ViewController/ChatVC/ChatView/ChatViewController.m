/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "AppDelegate.h"
#import "LoginVC.h"
#import "ChatViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "SRRefreshView.h"
#import "DXChatBarMoreView.h"
#import "DXRecordView.h"
#import "DXFaceView.h"
#import "EMChatViewCell.h"
#import "EMChatTimeCell.h"
#import "ChatSendHelper.h"
#import "MessageReadManager.h"
#import "MessageModelManager.h"
#import "LocationViewController.h"
#import "UIViewController+HUD.h"
#import "NSDate+Category.h"
#import "DXMessageToolBar.h"
#import "DXChatBarMoreView.h"
#import "ChatViewController+Category.h"
#import "EMCDDeviceManager.h"
#import "EMCDDeviceManagerDelegate.h"

#import "UINavigationItem+ItemCustom.h"
#import "UIViewController+VCPopUp.h"
#import "PopUpVC.h"
#import "JudgeVC.h"
#import "DoctorListVC.h"
#import "User.h"
#import "UserInfoVC.h"
#import "CellChatMore.h"

#import "ConvertToCommonEmoticonsHelper.h"
#import "ChooseCityVC.h"
#import "MainTabBarViewController.h"

#import "AFNetworking.h"

#define KPageCount 20
#define KHintAdjustY    50
#define DEFAULT_USER  [NSUserDefaults standardUserDefaults]
@interface ChatViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, SRRefreshDelegate, IChatManagerDelegate, DXChatBarMoreViewDelegate, DXMessageToolBarDelegate, LocationViewDelegate, EMCDDeviceManagerDelegate,EMCallManagerDelegate, PopUpVCDeleagte, IEMChatProgressDelegate, UIAlertViewDelegate,AVAudioPlayerDelegate,UITextFieldDelegate>
{
    UIMenuController *_menuController;
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
    NSIndexPath *_longPressIndexPath;
    
    NSInteger _recordingCount;
    
    dispatch_queue_t _messageQueue;
    
    NSMutableArray *_messages;
    BOOL _isScrollToBottom;
    NSMutableArray *_mutChatMore;
    
    PopUpVC *_popUpVC;
    NSInteger _page;
    
    NSIndexPath *_indexSelected;
    NSMutableArray *_mutArrayUserHeader;
    
    BOOL _isEnterBackground;
    
    AVAudioPlayer *player;
    
    UIAlertView *alertView2;
}

@property (nonatomic) BOOL isChatGroup;

@property (nonatomic) EMConversationType conversationType;

@property (strong, nonatomic) NSMutableArray *dataSource;//tableView数据源
@property (nonatomic, strong) NSMutableArray *arrayUnReadMsgs;
@property (strong, nonatomic) SRRefreshView *slimeView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) DXMessageToolBar *chatToolBar;

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (strong, nonatomic) MessageReadManager *messageReadManager;//message阅读的管理者
@property (strong, nonatomic) EMConversation *conversation;//会话管理者
@property (strong, nonatomic) NSDate *chatTagDate;

@property (strong, nonatomic) NSMutableArray *messages;
@property (nonatomic) BOOL isScrollToBottom;
@property (nonatomic) BOOL isPlayingAudio;
@property (nonatomic) BOOL isKicked;
@property (nonatomic) BOOL isRobot;

//悬浮view
@property (nonatomic, strong) UIButton *btnQuestionTop;
//邀请评价
@property (nonatomic, strong) UIButton *btnInviteJudge;

// zou 添加常用提示语视图
@property(nonatomic,strong) UITableView *tipsTableView;

@end

@implementation ChatViewController
#pragma mark 邀请评价
- (UIButton *)btnInviteJudge
{
    if (!_btnInviteJudge) {
        _btnInviteJudge = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnInviteJudge setFrame:CGRectMake((ScreenWidth - 80), (ScreenHeight - 200-ScreenHeight/8), 60, 60)];
        [_btnInviteJudge setBackgroundImage:[UIImage imageWithFile:@"btn-chat-invite.png"] forState:UIControlStateNormal];
        [_btnInviteJudge setBackgroundImage:[UIImage imageWithFile:@"btn-chat-invite.png"] forState:UIControlStateSelected];
    }
    [_btnInviteJudge addTarget:self action:@selector(clickBtnInvite) forControlEvents:UIControlEventTouchUpInside];
    return _btnInviteJudge;
}

-(void)topBtnClick:(UIButton *)sender
{
    for (UIView *view in sender.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    sender.selected = !sender.selected;
    
    if (sender.selected==YES)
    {
        
        [sender setFrame:CGRectMake(ScreenWidth - ScreenWidth/9, ScreenHeight/10, ScreenWidth/10, ScreenWidth/15)];

        sender.alpha = 0.7;
        [sender setNeedsDisplay];
    }
    else if (sender.selected==NO)
    {
        
        [sender setFrame:CGRectMake(ScreenWidth - ScreenWidth/3, ScreenHeight/40, ScreenWidth/4, ScreenWidth/5)];
        [sender setTitleColor:SystemGreenColor forState:UIControlStateNormal];
        [sender setTitleColor:SystemGreenColor forState:UIControlStateSelected];
        [sender.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
        [sender setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenWidth/50, ScreenWidth/6, ScreenWidth/6)];
        label.text = self.strTopTitle;
        label.textColor =SystemGreenColor;
        label.font = [UIFont systemFontOfSize:14];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        [sender addSubview:label];


        sender.alpha = 0.7;
        sender.adjustsImageWhenHighlighted = NO;
        [sender setNeedsDisplay];
    }

}


- (instancetype)initWithChatter:(NSString *)chatter isGroup:(BOOL)isGroup
{
    EMConversationType type = isGroup ? eConversationTypeGroupChat : eConversationTypeChat;
    self = [self initWithChatter:chatter conversationType:type];
    if (self) {
    }
    
    return self;
}

- (instancetype)initWithChatter:(NSString *)chatter conversationType:(EMConversationType)type
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _isPlayingAudio = NO;
        _chatter = chatter;
        _conversationType = type;
        _messages = [NSMutableArray array];
//        _isRobot = [[RobotManager sharedInstance] isRobotWithUsername:chatter];
        
        //根据接收者的username获取当前会话的管理者
        _conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:chatter conversationType:type];
        [_conversation markAllMessagesAsRead:YES];
    }
    
    return self;
}

- (void)setupBarButtonItem
{
    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btnRight setTitleColor:SystemGrayColor forState:UIControlStateNormal];
    [btnRight setImage:[UIImage imageNamed:@"liebiao.png"] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(clickNaviItemRight) forControlEvents:UIControlEventTouchUpInside];
    [btnRight.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
}

- (BOOL)isChatGroup
{
    return _conversationType != eConversationTypeChat;
}

- (void)saveChatroom:(EMChatroom *)chatroom
{
    NSString *chatroomName = chatroom.chatroomSubject ? chatroom.chatroomSubject : @"";
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:@"username" ]];
    NSMutableDictionary *chatRooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
    if (![chatRooms objectForKey:chatroom.chatroomId])
    {
        [chatRooms setObject:chatroomName forKey:chatroom.chatroomId];
        [ud setObject:chatRooms forKey:key];
        [ud synchronize];
    }
}


- (void)createBtnQuestionTop {
    _btnQuestionTop = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnQuestionTop.selected = YES;
    [_btnQuestionTop setFrame:CGRectMake(ScreenWidth - ScreenWidth/9, ScreenHeight/10, ScreenWidth/10, ScreenWidth/15)];
    [self.btnQuestionTop setBackgroundImage:[UIImage imageWithFile:@"square2.png"] forState:UIControlStateNormal];
    [self.btnQuestionTop setBackgroundImage:[UIImage imageWithFile:@"square_new.png"] forState:UIControlStateSelected];
    [_btnQuestionTop addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.btnQuestionTop];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //增加监听，当键盘出现或改变时收出消息
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow_key:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
    //增加监听，当键退出时收出消息
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide_key:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
      [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
       [self registerBecomeActive];

    [self setTitle:@"育儿问一问"];
    
    self.view.backgroundColor = RGBACOLOR(239, 239, 239, 1);
 
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAllMessages:) name:@"RemoveAllMessages" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitGroup) name:@"ExitGroup" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertCallMessage:) name:@"insertCallMessage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:@"applicationDidEnterBackground" object:nil];
    
    _messageQueue = dispatch_queue_create("easemob.com", NULL);
    _isScrollToBottom = YES;

    [self setupBarButtonItem];
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.slimeView];
    [self.view addSubview:self.chatToolBar];
    
    _mutArrayUserHeader = [NSMutableArray array];
//    将self注册为chatToolBar的moreView的代理
    if ([self.chatToolBar.moreView isKindOfClass:[DXChatBarMoreView class]]) {
        [(DXChatBarMoreView *)self.chatToolBar.moreView setDelegate:self];
    }
  
    //通过会话管理者获取已收发消息
//    long long timestamp = [[NSDate date] timeIntervalSince1970] * 1000 + 1;
//    [self loadMoreMessagesFrom:timestamp count:KPageCount append:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallNotification:) name:@"callOutWithChatter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallNotification:) name:@"callControllerClose" object:nil];
    
    [self.view insertSubview:self.btnQuestionTop aboveSubview:self.tableView];
    
    [self.view insertSubview:self.btnInviteJudge aboveSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemInBackground) name:@"notiInBackground" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemInForeGround) name:@"notiInForeground" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertCallMessage) name:kRequestContactsNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertCallMessage) name:kNewMessageNotification object:nil];
    //获取聊天记录
    _page = 1;
    [self obtainChatHistory:_page];
    [self obtainPersonInfoWithUserId:_chatter];
    _mutChatMore = [NSMutableArray array];
    [self httpRequest];
    [self obtainChatMore];
    [self createBtnQuestionTop];
}



//当键盘出现或改变时调用
//相应键盘事件函数
- (void)keyboardWillShow:(NSNotification *)notif
{
   [UIView animateWithDuration:0.35 animations:^{
       CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
       CGFloat y = rect.origin.y;
       [_btnInviteJudge setFrame:CGRectMake((ScreenWidth - 80), (ScreenHeight - 200-2*y/3-ScreenHeight/8), 60, 60)];
   }];
}
- (void)keyboardWillHide:(NSNotification *)notif
{
    [UIView animateWithDuration:0.35 animations:^{
        [_btnInviteJudge setFrame:CGRectMake((ScreenWidth - 80), (ScreenHeight - 200-ScreenHeight/8), 60, 60)];
    }];
}

-(void)httpRequest
{
    [HTTPRequest httpWithPost:@"/cus/expressionList" Param:@{} Success:^(id obj)
     {
         NSLog(@"这是什么接口 =%@",obj);
         if (SUCCESS)
         {
 
                 if ([[[obj valueForKey:@"data"] valueForKey:@"data"] isKindOfClass:[NSArray class]])
                 {
                     [_mutChatMore removeAllObjects];
                     for (NSDictionary *dic in [[obj valueForKey:@"data"] valueForKey:@"data"])
                     {
                        
                         [_mutChatMore addObject:dic];
                     }
                   
                     [_tableView reloadData];
                 }
            
//             NSLog(@"More=%@",[[obj valueForKey:@"data"] valueForKey:@"data"]);
//             _mutChatMore =[[obj valueForKey:@"data"] valueForKey:@"data"];
//            
//             [self.tableView reloadData];
         }

     } Fail:^(NSString *errorMsg) {
         MBHide
         MBE_Sys
     }];

}
- (void)systemInForeGround
{
    _isEnterBackground = NO;
    [self.arrayUnReadMsgs removeAllObjects];
}

- (void)systemInBackground
{
    _isEnterBackground = YES;
//    [self.arrayUnReadMsgs removeAllObjects];
}


- (void)handleCallNotification:(NSNotification *)notification
{
    id object = notification.object;
    if ([object isKindOfClass:[NSDictionary class]]) {
        //开始call
        self.isInvisible = YES;
    }
    else
    {
        //结束call
        self.isInvisible = NO;
    }
}

- (void)clickNaviItemRight
{
    if (_popUpVC) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            _popUpVC.delegate = nil;
            _popUpVC = nil;
        }];
        
    }
    else {
        _popUpVC = [[PopUpVC alloc] init];
        [_popUpVC setDelegate:self];
//        [self addChildViewController:_popUpVC];
//        [self.view addSubview:_popUpVC.view];
        [self presentPopupViewController:_popUpVC animated:YES completion:nil];
    }
}
- (void)popUpClickIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [self clickBtnInvite];
        }
            break;
        case 2:
        {
            //zou
            ChooseCityVC *chooseVC = [[ChooseCityVC alloc]init];
            chooseVC.isForDocList = YES;
            chooseVC.order_id = _chatter;
            [self.navigationController pushViewController:chooseVC animated:YES];
            
//            DoctorListVC *doctor = [[DoctorListVC alloc] init];
//            [doctor setOrder_id:_chatter];
//            [self.navigationController pushViewController:doctor animated:YES];
        }
            break;
        case 1:
        {
            //执行退回操作
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定退回工单？" message:@"退回则说明不接受或者不再服务此工单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//
//            UIAlertController *
            
            [alert show];
        }
            
            break;
        default:
            break;
    }
    [self clickNaviItemRight];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView ==alertView2)
    {
         UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginVC *loginVC = [story instantiateViewControllerWithIdentifier:@"StoryIDLogin"];
        [HTTPRequest shareRequest].sessionID = nil;
        [self.navigationController pushViewController:loginVC animated:NO];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:@"" forKey:@"PersonIdPhoto"];
        [defaults setValue:@"" forKey:@"PersonWorkPhoto"];
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
        
    }
    else
    {
        if (buttonIndex == 1) {
            MBShow
            [HTTPRequest httpWithPost:@"/order/cancel" Param:@{@"id": [NSString stringWithFormat:@"%@", _chatter]} Success:^(id obj) {
                MBHide
                if (SUCCESS) {
                    [self.navigationController popViewControllerAnimated:NO];
                    if (self.ChatVCBackBlock) {
                        self.ChatVCBackBlock();
                    }
                }
            } Fail:^(NSString *errorMsg) {
                MBHide
                MBE_Sys
            }];
        }
 
    }
   }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"isShowPicker"];
    self.isInvisible = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [EMCDDeviceManager sharedInstance].delegate = nil;
    
    // 设置当前conversation的所有message为已读
    [_conversation markAllMessagesAsRead:YES];
    [[EMCDDeviceManager sharedInstance] disableProximitySensor];
    self.isInvisible = YES;
}

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView = nil;
    
    _slimeView.delegate = nil;
    _slimeView = nil;
    
    _chatToolBar.delegate = nil;
    _chatToolBar = nil;
    
    [[EMCDDeviceManager sharedInstance] stopPlaying];
    [EMCDDeviceManager sharedInstance].delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    
    if (_conversation.conversationType == eConversationTypeChatRoom && !_isKicked)
    {
        //退出聊天室，删除会话
        NSString *chatter = [_chatter copy];
        [[EaseMob sharedInstance].chatManager asyncLeaveChatroom:chatter completion:^(EMChatroom *chatroom, EMError *error){
            [[EaseMob sharedInstance].chatManager removeConversationByChatter:chatter deleteMessages:YES append2Chat:YES];
        }];
    }
    
    if (_imagePicker)
    {
        [_imagePicker dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)back
{
    //判断当前会话是否为空，若符合则删除该会话
    EMMessage *message = [_conversation latestMessage];
    if (message == nil) {
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:_conversation.chatter deleteMessages:NO append2Chat:YES];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setIsInvisible:(BOOL)isInvisible
{
    _isInvisible =isInvisible;
    if (!_isInvisible)
    {
        NSMutableArray *unreadMessages = [NSMutableArray array];
        for (EMMessage *message in self.messages)
        {
            if ([self shouldAckMessage:message read:NO])
            {
                [unreadMessages addObject:message];
            }
        }
        if ([unreadMessages count])
        {
            [self sendHasReadResponseForMessages:unreadMessages];
        }
        
        [_conversation markAllMessagesAsRead:YES];
    }
}

#pragma mark - helper
- (NSURL *)convert2Mp4:(NSURL *)movUrl {
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        mp4Url = [movUrl copy];
        mp4Url = [mp4Url URLByDeletingPathExtension];
        mp4Url = [mp4Url URLByAppendingPathExtension:@"mp4"];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        if (wait) {
            wait = nil;
        }
    }
    
    return mp4Url;
}

#pragma mark - getter
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (NSMutableArray *)arrayUnReadMsgs
{
    if (_arrayUnReadMsgs == nil) {
        _arrayUnReadMsgs = [NSMutableArray array];
    }
    return _arrayUnReadMsgs;
}

- (SRRefreshView *)slimeView
{
    if (_slimeView == nil) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
    }
    
    return _slimeView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.chatToolBar.frame.size.height) style:UITableViewStylePlain];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -33) style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =RGBACOLOR(239, 239, 239, 1);
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        lpgr.minimumPressDuration = .5;
        [_tableView addGestureRecognizer:lpgr];
    }
    
    return _tableView;
}

- (DXMessageToolBar *)chatToolBar
{
    if (_chatToolBar == nil) {
        _chatToolBar = [[DXMessageToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - [DXMessageToolBar defaultHeight], self.view.frame.size.width, [DXMessageToolBar defaultHeight])];
        _chatToolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleRightMargin;
        _chatToolBar.delegate = self;
        
        ChatMoreType type = self.isChatGroup == YES ? ChatMoreTypeGroupChat : ChatMoreTypeChat;
        _chatToolBar.moreView = [[DXChatBarMoreView alloc] initWithFrame:CGRectMake(0, (kVerticalPadding * 2 + kInputTextViewMinHeight), _chatToolBar.frame.size.width, 80) type:type];
        _chatToolBar.moreView.backgroundColor = RGBACOLOR(239, 239, 239, 1);
        _chatToolBar.moreView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
    }
    return _chatToolBar;
}

- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.modalPresentationStyle= UIModalPresentationOverFullScreen;
        _imagePicker.videoMaximumDuration = 10;
        _imagePicker.delegate = self;
    }
    
    return _imagePicker;
}

- (MessageReadManager *)messageReadManager
{
    if (_messageReadManager == nil) {
        _messageReadManager = [MessageReadManager defaultManager];
    }
    
    return _messageReadManager;
}

- (NSDate *)chatTagDate
{
    if (_chatTagDate == nil) {
        _chatTagDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:0];
    }
    
    return _chatTagDate;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return _mutChatMore.count;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        CellChatMore *cell = [CellChatMore cellWithTableView:tableView];
        [cell.imageCheck setHidden:YES];
        if (_indexSelected && [_indexSelected isEqual:indexPath]) {
            [cell.imageCheck setHidden:NO];
        }
        [cell.labTitle setText:[_mutChatMore[indexPath.row] valueForKey:@"content"]];
        return cell;
    }
    
    
//    MessageModel *model = (MessageModel *)obj;
    MessageModel *model = self.dataSource[indexPath.row];
    NSString *cellIdentifier = [EMChatViewCell cellIdentifierForMessageModel:model];
    EMChatViewCell *cell = (EMChatViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[EMChatViewCell alloc] initWithMessageModel:model reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.messageModel = model;
    [cell.nameLabel setHidden:YES];
    
    if (!model.isSender) {
        if (_userDisease) {
            HTTPImgView(cell.headImageView, _userDisease.headurl)
        }
    }
    else {
        BOOL isExit = NO;
        for (NSDictionary *dicTemp in _mutArrayUserHeader) {
            if ([model.username isEqualToString:[NSString stringWithFormat:@"%@", [dicTemp objectForKey:@"userId"]]]) {
                HTTPImgView(cell.headImageView, [dicTemp objectForKey:@"headerUrl"])
                isExit = YES;
            }
        }
        if (!isExit) {
            //解决多次刷新tableView头像无法显示问题，可能是多次请求headerUrl造成的影响
            NSString *strUrl = [HTTPRequest shareRequest].currentUser.headurl;
            if (!strUrl || strUrl.length == 0) {
                HTTPImgView(cell.headImageView, [HTTPRequest shareRequest].currentUser.headurl)
            }
            else {
                NSURL *urlPath = [NSURL URLWithString:strUrl];
                [cell.headImageView sd_setImageWithURL:urlPath];
            }
        }
    }
    
    cell.HeadImageClickBlock = ^(){
        if (!model.isSender) {
            [self clickAvatar];
        }
    };
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        return 34.0;
    }
    
    NSObject *obj = [self.dataSource objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[NSString class]]) {
        return .0f;
    }
    return [EMChatViewCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:(MessageModel *)obj];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        _indexSelected = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
//        [_chatToolBar.moreView reloadData];
        NSString *strText = [_mutChatMore[indexPath.row] valueForKey:@"content"];
        [self sendTextMessage:strText];
        //zou
        [self.tipsTableView removeFromSuperview];
        
    }
    else {
        MessageModel *model = self.dataSource[indexPath.row];
        if (model.type == eMessageBodyType_Image) {
            [self chatImageCellBubblePressed:model];
        }
    }
    
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",cell.class);
}

#pragma mark - scrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_tableView]) {
        [self.chatToolBar endEditing:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_slimeView) {
        [_slimeView scrollViewDidScroll];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_slimeView) {
        [_slimeView scrollViewDidEndDraging];
    }
}

#pragma mark - slimeRefresh delegate
//加载更多
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
//    _chatTagDate = nil;
//    EMMessage *firstMessage = [self.messages firstObject];
//    if (firstMessage)
//    {
//        [self loadMoreMessagesFrom:firstMessage.timestamp count:KPageCount append:YES];
//    }
    
    _page ++;
    [self obtainChatHistory:_page];
    
    [_slimeView endRefresh];
}

#pragma mark - GestureRecognizer

// 点击背景隐藏
-(void)keyBoardHidden:(UIGestureRecognizer *)gesture
{
    if (![gesture.view isEqual:_chatToolBar.moreView]) {
        [self.chatToolBar endEditing:YES];
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan && [self.dataSource count] > 0) {
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        id object = [self.dataSource objectAtIndex:indexPath.row];
        if ([object isKindOfClass:[MessageModel class]]) {
            EMChatViewCell *cell = (EMChatViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell becomeFirstResponder];
            _longPressIndexPath = indexPath;
            [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.messageModel.type];
        }
    }
}

- (void)reloadData{
    _chatTagDate = nil;
//    self.dataSource = [[self formatMessages:self.messages] mutableCopy];
//    [self.tableView reloadData];
    
    //回到前台时
    if (!self.isInvisible)
    {
        NSMutableArray *unreadMessages = [NSMutableArray array];
        for (EMMessage *message in self.messages)
        {
            if ([self shouldAckMessage:message read:NO])
            {
                [unreadMessages addObject:message];
            }
        }
        if ([unreadMessages count])
        {
            [self sendHasReadResponseForMessages:unreadMessages];
        }
        
        [_conversation markAllMessagesAsRead:YES];
    }
}

#pragma mark - UIResponder actions

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    MessageModel *model = [userInfo objectForKey:KMESSAGEKEY];
    
    NSLog(@"dodel:%@",model);
    if ([eventName isEqualToString:kRouterEventTextURLTapEventName]) {
        [self chatTextCellUrlPressed:[userInfo objectForKey:@"url"]];
    }
    else if ([eventName isEqualToString:kRouterEventAudioBubbleTapEventName]) {
        [self chatAudioCellBubblePressed:model];
    }
    else if ([eventName isEqualToString:kRouterEventImageBubbleTapEventName]){
        [self chatImageCellBubblePressed:model];
    }
    else if ([eventName isEqualToString:kRouterEventLocationBubbleTapEventName]){
        [self chatLocationCellBubblePressed:model];
    }
    else if([eventName isEqualToString:kResendButtonTapEventName]){
        EMChatViewCell *resendCell = [userInfo objectForKey:kShouldResendCell];
        MessageModel *messageModel = resendCell.messageModel;
        if ((messageModel.status != eMessageDeliveryState_Failure) && (messageModel.status != eMessageDeliveryState_Pending))
        {
            return;
        }
        id <IChatManager> chatManager = [[EaseMob sharedInstance] chatManager];
        [chatManager asyncResendMessage:messageModel.message progress:nil];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:resendCell];
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    }else if([eventName isEqualToString:kRouterEventChatCellVideoTapEventName]){
        [self chatVideoCellPressed:model];
    }else if ([eventName isEqualToString:kRouterEventMenuTapEventName]) {
        [self sendTextMessage:[userInfo objectForKey:@"text"]];
    }
}

//链接被点击
- (void)chatTextCellUrlPressed:(NSURL *)url
{
    if (url) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

// 语音的bubble被点击
-(void)chatAudioCellBubblePressed:(MessageModel *)model
{
    //zou
    if (model.status == eMessageDeliveryState_Delivered) {
        
        NSLog(@"%@",model.chatVoice.localPath);
        id <IEMFileMessageBody> body = [model.message.messageBodies firstObject];
        EMAttachmentDownloadStatus downloadStatus = [body attachmentDownloadStatus];
        if (downloadStatus == EMAttachmentDownloading) {
            [self showHint:NSLocalizedString(@"message.downloadingAudio", @"downloading voice, click later")];
            return;
        }
        else if (downloadStatus == EMAttachmentDownloadFailure)
        {
            [self showHint:NSLocalizedString(@"message.downloadingAudio", @"downloading voice, click later")];
            [[EaseMob sharedInstance].chatManager asyncFetchMessage:model.message progress:nil];
            
            return;
        }
        
        // 播放音频
        if (model.type == eMessageBodyType_Voice) {
            //发送已读回执
            if ([self shouldAckMessage:model.message read:YES])
            {
                [self sendHasReadResponseForMessages:@[model.message]];
            }
            __weak ChatViewController *weakSelf = self;
            BOOL isPrepare = [self.messageReadManager prepareMessageAudioModel:model updateViewCompletion:^(MessageModel *prevAudioModel, MessageModel *currentAudioModel) {
                if (prevAudioModel || currentAudioModel) {
                    [weakSelf.tableView reloadData];
                }
            }];
            
            if (isPrepare) {
                _isPlayingAudio = YES;
                __weak ChatViewController *weakSelf = self;
                [[EMCDDeviceManager sharedInstance] enableProximitySensor];
                [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath:model.chatVoice.localPath completion:^(NSError *error) {
                    [weakSelf.messageReadManager stopMessageAudioModel];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.tableView reloadData];
                        weakSelf.isPlayingAudio = NO;
                        [[EMCDDeviceManager sharedInstance] disableProximitySensor];
                    });
                }];
            }
            else{
                _isPlayingAudio = NO;
            }
        }

    }
    
    else if(model.status == eMessageDeliveryState_Pending)
    {

        _isPlayingAudio = YES;
        __weak ChatViewController *weakSelf = self;
        [[EMCDDeviceManager sharedInstance] enableProximitySensor];
        [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath:nil completion:^(NSError *error) {
            [weakSelf.messageReadManager stopMessageAudioModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                weakSelf.isPlayingAudio = NO;
                [[EMCDDeviceManager sharedInstance] disableProximitySensor];
            });
        }];
        
        NSString *fileName = [[model.content componentsSeparatedByString:@"/"] lastObject];
        
        NSString *tempPath= NSTemporaryDirectory();
        NSString *savePath = [[tempPath stringByAppendingString:@"audioCash"] stringByAppendingString:[NSString stringWithFormat:@"/%@.mp3",fileName]];
        
        NSURL *url = [NSURL fileURLWithPath:savePath];
        
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        player.delegate = self;
        [player prepareToPlay];
        [player setVolume:2];
        player.numberOfLoops = 1;
        [player play];
    }
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        NSLog(@"play succeed");
    }
}

//位置的bubble被点击
-(void)chatLocationCellBubblePressed:(MessageModel *)model
{
    _isScrollToBottom = NO;
    LocationViewController *locationController = [[LocationViewController alloc] initWithLocation:CLLocationCoordinate2DMake(model.latitude, model.longitude)];
    [self.navigationController pushViewController:locationController animated:YES];
}

// 视频的bubble被点击
- (void)chatVideoCellPressed:(MessageModel *)model
{
    EMVideoMessageBody *videoBody = (EMVideoMessageBody*)model.messageBody;
    if (videoBody.attachmentDownloadStatus == EMAttachmentDownloadSuccessed)
    {
        NSString *localPath = model.message == nil ? model.localPath : [[model.message.messageBodies firstObject] localPath];
        if (localPath && localPath.length > 0)
        {
            //发送已读回执
            if ([self shouldAckMessage:model.message read:YES])
            {
                [self sendHasReadResponseForMessages:@[model.message]];
            }
            [self playVideoWithVideoPath:localPath];
            return;
        }
    }
    
    __weak ChatViewController *weakSelf = self;
    id <IChatManager> chatManager = [[EaseMob sharedInstance] chatManager];
    [weakSelf showHudInView:weakSelf.view hint:NSLocalizedString(@"message.downloadingVideo", @"downloading video...")];
    [chatManager asyncFetchMessage:model.message progress:nil completion:^(EMMessage *aMessage, EMError *error) {
        [weakSelf hideHud];
        if (!error) {
            //发送已读回执
            if ([weakSelf shouldAckMessage:model.message read:YES])
            {
                [weakSelf sendHasReadResponseForMessages:@[model.message]];
            }
            NSString *localPath = aMessage == nil ? model.localPath : [[aMessage.messageBodies firstObject] localPath];
            if (localPath && localPath.length > 0) {
                [weakSelf playVideoWithVideoPath:localPath];
            }
        }else{
            [weakSelf showHint:NSLocalizedString(@"message.videoFail", @"video for failure!")];
        }
    } onQueue:nil];
}

// 播放视频
- (void)playVideoWithVideoPath:(NSString *)videoPath
{
    _isScrollToBottom = NO;
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    MPMoviePlayerViewController *moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
    [moviePlayerController.moviePlayer prepareToPlay];
    moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    [self presentMoviePlayerViewControllerAnimated:moviePlayerController];
}

// 图片的bubble被点击
-(void)chatImageCellBubblePressed:(MessageModel *)model
{
    NSURL *imgUrl = [NSURL URLWithString:model.content];
    [self showHudInView:self.view hint:NSLocalizedString(@"加载中...", @"加载中...")];
    __weak ChatViewController *weakSelf = self;
    id <IChatManager> chatManager = [[EaseMob sharedInstance] chatManager];
    
    [chatManager asyncFetchMessage:model.message progress:self completion:^(EMMessage *aMessage, EMError *error) {
        [weakSelf hideHud];
        if (!error) {
            
//            if (aMessage) {
//                NSLog(@"class-%@",[[aMessage.messageBodies firstObject] messageBodyType]);
//            }
//            
            if (imgUrl) {
                [weakSelf.messageReadManager showBrowserWithImages:@[imgUrl]];
            }
            else
            {
                NSString *localPath = (aMessage == nil) ? model.localPath : [[aMessage.messageBodies firstObject] localPath];
                if (localPath && localPath.length > 0) {
                    UIImage *image = [UIImage imageWithContentsOfFile:localPath];
                    weakSelf.isScrollToBottom = NO;
                    if (image)
                    {
                        [weakSelf.messageReadManager showBrowserWithImages:@[image]];
                    }
                    else
                    {
                        NSLog(@"Read %@ failed!", localPath);
                    }
                }
            }
        }
        else {
            [weakSelf showHint:@"加载图片失败" yOffset:-50];
        }
    } onQueue:nil];

    
    
    
    
    
//    __weak ChatViewController *weakSelf = self;
//    id <IChatManager> chatManager = [[EaseMob sharedInstance] chatManager];
//    if (/*[model.messageBody messageBodyType] == eMessageBodyType_Image*/ model.type == eMessageBodyType_Image) {
//        EMImageMessageBody *imageBody = (EMImageMessageBody *)model.messageBody;
//        if (imageBody.thumbnailDownloadStatus == EMAttachmentDownloadSuccessed) {
//            if (imageBody.attachmentDownloadStatus == EMAttachmentDownloadSuccessed)
//            {
//                //发送已读回执
//                if ([self shouldAckMessage:model.message read:YES])
//                {
//                    [self sendHasReadResponseForMessages:@[model.message]];
//                }
//                NSString *localPath = model.message == nil ? model.localPath : [[model.message.messageBodies firstObject] localPath];
//                if (localPath && localPath.length > 0) {
//                    UIImage *image = [UIImage imageWithContentsOfFile:localPath];
//                    self.isScrollToBottom = NO;
//                    if (image)
//                    {
//                        [self.messageReadManager showBrowserWithImages:@[image]];
//                    }
//                    else
//                    {
//                        NSLog(@"Read %@ failed!", localPath);
//                    }
//                    return ;
//                }
//            }
//            [weakSelf showHudInView:weakSelf.view hint:NSLocalizedString(@"message.downloadingImage", @"downloading a image...")];
//            [chatManager asyncFetchMessage:model.message progress:nil completion:^(EMMessage *aMessage, EMError *error) {
//                [weakSelf hideHud];
//                if (!error) {
//                    //发送已读回执
//                    if ([weakSelf shouldAckMessage:model.message read:YES])
//                    {
//                        [weakSelf sendHasReadResponseForMessages:@[model.message]];
//                    }
//                    NSString *localPath = aMessage == nil ? model.localPath : [[aMessage.messageBodies firstObject] localPath];
//                    if (localPath && localPath.length > 0) {
//                        UIImage *image = [UIImage imageWithContentsOfFile:localPath];
//                        weakSelf.isScrollToBottom = NO;
//                        if (image)
//                        {
//                            [weakSelf.messageReadManager showBrowserWithImages:@[image]];
//                        }
//                        else
//                        {
//                            NSLog(@"Read %@ failed!", localPath);
//                        }
//                        return ;
//                    }
//                }
//                [weakSelf showHint:NSLocalizedString(@"message.imageFail", @"image for failure!")];
//            } onQueue:nil];
//        }else{
//            //获取缩略图
//            [chatManager asyncFetchMessageThumbnail:model.message progress:nil completion:^(EMMessage *aMessage, EMError *error) {
//                if (!error) {
//                    [weakSelf reloadTableViewDataWithMessage:model.message];
//                }else{
//                    [weakSelf showHint:NSLocalizedString(@"message.thumImageFail", @"thumbnail for failure!")];
//                }
//                
//            } onQueue:nil];
//        }
//    }
}

- (void)setProgress:(float)progress forMessage:(EMMessage *)message forMessageBody:(id<IEMMessageBody>)messageBody
{
    NSLog(@"return data: %f", progress);
}


#pragma mark - IChatManagerDelegate

-(void)didSendMessage:(EMMessage *)message error:(EMError *)error
{
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         if ([obj isKindOfClass:[MessageModel class]])
         {
             MessageModel *model = (MessageModel*)obj;
             if ([model.messageId isEqualToString:message.messageId])
             {
                 model.message.deliveryState = message.deliveryState;
                 *stop = YES;
             }
         }
     }];
    [self.tableView reloadData];
}

- (void)didReceiveHasReadResponse:(EMReceipt*)receipt
{
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         if ([obj isKindOfClass:[MessageModel class]])
         {
             MessageModel *model = (MessageModel*)obj;
             if ([model.messageId isEqualToString:receipt.chatId])
             {
                 model.message.isReadAcked = YES;
                 *stop = YES;
             }
         }
     }];
    [self.tableView reloadData];
}

- (void)reloadTableViewDataWithMessage:(EMMessage *)message{
    __weak ChatViewController *weakSelf = self;
    dispatch_async(_messageQueue, ^{
        if ([weakSelf.conversation.chatter isEqualToString:message.conversationChatter])
        {
            for (int i = 0; i < weakSelf.dataSource.count; i ++) {
                id object = [weakSelf.dataSource objectAtIndex:i];
                if ([object isKindOfClass:[MessageModel class]]) {
                    MessageModel *model = (MessageModel *)object;
                    if ([message.messageId isEqualToString:model.messageId]) {
                        MessageModel *cellModel = [MessageModelManager modelWithMessage:message];
                        if ([self->_delelgate respondsToSelector:@selector(nickNameWithChatter:)]) {
                            NSString *showName = [self->_delelgate nickNameWithChatter:model.username];
                            cellModel.nickName = showName?showName:cellModel.username;
                        }else {
                            cellModel.nickName = cellModel.username;
                        }
                        
                        if ([self->_delelgate respondsToSelector:@selector(avatarWithChatter:)]) {
                            cellModel.headImageURL = [NSURL URLWithString:[self->_delelgate avatarWithChatter:cellModel.username]];
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf.tableView beginUpdates];
                            [weakSelf.dataSource replaceObjectAtIndex:i withObject:cellModel];
                            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                            [weakSelf.tableView endUpdates];
                        });
                        break;
                    }
                }
            }
        }
    });
}

- (void)didMessageAttachmentsStatusChanged:(EMMessage *)message error:(EMError *)error{
    if (!error) {
        id<IEMFileMessageBody>fileBody = (id<IEMFileMessageBody>)[message.messageBodies firstObject];
        if ([fileBody messageBodyType] == eMessageBodyType_Image) {
            EMImageMessageBody *imageBody = (EMImageMessageBody *)fileBody;
            if ([imageBody thumbnailDownloadStatus] == EMAttachmentDownloadSuccessed)
            {
                [self reloadTableViewDataWithMessage:message];
            }
        }else if([fileBody messageBodyType] == eMessageBodyType_Video){
            EMVideoMessageBody *videoBody = (EMVideoMessageBody *)fileBody;
            if ([videoBody thumbnailDownloadStatus] == EMAttachmentDownloadSuccessed)
            {
                [self reloadTableViewDataWithMessage:message];
            }
        }else if([fileBody messageBodyType] == eMessageBodyType_Voice){
            if ([fileBody attachmentDownloadStatus] == EMAttachmentDownloadSuccessed)
            {
                [self reloadTableViewDataWithMessage:message];
            }
        }
        
    }else{
        
    }
}

- (void)didFetchingMessageAttachments:(EMMessage *)message progress:(float)progress{
    NSLog(@"didFetchingMessageAttachment: %f", progress);
}

-(void)didReceiveMessage:(EMMessage *)message
{
    NSLog(@"return data: ChatVC %@", message);
    
    if (_isEnterBackground) {
        if (message.messageType == eMessageTypeChat)
        {
            
                       NSString *strCate = [message.ext valueForKey:@"type"];
            if (strCate) {
                if ([strCate intValue]== 2 || [strCate intValue]== 1 || [strCate intValue]== 3)
                {
                    if (![[message.to uppercaseString] isEqualToString:[[HTTPRequest shareRequest].currentUser.username uppercaseString]]) {
                        return;
                    }
                    
                    NSString *strMsg = @"您有新的订单，请及时查收";
                    if ([message.ext valueForKey:@"em_apns_ext"]) {
                        if ([[message.ext valueForKey:@"em_apns_ext"] valueForKey:@"em_push_title"]) {
                            strMsg = [[message.ext valueForKey:@"em_apns_ext"] valueForKey:@"em_push_title"];
                        }
                    }
                    
                    BOOL isExit = NO;
                    for (EMMessage *obj in self.arrayUnReadMsgs) {
                        if ([message.messageId isEqualToString:obj.messageId]) {
                            isExit = YES;
                            break;
                        }
                    }
                   
                    if (!isExit) {
                        [self.arrayUnReadMsgs addObject:message];
                        
                        //发送本地推送
                        UILocalNotification *notification = [[UILocalNotification alloc] init];
                        notification.fireDate = [NSDate date]; //触发通知的时间
                        [notification setHasAction:NO];
                        notification.timeZone = [NSTimeZone defaultTimeZone];
                        [notification setAlertBody:strMsg];
                        notification.soundName= UILocalNotificationDefaultSoundName;
                        //发送通知
                        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
                    }
                    NSInteger unReadMsg = (NSInteger)self.arrayUnReadMsgs.count;
                    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:unReadMsg];
                    
                    
                }
            }
        }
    }
    
    //刷新其他人发布的个数
    NSString *dataStr = [[message valueForKey:@"ext"] valueForKey:@"order_id"];
    if (![_chatter isEqualToString:dataStr])
    {
        NSString *strUnReadKey = [NSString stringWithFormat:@"unRead_%@", dataStr];
        NSString *strUnReadCount = [DEFAULT_USER valueForKey:strUnReadKey];
        if (strUnReadCount) {
            NSInteger unRead = strUnReadCount.integerValue;
            [DEFAULT_USER setValue:[NSString stringWithFormat:@"%zd", ++unRead] forKey:strUnReadKey];
        }
        else
        {
            [DEFAULT_USER setValue:@"1" forKey:strUnReadKey];
        }
        long temp = [[DEFAULT_USER objectForKey:@"firstvalue"] integerValue] + 1;
        [DEFAULT_USER setObject:[NSString stringWithFormat:@"%ld",temp] forKey:@"firstvalue"];
        [AppDelegate shareAppDelegate].tabVC.messageBadgeView.value= temp;
    }
    //刷新其他人发布的个数

    NSString *strCate = [message.ext valueForKey:@"type"];
    if (strCate)
    {
        if ([strCate intValue]== 1)
        {
            message.from = _chatter;
            message.conversationChatter = _chatter;
            
            NSString *strChatter;
            if ([message.ext valueForKey:@"order_id"])
            {
                strChatter = [message.ext valueForKey:@"order_id"];
            }
            
            
            if ([_chatter isEqualToString:strChatter])
            {
                [self addMessage:message];
                if ([self shouldAckMessage:message read:NO])
                {
                    [self sendHasReadResponseForMessages:@[message]];
                }
                if ([self shouldMarkMessageAsRead])
                {
                    [self markMessagesAsRead:@[message]];
                }
            }
        }
    }
}

-(void)didReceiveCmdMessage:(EMMessage *)message
{
    NSLog(@"return data: %@", message);
    if ([_conversation.chatter isEqualToString:message.conversationChatter]) {
        [self showHint:NSLocalizedString(@"receiveCmd", @"receive cmd message")];
    }
}

- (void)didReceiveMessageId:(NSString *)messageId
                    chatter:(NSString *)conversationChatter
                      error:(EMError *)error
{
    NSLog(@"return data: %@", messageId);
    
    if (error && [_conversation.chatter isEqualToString:conversationChatter]) {
        
        __weak ChatViewController *weakSelf = self;
        for (int i = 0; i < self.dataSource.count; i ++) {
            id object = [self.dataSource objectAtIndex:i];
            if ([object isKindOfClass:[MessageModel class]]) {
                MessageModel *currentModel = [self.dataSource objectAtIndex:i];
                EMMessage *currMsg = [currentModel message];
                if ([messageId isEqualToString:currMsg.messageId]) {
                    currMsg.deliveryState = eMessageDeliveryState_Failure;
                    MessageModel *cellModel = [MessageModelManager modelWithMessage:currMsg];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.tableView beginUpdates];
                        [weakSelf.dataSource replaceObjectAtIndex:i withObject:cellModel];
                        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                        [weakSelf.tableView endUpdates];
                        
                    });
                    
                    if (error && error.errorCode == EMErrorMessageContainSensitiveWords)
                    {
                        CGRect frame = self.chatToolBar.frame;
                        [self showHint:NSLocalizedString(@"message.forbiddenWords", @"Your message contains forbidden words") yOffset:-frame.size.height + KHintAdjustY];
                    }
                    break;
                }
            }
        }
    }
}


- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages
{
    if (![offlineMessages count])
    {
        return;
    }
    if ([self shouldMarkMessageAsRead])
    {
        [_conversation markAllMessagesAsRead:YES];
    }
    _chatTagDate = nil;
    long long timestamp = [[NSDate date] timeIntervalSince1970] * 1000 + 1;
    [self loadMoreMessagesFrom:timestamp count:[self.messages count] + [offlineMessages count] append:NO];
}

- (void)group:(EMGroup *)group didLeave:(EMGroupLeaveReason)reason error:(EMError *)error
{
    if (self.isChatGroup && [group.groupId isEqualToString:_chatter]) {
        [self.navigationController popToViewController:self animated:NO];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)didInterruptionRecordAudio
{
    [_chatToolBar cancelTouchRecord];
    
    // 设置当前conversation的所有message为已读
    [_conversation markAllMessagesAsRead:YES];
    
    [self stopAudioPlayingWithChangeCategory:YES];
}

- (void)groupDidUpdateInfo:(EMGroup *)group error:(EMError *)error
{
    if (!error && self.isChatGroup && [_chatter isEqualToString:group.groupId])
    {
        self.title = group.groupSubject;
    }
}

//#pragma mark - IChatManagerDelegate 登录状态变化
//
//- (void)didLoginFromOtherDevice
//{
//    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
//        [self.imagePicker stopVideoCapture];
//    }
//}

- (void)didRemovedFromServer
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

#pragma mark - EMChatBarMoreViewDelegate

- (void)moreViewPhotoAction:(DXChatBarMoreView *)moreView
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"isShowPicker"];
    // 隐藏键盘
    [self keyBoardHidden:nil];
    
    // 弹出照片选择
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
    self.isInvisible = YES;
}

- (void)moreViewTakePicAction:(DXChatBarMoreView *)moreView
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"isShowPicker"];
    [self keyBoardHidden:nil];
    
#if TARGET_IPHONE_SIMULATOR
    [self showHint:NSLocalizedString(@"message.simulatorNotSupportCamera", @"simulator does not support taking picture")];
#elif TARGET_OS_IPHONE
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // zou 去掉视频录制项 (NSString *)kUTTypeMovie
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
    self.isInvisible = YES;
#endif
}

// zou 将发送位置按钮自定义为常用语按钮
- (void)moreViewLocationAction:(DXChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden:nil];
    
    self.tipsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height -34.0 * 4,  _chatToolBar.frame.size.width, 34.0 * 4)];
    self.tipsTableView.tag = 100;
    [self.tipsTableView setDelegate:self];
    [self.tipsTableView setDataSource:self];
   
    [self.view addSubview:self.tipsTableView];
    
    
    
    
//    LocationViewController *locationController = [[LocationViewController alloc] initWithNibName:nil bundle:nil];
//    locationController.delegate = self;
//    [self.navigationController pushViewController:locationController animated:YES];
}

- (void)moreViewAudioCallAction:(DXChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"callOutWithChatter" object:@{@"chatter":self.chatter, @"type":[NSNumber numberWithInt:eCallSessionTypeAudio]}];
}

- (void)moreViewVideoCallAction:(DXChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"callOutWithChatter" object:@{@"chatter":self.chatter, @"type":[NSNumber numberWithInt:eCallSessionTypeVideo]}];
}

#pragma mark - LocationViewDelegate

-(void)sendLocationLatitude:(double)latitude longitude:(double)longitude andAddress:(NSString *)address
{
    NSDictionary *ext = nil;
    if (_isRobot) {
//        ext = @{kRobot_Message_Ext:[NSNumber numberWithBool:YES]};
    }
    EMMessage *locationMessage = [ChatSendHelper sendLocationLatitude:latitude longitude:longitude address:address toUsername:_conversation.chatter messageType:[self messageType] requireEncryption:NO ext:ext];
    [self addMessage:locationMessage];
}

#pragma mark - DXMessageToolBarDelegate
- (void)inputTextViewWillBeginEditing:(XHMessageTextView *)messageInputTextView{
    [_menuController setMenuItems:nil];
}

- (void)didChangeFrameToHeight:(CGFloat)toHeight
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.tableView.frame;
        rect.origin.y = 0;
        rect.size.height = self.view.frame.size.height - toHeight;
        self.tableView.frame = rect;
    }];
    [self scrollViewToBottom:NO];
}

- (void)didSendText:(NSString *)text
{
    if (text && text.length > 0) {
        [self sendTextMessage:text];
    }
}

/**
 *  按下录音按钮开始录音
 */
- (void)didStartRecordingVoiceAction:(UIView *)recordView
{
    if ([self canRecord]) {
        DXRecordView *tmpView = (DXRecordView *)recordView;
        tmpView.center = self.view.center;
        [self.view addSubview:tmpView];
        [self.view bringSubviewToFront:recordView];
        int x = arc4random() % 100000;
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        NSString *fileName = [NSString stringWithFormat:@"%d%d",(int)time,x];

        [[EMCDDeviceManager sharedInstance] asyncStartRecordingWithFileName:fileName
                                                                 completion:^(NSError *error)
         {
             if (error) {
                 NSLog(NSLocalizedString(@"message.startRecordFail", @"failure to start recording"));
             }
         }];
    }
}

/**
 *  手指向上滑动取消录音
 */
- (void)didCancelRecordingVoiceAction:(UIView *)recordView
{
    [[EMCDDeviceManager sharedInstance] cancelCurrentRecording];
}

/**
 *  松开手指完成录音
 */
- (void)didFinishRecoingVoiceAction:(UIView *)recordView
{
    __weak typeof(self) weakSelf = self;
    [[EMCDDeviceManager sharedInstance] asyncStopRecordingWithCompletion:^(NSString *recordPath, NSInteger aDuration, NSError *error) {
        if (!error) {
            EMChatVoice *voice = [[EMChatVoice alloc] initWithFile:recordPath
                                                       displayName:@"audio"];
            voice.duration = aDuration;
            [weakSelf sendAudioMessage:voice];
        }else {
            [weakSelf showHudInView:self.view hint:NSLocalizedString(@"media.timeShort", @"The recording time is too short")];
            weakSelf.chatToolBar.recordButton.enabled = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf hideHud];
                weakSelf.chatToolBar.recordButton.enabled = YES;
            });
        }
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *videoURL = info[UIImagePickerControllerMediaURL];
        [picker dismissViewControllerAnimated:YES completion:^{
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"isShowPicker"];
        }];
        // video url:
        // file:///private/var/mobile/Applications/B3CDD0B2-2F19-432B-9CFA-158700F4DE8F/tmp/capture-T0x16e39100.tmp.9R8weF/capturedvideo.mp4
        // we will convert it to mp4 format
        NSURL *mp4 = [self convert2Mp4:videoURL];
        NSFileManager *fileman = [NSFileManager defaultManager];
        if ([fileman fileExistsAtPath:videoURL.path]) {
            NSError *error = nil;
            [fileman removeItemAtURL:videoURL error:&error];
            if (error) {
                NSLog(@"failed to remove file, error:%@.", error);
            }
        }
        EMChatVideo *chatVideo = [[EMChatVideo alloc] initWithFile:[mp4 relativePath] displayName:@"video.mp4"];
        [self sendVideoMessage:chatVideo];
        
    }else{
        UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:^{
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"isShowPicker"];
        }];
        [self sendImageMessage:orgImage];
    }
    self.isInvisible = NO;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"isShowPicker"];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    self.isInvisible = NO;
}

#pragma mark - MenuItem actions

- (void)copyMenuAction:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (_longPressIndexPath.row > 0) {
        MessageModel *model = [self.dataSource objectAtIndex:_longPressIndexPath.row];
        pasteboard.string = model.content;
    
    
//    NSLog(@"model.content== %@",model.content);
    if (model.content.length > 50)
    {
        NSString *str = [model.content substringToIndex:50];
        
        pasteboard.string = str;
        NSLog(@"jie = %@", model.content);
        
//        NSLog(@"pasteboard.string==%@",pasteboard.string);
        
        
        NSString *msg = @"亲,复制内容不能超过50个字哦";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OKaction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:OKaction];
        [self presentViewController:alert animated:YES completion:nil];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    else
    {
        pasteboard.string = model.content;
    }
    
    
    
}
_longPressIndexPath = nil;

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int  remainTextNum=100;
    //计算剩下多少文字可以输入
    if(range.location>=100)
    {
        remainTextNum=0;
        
        return NO;
    }
    else
    {
        NSString  *nsTextContentStr = string;
        int   existTextNum=[nsTextContentStr length];
        remainTextNum=100-existTextNum;
        return YES;
    }
    
}

- (void)deleteMenuAction:(id)sender
{
    if (_longPressIndexPath && _longPressIndexPath.row > 0) {
        MessageModel *model = [self.dataSource objectAtIndex:_longPressIndexPath.row];
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSetWithIndex:_longPressIndexPath.row];
        [_conversation removeMessage:model.message];
        [self.messages removeObject:model.message];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:_longPressIndexPath, nil];;
        if (_longPressIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataSource objectAtIndex:(_longPressIndexPath.row - 1)];
            if (_longPressIndexPath.row + 1 < [self.dataSource count]) {
                nextMessage = [self.dataSource objectAtIndex:(_longPressIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [indexs addIndex:_longPressIndexPath.row - 1];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(_longPressIndexPath.row - 1) inSection:0]];
            }
        }
        
        [self.dataSource removeObjectsAtIndexes:indexs];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    
    _longPressIndexPath = nil;
}

#pragma mark - private

- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                bCanRecord = granted;
            }];
        }
    }
    
    return bCanRecord;
}

- (void)stopAudioPlayingWithChangeCategory:(BOOL)isChange
{
    //停止音频播放及播放动画
    [[EMCDDeviceManager sharedInstance] stopPlaying];
    [[EMCDDeviceManager sharedInstance] disableProximitySensor];
    [EMCDDeviceManager sharedInstance].delegate = nil;
    MessageModel *playingModel = [self.messageReadManager stopMessageAudioModel];
    NSIndexPath *indexPath = nil;
    if (playingModel) {
        indexPath = [NSIndexPath indexPathForRow:[self.dataSource indexOfObject:playingModel] inSection:0];
    }
    
    if (indexPath) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        });
    }
}

- (void)loadMoreMessagesFrom:(long long)timestamp count:(NSInteger)count append:(BOOL)append
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(_messageQueue, ^{
        NSArray *messages = [weakSelf.conversation loadNumbersOfMessages:count before:timestamp];
        if ([messages count] > 0) {
            NSInteger currentCount = 0;
            if (append)
            {
                [weakSelf.messages insertObjects:messages atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [messages count])]];
                NSArray *formated = [weakSelf formatMessages:messages];
                id model = [weakSelf.dataSource firstObject];
                if ([model isKindOfClass:[NSString class]])
                {
                    NSString *timestamp = model;
                    [formated enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id model, NSUInteger idx, BOOL *stop) {
                        if ([model isKindOfClass:[NSString class]] && [timestamp isEqualToString:model])
                        {
                            [weakSelf.dataSource removeObjectAtIndex:0];
                            *stop = YES;
                        }
                    }];
                }
                currentCount = [weakSelf.dataSource count];
                [weakSelf.dataSource insertObjects:formated atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [formated count])]];
                
                EMMessage *latest = [weakSelf.messages lastObject];
                weakSelf.chatTagDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)latest.timestamp];
            }
            else
            {
                weakSelf.messages = [messages mutableCopy];
                weakSelf.dataSource = [[weakSelf formatMessages:messages] mutableCopy];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                if (weakSelf.dataSource.count > 0) {
                    [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[weakSelf.dataSource count] - currentCount - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            });
            
            //从数据库导入时重新下载没有下载成功的附件
            for (EMMessage *message in messages)
            {
                [weakSelf downloadMessageAttachments:message];
            }
            
            NSMutableArray *unreadMessages = [NSMutableArray array];
            for (NSInteger i = 0; i < [messages count]; i++)
            {
                EMMessage *message = messages[i];
                if ([self shouldAckMessage:message read:NO])
                {
                    [unreadMessages addObject:message];
                }
            }
            if ([unreadMessages count])
            {
                [self sendHasReadResponseForMessages:unreadMessages];
            }
        }
    });
}

- (void)downloadMessageAttachments:(EMMessage *)message
{
    __weak typeof(self) weakSelf = self;
    void (^completion)(EMMessage *aMessage, EMError *error) = ^(EMMessage *aMessage, EMError *error) {
        if (!error)
        {
            [weakSelf reloadTableViewDataWithMessage:message];
        }
        else
        {
            [weakSelf showHint:NSLocalizedString(@"message.thumImageFail", @"thumbnail for failure!")];
        }
    };
    
    id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
    if ([messageBody messageBodyType] == eMessageBodyType_Image) {
        EMImageMessageBody *imageBody = (EMImageMessageBody *)messageBody;
        if (imageBody.thumbnailDownloadStatus > EMAttachmentDownloadSuccessed)
        {
            //下载缩略图
            [[[EaseMob sharedInstance] chatManager] asyncFetchMessageThumbnail:message progress:nil completion:completion onQueue:nil];
        }
    }
    else if ([messageBody messageBodyType] == eMessageBodyType_Video)
    {
        EMVideoMessageBody *videoBody = (EMVideoMessageBody *)messageBody;
        if (videoBody.thumbnailDownloadStatus > EMAttachmentDownloadSuccessed)
        {
            //下载缩略图
            [[[EaseMob sharedInstance] chatManager] asyncFetchMessageThumbnail:message progress:nil completion:completion onQueue:nil];
        }
    }
    else if ([messageBody messageBodyType] == eMessageBodyType_Voice)
    {
        EMVoiceMessageBody *voiceBody = (EMVoiceMessageBody*)messageBody;
        if (voiceBody.attachmentDownloadStatus > EMAttachmentDownloadSuccessed)
        {
            //下载语言
            [[EaseMob sharedInstance].chatManager asyncFetchMessage:message progress:nil];
        }
    }
}

- (NSArray *)formatMessages:(NSArray *)messagesArray
{
    NSMutableArray *formatArray = [[NSMutableArray alloc] init];
    if ([messagesArray count] > 0) {
        for (EMMessage *message in messagesArray) {
            NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
            NSTimeInterval tempDate = [createDate timeIntervalSinceDate:self.chatTagDate];
            if (tempDate > 60 || tempDate < -60 || (self.chatTagDate == nil)) {
                [formatArray addObject:[createDate formattedTime]];
                self.chatTagDate = createDate;
            }
            
            MessageModel *model = [MessageModelManager modelWithMessage:message];
            if ([_delelgate respondsToSelector:@selector(nickNameWithChatter:)]) {
                NSString *showName = [_delelgate nickNameWithChatter:model.username];
                model.nickName = showName?showName:model.username;
            }else {
                model.nickName = model.username;
            }
            
            if ([_delelgate respondsToSelector:@selector(avatarWithChatter:)]) {
                model.headImageURL = [NSURL URLWithString:[_delelgate avatarWithChatter:model.username]];
            }
            
            if (model) {
                [formatArray addObject:model];
            }
        }
    }
    
    return formatArray;
}

-(NSMutableArray *)formatMessage:(EMMessage *)message
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
    NSTimeInterval tempDate = [createDate timeIntervalSinceDate:self.chatTagDate];
    if (tempDate > 60 || tempDate < -60 || (self.chatTagDate == nil)) {
        [ret addObject:[createDate formattedTime]];
        self.chatTagDate = createDate;
    }
    
    MessageModel *model = [MessageModelManager modelWithMessage:message];
    if ([_delelgate respondsToSelector:@selector(nickNameWithChatter:)]) {
        NSString *showName = [_delelgate nickNameWithChatter:model.username];
        model.nickName = showName?showName:model.username;
    }else {
        model.nickName = model.username;
    }
    
//        model.type = eMessageBodyType_Text;
    if ([message.ext valueForKey:@"msgtype"]) {
        if ([[message.ext valueForKey:@"msgtype"] isEqualToString:@"picture"]) {
            model.type = eMessageBodyType_Image;
        }
        //zou
        else if ([[message.ext valueForKey:@"msgtype"] isEqualToString:@"audio"])
        {
            model.type = eMessageBodyType_Voice;
        }
        //end
    }
    
    if ([_delelgate respondsToSelector:@selector(avatarWithChatter:)]) {
        model.headImageURL = [NSURL URLWithString:[_delelgate avatarWithChatter:model.username]];
    }

    if (model) {
        [ret addObject:model];
    }
    
    return ret;
}

-(void)addMessage:(EMMessage *)message
{
    
    //zou
    id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
   
    if (messageBody.messageBodyType == eMessageBodyType_Text) {
        NSLog(@"%@",((EMTextMessageBody *)messageBody).text);
        
        NSString *huanxinMsg = [ConvertToCommonEmoticonsHelper convertHuanXinEmoticons:((EMTextMessageBody *)messageBody).text];
        
        ((EMTextMessageBody *)messageBody).text = huanxinMsg;
    }
    
    [_messages addObject:message];
    
    //end
    
    __weak ChatViewController *weakSelf = self;
    dispatch_async(_messageQueue, ^{
        NSArray *messages = [weakSelf formatMessage:message];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            for (id obj in messages) {
                if ([obj isKindOfClass:[MessageModel class]]) {
                    [weakSelf.dataSource addObject:obj];
                }
            }
//            [weakSelf.dataSource addObjectsFromArray:messages];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[weakSelf.dataSource count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        });
    });
}

- (void)scrollViewToBottom:(BOOL)animated
{
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:animated];
    }
}

- (void)showRoomContact:(id)sender
{
    [self.view endEditing:YES];
    if (self.conversationType == eConversationTypeGroupChat) {
//        ChatGroupDetailViewController *detailController = [[ChatGroupDetailViewController alloc] initWithGroupId:_chatter];
//        [self.navigationController pushViewController:detailController animated:YES];
    }
    else if (self.conversationType == eConversationTypeChatRoom)
    {
//        ChatroomDetailViewController *detailController = [[ChatroomDetailViewController alloc] initWithChatroomId:_chatter];
//        [self.navigationController pushViewController:detailController animated:YES];
    }
}

- (void)removeAllMessages:(id)sender
{
    
    
//    if (_dataSource.count == 0) {
//        [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
//        return;
//    }
//    
//    if ([sender isKindOfClass:[NSNotification class]]) {
//        NSString *groupId = (NSString *)[(NSNotification *)sender object];
//        if (self.isChatGroup && [groupId isEqualToString:_conversation.chatter]) {
//            [_conversation removeAllMessages];
//            [_messages removeAllObjects];
//            _chatTagDate = nil;
//            [_dataSource removeAllObjects];
//            [_tableView reloadData];
//            [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
//        }
//    }
//    else{
//        __weak typeof(self) weakSelf = self;
//        
//        [EMAlertView showAlertWithTitle:NSLocalizedString(@"prompt", @"Prompt")
//                                message:NSLocalizedString(@"sureToDelete", @"please make sure to delete")
//                        completionBlock:^(NSUInteger buttonIndex, EMAlertView *alertView) {
//                            if (buttonIndex == 1) {
//                                [weakSelf.conversation removeAllMessages];
//                                [weakSelf.messages removeAllObjects];
//                                weakSelf.chatTagDate = nil;
//                                [weakSelf.dataSource removeAllObjects];
//                                [weakSelf.tableView reloadData];
//                            }
//                        } cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel")
//                      otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
//    }
}

- (void)showMenuViewController:(UIView *)showInView andIndexPath:(NSIndexPath *)indexPath messageType:(MessageBodyType)messageType
{
    if (_menuController == nil) {
        _menuController = [UIMenuController sharedMenuController];
    }
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"复制", @"Copy") action:@selector(copyMenuAction:)];
    }
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"删除", @"Delete") action:@selector(deleteMenuAction:)];
    }
    
    if (messageType == eMessageBodyType_Text) {
        [_menuController setMenuItems:@[_copyMenuItem, _deleteMenuItem]];
    }
    else{
        [_menuController setMenuItems:@[_deleteMenuItem]];
    }
    
    [_menuController setTargetRect:showInView.frame inView:showInView.superview];
    [_menuController setMenuVisible:YES animated:YES];
}

- (void)exitGroup
{
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)insertCallMessage:(NSNotification *)notification
{
    id object = notification.object;
    if (object) {
        EMMessage *message = (EMMessage *)object;
        [self addMessage:message];
        [[EaseMob sharedInstance].chatManager insertMessageToDB:message append2Chat:YES];
    }
}

- (void)applicationDidEnterBackground
{
    [_chatToolBar cancelTouchRecord];
    
    // 设置当前conversation的所有message为已读
    [_conversation markAllMessagesAsRead:YES];
    
    //移除对应代理
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (BOOL)shouldAckMessage:(EMMessage *)message read:(BOOL)read
{
    NSString *account = [[EaseMob sharedInstance].chatManager loginInfo][kSDKUsername];
    if (message.messageType != eMessageTypeChat || message.isReadAcked || [account isEqualToString:message.from] || ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground))
    {
        return NO;
    }
    
    id<IEMMessageBody> body = [message.messageBodies firstObject];
    if (((body.messageBodyType == eMessageBodyType_Video) ||
         (body.messageBodyType == eMessageBodyType_Voice) ||
         (body.messageBodyType == eMessageBodyType_Image)) &&
        !read)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (BOOL)shouldMarkMessageAsRead
{
    if (([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) || self.isInvisible)
    {
        return NO;
    }
    
    return YES;
}

- (EMMessageType)messageType
{
    EMMessageType type = eMessageTypeChat;
    switch (_conversationType) {
        case eConversationTypeChat:
            type = eMessageTypeChat;
            break;
        case eConversationTypeGroupChat:
            type = eMessageTypeGroupChat;
            break;
        case eConversationTypeChatRoom:
            type = eMessageTypeChatRoom;
            break;
        default:
            break;
    }
    return type;
}

#pragma mark - public

- (void)hideImagePicker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    self.isInvisible = NO;
}

#pragma mark - send message

-(void)sendTextMessage:(NSString *)textMessage
{
    NSDictionary *ext = nil;
    EMMessage *tempMessage = [ChatSendHelper sendTextMessageWithString:textMessage
                                                            toUsername:_conversation.chatter
                                                           messageType:[self messageType]
                                                     requireEncryption:NO
                                                                   ext:ext];
    [self addMessage:tempMessage];
    
    //zou
    NSLog(@"return data: ChatVC-text %@", tempMessage);
  
//   NSString *testM = [ConvertToCommonEmoticonsHelper convertToWebChatEmoticons:textMessage];
    
    [HTTPRequest httpWithPost:@"/order/chat" Param:@{@"id": _chatter, @"content": [NSString stringWithFormat:@"%@", textMessage]} Success:^(id obj) {
        if (SUCCESS) {
            NSLog(@"return data: 成功啦");
        }
    } Fail:^(NSString *errorMsg) {
        MBE_Sys
    }];
}

-(void)sendImageMessage:(UIImage *)image
{
    NSDictionary *ext = nil;
    EMMessage *tempMessage = [ChatSendHelper sendImageMessageWithImage:image
                                                            toUsername:_conversation.chatter
                                                           messageType:[self messageType]
                                                     requireEncryption:NO
                                                                   ext:ext];
    [self addMessage:tempMessage];
    
    //zou
    NSLog(@"return data: ChatVC-image %@", tempMessage);
    NSLog(@"type:%d",tempMessage.messageType);
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"picture",@"type",[NSNumber numberWithInt:[_chatter intValue]],@"id", nil];
    
    [HTTPRequest httpWithUploadMedia:image Param:params Type:eMessageBodyType_Image Success:^(id obj) {
        if (SUCCESS) {
            NSLog(@"上传图片成功！");
        }
    } Fail:^(NSString *errorMsg) {
        NSLog(@"上传图片失败：%@", errorMsg);
    }];
}

-(void)sendAudioMessage:(EMChatVoice *)voice
{
    NSDictionary *ext = nil;
    EMMessage *tempMessage = [ChatSendHelper sendVoice:voice
                                            toUsername:_conversation.chatter
                                           messageType:[self messageType]
                                     requireEncryption:NO ext:ext];
    [self addMessage:tempMessage];
    
    NSLog(@"%@",voice.messageBody);
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"audio",@"type",[NSNumber numberWithInt:[_chatter intValue]],@"id", nil];
    
    NSData *voiceData = [NSData dataWithContentsOfFile:voice.localPath];
    
    [HTTPRequest httpWithUploadMedia:voiceData Param:params Type:eMessageBodyType_Voice Success:^(id obj) {
        if (SUCCESS) {
            NSLog(@"成功啦");
        }
    } Fail:^(NSString *errorMsg) {
        NSLog(@"出错啦——%@",errorMsg);
    }];
    
    NSLog(@"....:%@",[[NSString alloc]initWithData:voiceData encoding:NSUTF8StringEncoding]);
}

-(void)sendVideoMessage:(EMChatVideo *)video
{
    NSDictionary *ext = nil;
    
    EMMessage *tempMessage = [ChatSendHelper sendVideo:video
                                            toUsername:_conversation.chatter
                                           messageType:[self messageType]
                                     requireEncryption:NO ext:ext];
    [self addMessage:tempMessage];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"video",@"type",[NSNumber numberWithInt:[_chatter intValue]],@"id", nil];
    
    NSData *videoData = [NSData dataWithContentsOfFile:video.localPath];
    
    [HTTPRequest httpWithUploadMedia:videoData Param:params Type:eMessageBodyType_Video Success:^(id obj) {
        if (SUCCESS) {
            NSLog(@"成功啦");
        }
    } Fail:^(NSString *errorMsg) {
        NSLog(@"出错啦——%@",errorMsg);
    }];
}

- (void)sendHasReadResponseForMessages:(NSArray*)messages
{
    dispatch_async(_messageQueue, ^{
        for (EMMessage *message in messages)
        {
            [[EaseMob sharedInstance].chatManager sendReadAckForMessage:message];
        }
    });
}

- (void)markMessagesAsRead:(NSArray*)messages
{
    EMConversation *conversation = _conversation;
    dispatch_async(_messageQueue, ^{
        for (EMMessage *message in messages)
        {
            [conversation markMessageWithId:message.messageId asRead:YES];
        }
    });
}

#pragma mark - EMCDDeviceManagerDelegate
- (void)proximitySensorChanged:(BOOL)isCloseToUser{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if (isCloseToUser)
    {
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    } else {
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        if (!_isPlayingAudio) {
            [[EMCDDeviceManager sharedInstance] disableProximitySensor];
        }
    }
    [audioSession setActive:YES error:nil];
}

#pragma mark - EMChatManagerChatroomDelegate

- (void)chatroom:(EMChatroom *)chatroom occupantDidJoin:(NSString *)username
{
    CGRect frame = self.chatToolBar.frame;
    [self showHint:[NSString stringWithFormat:NSLocalizedString(@"chatroom.join", @"\'%@\'join chatroom\'%@\'"), username, chatroom.chatroomId] yOffset:-frame.size.height + KHintAdjustY];
}

- (void)chatroom:(EMChatroom *)chatroom occupantDidLeave:(NSString *)username
{
    CGRect frame = self.chatToolBar.frame;
    [self showHint:[NSString stringWithFormat:NSLocalizedString(@"chatroom.leave", @"\'%@\'leave chatroom\'%@\'"), username, chatroom.chatroomId] yOffset:-frame.size.height + KHintAdjustY];
}

- (void)beKickedOutFromChatroom:(EMChatroom *)chatroom reason:(EMChatroomBeKickedReason)reason
{
    if ([_chatter isEqualToString:chatroom.chatroomId])
    {
        _isKicked = YES;
        CGRect frame = self.chatToolBar.frame;
        [self showHint:[NSString stringWithFormat:NSLocalizedString(@"chatroom.remove", @"be removed from chatroom\'%@\'"), chatroom.chatroomId] yOffset:-frame.size.height + KHintAdjustY];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - ICallManagerDelegate

- (void)callSessionStatusChanged:(EMCallSession *)callSession changeReason:(EMCallStatusChangedReason)reason error:(EMError *)error
{
    if (reason == eCallReasonNull) {
        if ([[EMCDDeviceManager sharedInstance] isPlaying]) {
            [self stopAudioPlayingWithChangeCategory:NO];
        }
    }
}

#pragma mark 点击头像
- (void)clickAvatar
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserInfoVC *userInfo = [story instantiateViewControllerWithIdentifier:@"StoryIDUserInfo"];
    userInfo.user = _userDisease;
    userInfo.orderId = _chatter;
    if (!userInfo.UserInfoVCBlock) {
        userInfo.UserInfoVCBlock = ^(){
            _userDisease = nil;
            [self obtainPersonInfoWithUserId:_chatter];
        };
    }
    [self.navigationController pushViewController:userInfo animated:YES];
}
#pragma mark 邀请评价
- (void)clickBtnInvite
{
    MBShow
    [HTTPRequest httpWithPost:@"/order/evaluation" Param:@{@"id": _chatter} Success:^(id obj) {
        if (SUCCESS) {
            MBHide
            [[NSNotificationCenter defaultCenter] postNotificationName:kRequestContactsNotification object:nil];
            MBS(@"请求已发送")
        }
        else {
            MBHide
            MESSAGE
        }
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}

#pragma mark 获取聊天记录
- (void)obtainChatHistory:(NSInteger)page
{
    
    NSString *path = NSHomeDirectory();
    NSString *cachePath = @"Library/Caches/temp";
    NSString *fullPath = [path stringByAppendingPathComponent:cachePath];
    
    //确定文件是否存在
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"file.txt"];
//    BOOL fileExists = [fileManager fileExistsAtPath:filePath];
//    if (!fileExists) {
//        
//        BOOL success = [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
//        
//        if (success) {
//            
//        }
//    }
    MBShow
    [HTTPRequest httpWithPost:@"/order/history" Param:@{@"id": [NSNumber numberWithInt:[_chatter intValue]], @"time": [NSNumber numberWithLongLong:[NSDate dateToSeconds:[NSDate date]]], @"pageNo": [NSNumber numberWithInteger:page], @"pageSize": [NSNumber numberWithInt:10]} Success:^(id obj) {
        if (SUCCESS) {
            
            if ([[obj valueForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                NSArray *arrayHistory = [[obj valueForKey:@"data"] valueForKey:@"list"];
                for (NSDictionary *dicMsg in arrayHistory) {
                    MessageModel *mess = [[MessageModel alloc] init];
                    mess.isSender = NO;
                    mess.isRead = YES;
                    if ([[dicMsg valueForKey:@"msgtype"] isEqualToString:@"picture"]) {
                        mess.type = eMessageBodyType_Image;
                    }
                    else if([[dicMsg valueForKey:@"msgtype"] isEqualToString:@"audio"]){
                        mess.type = eMessageBodyType_Voice;
                    }else if ([[dicMsg valueForKey:@"msgtype"] isEqualToString:@"video"])
                    {
                        mess.type =eMessageBodyType_Video;
                    }
                    else
                    {
                        mess.type = eMessageBodyType_Text;
                    }
                    mess.headImageURL = nil;
                    
                    //zou
                    if (mess.type == eMessageBodyType_Text) {
                        NSString *convertStr = [ConvertToCommonEmoticonsHelper convertHuanXinEmoticons:[dicMsg valueForKey:@"content"]];
                        mess.content = convertStr;
                        NSLog(@"%@",convertStr);
                        //end
                     }else
                     {
                         mess.content = [dicMsg valueForKey:@"content"];
                         //zou
                         if (mess.type == eMessageBodyType_Voice) {
                             [self downloadAudioToCashWithURl:mess.content];
                         }//end
                     }
                    
                    mess.status = eMessageDeliveryState_Delivered;
                    mess.username = [NSString stringWithFormat:@"%@", [dicMsg valueForKey:@"sender_id"]];
                    NSString *str = [NSString stringWithFormat:@"%@", [dicMsg valueForKey:@"sender_type"]];
                    
                    if ([str isEqualToString:@"1"] || [str isEqualToString:@"2"]) {
                        //发送消息的人是医生，显示在右侧
                        mess.isSender = YES;
                        if (![mess.username isEqualToString:[NSString stringWithFormat:@"%ld", [HTTPRequest shareRequest].currentUser.User_id]]) {
                            
                            NSString *strHeaderUrl = [NSString stringWithFormat:@"%@", [dicMsg valueForKey:@"headurl"]];
                            BOOL isExit = NO;
                            for (NSDictionary *dic in _mutArrayUserHeader) {
                                if ([strHeaderUrl isEqualToString:[dic objectForKey:@"userId"]]) {
                                    isExit = YES;
                                }
                            }
                            if (!isExit) {
                                [_mutArrayUserHeader addObject:@{@"userId": mess.username, @"headerUrl": strHeaderUrl}];
                            }
                        }
                    }else {
//                        [self obtainPersonInfoWithUserId:mess.username];
                    }
                    //zou
                    NSLog(@"message data: %@",mess);
                    
                    [self.dataSource insertObject:mess atIndex:0];
                    
                    
                }
                [self.tableView reloadData];
                if (_page == 1) {
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataSource count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                }
            }
        }
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}

#pragma mark 获取病人信息
- (void)obtainPersonInfoWithUserId:(NSString *)userId
{
    if (_userDisease) {
        return;
    }
    
    [HTTPRequest httpWithGet:@"/order/consulter" Param:@{@"id": userId} Success:^(id obj) {
        if (SUCCESS) {
           
            User *user = [JsonToModel objectFromDic:[obj valueForKey:@"data"] className:@"User"];
            _userDisease = user;
            [_tableView reloadData];
        }
    } Fail:^(NSString *errorMsg) {
        MBE_Sys
    }];
}

- (void)obtainChatMore
{
    [HTTPRequest httpWithPost:@"/cus/usualReply" Param:@{} Success:^(id obj)
    {
         NSLog(@"这是什么接口 =%@",obj);
        if (SUCCESS)
        {
            if ([[obj valueForKey:@"data"] isKindOfClass:[NSArray class]])
            {
//                [_mutChatMore removeAllObjects];
//                for (NSDictionary *dic in [obj valueForKey:@"data"])
//                {
//                    [_mutChatMore addObject:dic];
//                }
                
                //获取消息后，所有对应未读消息置为0
                NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                NSString *strUnReadKey = [NSString stringWithFormat:@"unRead_%@", _chatter];
                [userDef removeObjectForKey:strUnReadKey];
                
                [_tableView reloadData];
            }
        }
    } Fail:^(NSString *errorMsg) {
        
    }];
}

//zou 下载音频到缓存
-(void)downloadAudioToCashWithURl:(NSString *)url
{
    NSString *tempPath= NSTemporaryDirectory();
    NSString *savePath = [tempPath stringByAppendingString:@"audioCash"];
    
    NSString *file = [[url componentsSeparatedByString:@"/"] lastObject];
    NSString *fileName = [file stringByAppendingString:@".mp3"];
    
    [self downloadFileURL:url savePath:savePath fileName:fileName];
    
}

/**
 * 下载文件
 */
- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //检查本地文件是否已存在
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", aSavePath, aFileName];
    NSLog(@"fileNamePath=%@",fileName);
    //检查附件是否存在
    if ([fileManager fileExistsAtPath:fileName]) {
        return;
    }else{
        //创建附件存储目录
        if (![fileManager fileExistsAtPath:aSavePath]) {
            [fileManager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        //下载附件
        NSURL *url = [[NSURL alloc] initWithString:aUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.inputStream   = [NSInputStream inputStreamWithURL:url];
        operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
        
        //下载进度控制
        /*
         [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
         NSLog(@"is download：%f", (float)totalBytesRead/totalBytesExpectedToRead);
         }];
         */
        
        //已完成下载
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"数据流下载成功");
           
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            //下载失败
            NSLog(@"数据流下载失败");
        }];
        
        [operation start];
    }
}

- (void)didLoginFromOtherDevice
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        alertView2 = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"loginAtOtherDevice", @"your login account has been in other places") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        alertView2.tag = 100;
        [alertView2 show];
        
    } onQueue:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.chatToolBar.inputTextView resignFirstResponder];
//    [self clickNaviItemRight];
    NSLog(@"123");
}

//-(void)key
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    
//    [UIView animateWithDuration:0.3 animations:^{
//         [_btnInviteJudge setFrame:CGRectMake((ScreenWidth - 80), (ScreenHeight -200-300), 60, 60)];
//    }];
//   
//    return YES;
//}
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    [UIView animateWithDuration:0.3 animations:^{
//        [_btnInviteJudge setFrame:CGRectMake((ScreenWidth - 80), (ScreenHeight -200), 60, 60)];
//    }];
//    
//    return YES;
//}
//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定退回工单？" message:@"退回则说明不接受或者不再服务此工单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
////
////            UIAlertController *
//
//[alert show];

//#pragma mark 获取医生信息
//- (void)obtainDoctorInfoWithId:(NSString *)doctorId
//{
//    BOOL isExit = NO;
//    for (NSDictionary *dic in _mutArrayUserHeader) {
//        if ([doctorId isEqualToString:[dic objectForKey:@"userId"]]) {
//            isExit = YES;
//        }
//    }
//    if (isExit) {
//        return;
//    }
//    
//    MBShow
//    [HTTPRequest httpWithGet:@"/cus/detail" Param:@{@"id": doctorId} Success:^(id obj) {
//        if (SUCCESS) {
//            if ([obj valueForKey:@"data"]) {
//                User *user = [JsonToModel objectFromDic:[obj valueForKey:@"data"] className:@"User"];
//                BOOL isExit = NO;
//                for (NSDictionary *dic in _mutArrayUserHeader) {
//                    if ([doctorId isEqualToString:[dic objectForKey:@"userId"]]) {
//                        isExit = YES;
//                    }
//                }
//                if (!isExit) {
//                    [_mutArrayUserHeader addObject:@{@"userId": doctorId, @"headerUrl": user.headurl}];
//                    [self.tableView reloadData];
//                }
//            }
//        }
//        MBHide
//    } Fail:^(NSString *errorMsg) {
//        MBHide
//        MBE_Sys
//    }];
//}


#pragma mark - 创建带附件的消息体和批量导入消息的示例
//- (void)loadMessage
//{
//    NSDictionary *imageDic = @{EMMessageBodyAttrKeySecret:@"fmIgiuSuEeSdyLffbqYspd3oOH6uMSGkXaOvZUF9ayy5b26c",
//                               EMMessageBodyAttrKeySize:@{EMMessageBodyAttrKeySizeWidth:@640,EMMessageBodyAttrKeySizeHeight:@1136},
//                               EMMessageBodyAttrKeyFileName:@"image.jpg",
//                               EMMessageBodyAttrKeyType:EMMessageBodyAttrTypeImag,
//                               EMMessageBodyAttrKeyUrl:@"https://a1.easemob.com/easemob-demo/chatdemoui/chatfiles/7e622080-e4ae-11e4-8a29-c1c8b3fc3a16",
//                               EMMessageBodyAttrKeyFileLength:@178212};
//    EMImageMessageBody *imageBody = [EMImageMessageBody imageMessageBodyFromBodyDict:imageDic forChatter:_chatter];
//    EMMessage *image = [[EMMessage alloc] initMessageWithID:@"50152415936119390" sender:_chatter receiver:@"my_test4" bodies:@[imageBody]];
//    image.timestamp = ([[NSDate date] timeIntervalSince1970] - 10) * 1000;
//    image.isReadAcked = YES;
//    image.deliveryState = eMessageDeliveryState_Delivered;
//    image.isRead = YES;
////    image.isGroup = self.isChatGroup;
//    image.conversationChatter = @"my_test5";
//
//    NSDictionary *voiceDic = @{EMMessageBodyAttrKeySecret:@"ZTKmSuSxEeS2upsPo9JVK-E7e7W_Ieu6g55uSbYCQikqSmh1",
//                               EMMessageBodyAttrKeyFileName:@"audio chat",
//                               EMMessageBodyAttrKeyDuration:@6,
//                               EMMessageBodyAttrKeyType:EMMessageBodyAttrTypeAudio,
//                               EMMessageBodyAttrKeyUrl:@"https://a1.easemob.com/easemob-demo/chatdemoui/chatfiles/6532a640-e4b1-11e4-9a0a-019cf64935ae",
//                               EMMessageBodyAttrKeyFileLength:@8870};
//
//    EMVoiceMessageBody *voiceBody = [EMVoiceMessageBody voiceMessageBodyFromBodyDict:voiceDic forChatter:_chatter];
//    EMMessage *voice = [[EMMessage alloc] initMessageWithID:@"50152415936119490" sender:_chatter receiver:@"my_test4" bodies:@[voiceBody]];
//    voice.timestamp = ([[NSDate date] timeIntervalSince1970] - 5) * 1000;
//    voice.isReadAcked = YES;
//    voice.deliveryState = eMessageDeliveryState_Delivered;
//    voice.isRead = YES;
////    voice.isGroup = isChatGroup;
//    voice.conversationChatter = @"my_test5";
//
//    NSDictionary *videoDic = @{EMMessageBodyAttrKeySecret:@"ANfQauSzEeSWceXUdNLCzOoCWyafJ0jg5AticaEKlEVCeqD2",
//                               EMMessageBodyAttrKeyDuration:@12,
//                               EMMessageBodyAttrKeyThumbSecret:@"AHShyuSzEeS9Eo2-FC-hEqTv7L96P5LNxUCo2zGrbZfu9FWz",
//                               EMMessageBodyAttrKeySize:@{EMMessageBodyAttrKeySizeWidth:@68,EMMessageBodyAttrKeySizeHeight:@90},
//                               EMMessageBodyAttrKeyThumb:@"https://a1.easemob.com/easemob-demo/chatdemoui/chatfiles/0074a1c0-e4b3-11e4-9adb-9da24ed370c3",
//                               EMMessageBodyAttrKeyFileName:@"video.mp4",
//                               EMMessageBodyAttrKeyType:@"video",
//                               EMMessageBodyAttrKeyFileLength:@1235670,
//                               EMMessageBodyAttrKeyUrl:@"https://a1.easemob.com/easemob-demo/chatdemoui/chatfiles/00d7d060-e4b3-11e4-9906-8311a663fa09"};
//
//    EMVideoMessageBody *videoBody = [EMVideoMessageBody videoMessageBodyFromBodyDict:videoDic forChatter:_chatter];
//    EMMessage *video = [[EMMessage alloc] initMessageWithID:@"50152415936119590" sender:_chatter receiver:@"my_test4" bodies:@[videoBody]];
//    video.timestamp = ([[NSDate date] timeIntervalSince1970] - 1) * 1000;
//    video.isReadAcked = YES;
//    video.deliveryState = eMessageDeliveryState_Delivered;
//    video.isRead = YES;
////    video.isGroup = isChatGroup;
//    video.conversationChatter = @"my_test5";
//    [[EaseMob sharedInstance].chatManager insertMessagesToDB:@[image, voice, video]];
//    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
//}

@end
