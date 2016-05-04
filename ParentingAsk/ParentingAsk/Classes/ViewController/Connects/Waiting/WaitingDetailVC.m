
#import "WaitingDetailVC.h"
#import <EaseMob.h>
#import "Msg_Waiting.h"
#import "ChatViewController.h"

@interface WaitingDetailVC ()

@property (nonatomic, weak) IBOutlet UILabel *labTransfer;
@property (nonatomic, weak) IBOutlet UIButton *btnTransfer;
@property (nonatomic, weak) IBOutlet UILabel *labTransTemp;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *viewCurrent;
@property (nonatomic, weak) IBOutlet UIImageView *imageAvatar;
@property (nonatomic, weak) IBOutlet UILabel *labName;
@property (nonatomic, weak) IBOutlet UILabel *labTime;
@property (nonatomic, weak) IBOutlet UILabel *labDesc;
@property (nonatomic, weak) IBOutlet UIButton *btnAcceptOrder;
@property (nonatomic, weak) IBOutlet UIButton *btnBack;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *consAvatarTop;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *consViewWidth;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *consViewHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *consBtnLeft;

@end

@interface WaitingDetailVC ()<UIAlertViewDelegate>

@end
@implementation WaitingDetailVC
{
    Msg_Waiting *_msgWait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"详情页"];
    [self.scrollView setFrame:self.view.bounds];
    
    
    if (iPhone6) {
        _consViewWidth.constant = 375.0;
    }
    else if (iPhone6P) {
        _consViewWidth.constant = 414.0;
    }
    else {
        _consViewWidth.constant = 320.0;
    }
    
    switch (_connectsDetailType) {
        case ConnectsDetalWaiting:
        {
            [self.btnAcceptOrder setTitle:@"确认接单" forState:UIControlStateNormal];
            [self.btnBack setTitle:@"返回" forState:UIControlStateNormal];
        }
            break;
        case ConnectsDetailAcceptOrder:
        {
            [self.btnAcceptOrder setTitle:@"开始对话" forState:UIControlStateNormal];
            [self.btnBack setTitle:@"退回" forState:UIControlStateNormal];
        }
            break;
        case ConnectsDetailTransfer:
        {
            if ([_msg_waiting.sender valueForKey:@"id"]) {
                NSString *strSenderId = [NSString stringWithFormat:@"%@", [_msg_waiting.sender valueForKey:@"id"]];
                NSString *strUserId = [NSString stringWithFormat:@"%ld", [HTTPRequest shareRequest].currentUser.User_id];
                if ([strSenderId isEqualToString:strUserId]) {
                    //是自己转出去的
                    _consBtnLeft.constant -= (_consViewWidth.constant - 88 + 40);
                    [self.btnAcceptOrder setHidden:YES];
                    [self.btnBack setTitle:@"返回" forState:UIControlStateNormal];
                }
                else {
                    //转给自己的
                    [self.btnAcceptOrder setTitle:@"确认接受" forState:UIControlStateNormal];
                    [self.btnAcceptOrder setHidden:NO];
                    [self.btnBack setTitle:@"退回" forState:UIControlStateNormal];
                }
            }
            else {
                //转给自己的
                [self.btnAcceptOrder setTitle:@"确认接受" forState:UIControlStateNormal];
                [self.btnAcceptOrder setHidden:NO];
                [self.btnBack setTitle:@"退回" forState:UIControlStateNormal];
            }
            if ([_msg_waiting.receiver valueForKey:@"nickname"]) {
                [self.btnTransfer setTitle:[_msg_waiting.receiver valueForKey:@"nickname"] forState:UIControlStateNormal];
            }
        }
            break;
        default:
            break;
    }
    
    if (_connectsDetailType == ConnectsDetalWaiting || _connectsDetailType == ConnectsDetailAcceptOrder) {
        [self.labTransfer setHidden:YES];
        [self.btnTransfer setHidden:YES];
        [self.labTransTemp setHidden:YES];
        self.consAvatarTop.constant -= 42;
    }
    
    [self.viewCurrent.layer setCornerRadius:5.0f];
    [self.imageAvatar.layer setCornerRadius:25.0f];
    [self.imageAvatar setClipsToBounds:YES];
    [self.btnAcceptOrder.layer setCornerRadius:5.0f];
    [self.btnBack.layer setCornerRadius:5.0f];
    
    [self.btnAcceptOrder addTarget:self action:@selector(clickAcceptOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnBack addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnAcceptOrder setBackgroundColor:SystemGreenColor];
    [self.btnBack setBackgroundColor:SystemGreenColor];
    [self.btnTransfer setUserInteractionEnabled:NO];
    
    if (_connectsDetailType == ConnectsDetalWaiting) {
        [self obtainServerData];
    }
    else {
        [self layoutView:_msg_waiting];
    }
}

- (void)viewDidLayoutSubviews {
    self.scrollView.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.00];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, _consViewHeight.constant+4*ScreenHeight/5);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark 获取服务器数据
- (void)obtainServerData
{
    MBShow
    [HTTPRequest httpWithPost:@"/order/detail" Param:@{@"id": [NSString stringWithFormat:@"%@", _msg_waiting.Msg_Waiting_id]} Success:^(id obj) {
        if (SUCCESS) {
            NSDictionary *dicData = [obj valueForKey:@"data"];
            if ([dicData isKindOfClass:[NSDictionary class]]) {
                _msgWait = [JsonToModel objectFromDic:dicData className:@"Msg_Waiting"];
                [self layoutView:_msgWait];
            }
        }
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}

- (void)layoutView:(Msg_Waiting *)msg_Waiting
{
    [self.labName setText:msg_Waiting.nickname];
    [self.labDesc setText:[NSString stringWithFormat:@"  %@", msg_Waiting.desc]];
    
    //zou 占位图改为空
    //    HTTPImgView(self.imageAvatar, msg_Waiting.headurl)
    [self.imageAvatar sd_setImageWithURL:[NSURL URLWithString:msg_Waiting.headurl] placeholderImage:nil];
    
    NSString *strTime = [NSString stringReturnFromTime:msg_Waiting.time];
    [self.labTime setText:strTime];
    
    CGFloat viewHeight = [NSString stringReturnSizeWithText:msg_Waiting.desc Size:CGSizeMake(self.viewCurrent.frame.size.width, 0) FontSize:17.0].height;
    _consViewHeight.constant = 118.0 + viewHeight;
    
    if (_connectsDetailType == ConnectsDetailTransfer) {
        _consViewHeight.constant += 50.0;
    }
}


- (void)clickAcceptOrder:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"开始对话"]) {
        [self openChat];
        return;
    }
    
    NSString *method;
    if (_connectsDetailType != ConnectsDetailAcceptOrder) {
        method = @"/order/confirm";
    }
    
    MBShow
    [HTTPRequest httpWithPost:method Param:@{@"id": [NSString stringWithFormat:@"%@", _msg_waiting.Msg_Waiting_id]} Success:^(id obj) {
        if (SUCCESS) {
            MBHide
            [sender setTitle:@"开始对话" forState:UIControlStateNormal];
            [self.btnBack setTitle:@"退回" forState:UIControlStateNormal];
            if (self.connectsDetailType == ConnectsDetalWaiting) {
                [self openChat];
            }
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
- (void)clickBack:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"退回"]) {
        //执行退回操作
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定退回工单？" message:@"退回则说明不接受或者不再服务此工单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        MBShow
        [HTTPRequest httpWithPost:@"/order/cancel" Param:@{@"id": [NSString stringWithFormat:@"%@", _msg_waiting.Msg_Waiting_id]} Success:^(id obj) {
            MBHide
            if (SUCCESS) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } Fail:^(NSString *errorMsg) {
            MBHide
            MBE_Sys
        }];
    }
}

#pragma mark 开启聊天
- (void)openChat
{
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:[NSString stringWithFormat:@"%@", _msg_waiting.Msg_Waiting_id] conversationType:eConversationTypeChat];
    chatVC.strTopTitle = _msg_waiting?_msg_waiting.chatlabel:_msgWait.chatlabel;
    chatVC.strDesc = _msg_waiting?_msg_waiting.desc:_msgWait.desc;
    if (!chatVC.ChatVCBackBlock) {
        chatVC.ChatVCBackBlock = ^(){
            [self.navigationController popViewControllerAnimated:NO];
        };
    }
    [self.navigationController pushViewController:chatVC animated:YES];
}


@end
