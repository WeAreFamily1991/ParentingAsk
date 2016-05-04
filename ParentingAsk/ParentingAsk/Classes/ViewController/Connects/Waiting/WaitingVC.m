



#define DEAULT_LOAD [NSUserDefaults standardUserDefaults]
#import "WaitingVC.h"
#import "CellWaiting.h"
#import "PersonalVC.h"
#import "UINavigationItem+ItemCustom.h"
#import "ChatViewController.h"
#import "WaitingDetailVC.h"
#import "Msg_Waiting.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "MainTabBarViewController.h"
#import "AppDelegate.h"
@interface WaitingVC ()<DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, EMChatManagerDelegate>

@end

@implementation WaitingVC
{
     NSInteger _waitingCount;
    NSMutableArray *_mutAllWaiting;
    UIImageView *img;
     Msg_Waiting *_msgWait;
    BOOL flag;
    NSLock *_lock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _lock = [[NSLock alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unreadCount) name:@"GrabMessageNotication" object:nil];

    [self obtainServerData];
    self.title = @"抢单";
   self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
//    self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.00];
    [self.navigationItem navigationRightWithTitle:nil Img:[UIImage imageWithFile:@"u0.png"] Delegate:self Action:@selector(clickPersonal) IsHeader:YES];
//    self.tableView.backgroundColor = SystemGrayColor;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    _mutAllWaiting = [NSMutableArray array];[self obtainServerData];}
-(void)segmentClick
{
    
}

-(void)unreadCount{
    if (flag)
    {
        [self obtainServerData];
    }else
    {
        [AppDelegate shareAppDelegate].tabVC.GraBadgeView.value = [AppDelegate shareAppDelegate].tabVC.GraBadgeView.value +1;
    }
    
    
}

-(void)refreshUnreadCount
{
    if (![AppDelegate shareAppDelegate].unreadDict) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey]) {
            [AppDelegate shareAppDelegate].unreadDict=[[[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey] mutableCopy];
        }else{
            [AppDelegate shareAppDelegate].unreadDict=[NSMutableDictionary dictionary];
        }
    }
//    NSInteger msgCount=0;
    for (NSString *key in [AppDelegate shareAppDelegate].unreadDict.allKeys) {
        if ([AppDelegate shareAppDelegate].GrabNames) {
            if ([[AppDelegate shareAppDelegate].GrabNames containsObject:key]) {
                _waitingCount+=[[AppDelegate shareAppDelegate].unreadDict[key] integerValue];
            }else{
                [[AppDelegate shareAppDelegate].unreadDict removeObjectForKey:key];
            }
        }
    }
    NSLog(@"%@",[AppDelegate shareAppDelegate].unreadDict);
    [AppDelegate shareAppDelegate].tabVC.GraBadgeView.value=_waitingCount;
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    flag =YES;
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC appearTabbarView];
    [self obtainServerData];
      [self refreshUnreadCount];
    [self.tableView reloadData];
  
//    [self unreadCount];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    flag =NO;
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC hiddenTabbarView];
    [self obtainServerData];
//    [self refreshUnreadCount];

    if (self.WaitingVCBackBlock)
    {
        self.WaitingVCBackBlock();
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSLog(@"_mutAllWaiting.count=%lu",(unsigned long)_mutAllWaiting.count);
    return _mutAllWaiting.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellWaiting *cell = [CellWaiting cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Msg_Waiting *msg = _mutAllWaiting[indexPath.row];
    cell.msg_Waiting = msg;
    cell.msg_Waiting.desc =msg.desc;
    cell.msg_Waiting.chatlabel = msg.chatlabel;
    [cell.labUnRead setHidden:YES];
    cell.GrabIMG.userInteractionEnabled = YES;
   
    cell.GrabIMG.tag = [msg.Msg_Waiting_id intValue];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    [cell.GrabIMG addGestureRecognizer:singleTap];
    
//        //未读消息处理
//        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//        NSString *strUnReadKey = [NSString stringWithFormat:@"unRead_%@", msg.Msg_Waiting_id];
//        NSString *strUnReadCount = [userDef valueForKey:strUnReadKey];
//        if (strUnReadCount.integerValue > 0) {
//            [cell.labUnRead setHidden:NO];
//            [cell.labUnRead setText:strUnReadCount];
//            
//        }
    
    
    return cell;
}

-(void)handleSingleTap:(UITapGestureRecognizer*)Gesture
{
    
    MBShow
    [HTTPRequest httpWithPost:@"/order/confirm" Param:@{@"id": [NSString stringWithFormat:@"%ld", Gesture.view.tag]} Success:^(id obj) {
        [_lock lock];
        if (SUCCESS) {
            MBHide
            
            ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:[NSString stringWithFormat:@"%ld", Gesture.view.tag] conversationType:eConversationTypeChat];
            NSLog(@"_msg_waiting.nickname==%@,_msg_waiting.desc==%@,_msg_waiting.time==%@,_msg_waiting.headurl==%@",_msg_waiting.nickname,_msg_waiting.desc,_msg_waiting.time,_msg_waiting.headurl);
            
            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:_msg_waiting.nickname,@"nickName",_msg_waiting.desc,@"desc",_msg_waiting.time,@"time",_msg_waiting.headurl,@"headIMG", nil];
            
            NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];

            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            chatVC.strTopTitle = _msg_waiting?_msg_waiting.chatlabel:_msgWait.chatlabel;
            chatVC.strDesc = _msg_waiting?_msg_waiting.desc:_msgWait.desc;
            if (!chatVC.ChatVCBackBlock) {
                chatVC.ChatVCBackBlock = ^(){
                    [self.navigationController popViewControllerAnimated:NO];
                };
            }
            [self.navigationController pushViewController:chatVC animated:YES];
            
        }
        else {
            MBE(@"单子已经被抢走啦")
            MBHide
            MESSAGE
        }
        
        [_lock unlock];
        
    } Fail:^(NSString *errorMsg) {
        MBHide
//        MBE_Sys
        MBE(@"单子已经被抢走啦")
    }];

 
    NSLog(@"gesture =%ld",Gesture.view.tag);


}
- (void)openChat
{
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:[NSString stringWithFormat:@"%@", _msg_waiting.Msg_Waiting_id] conversationType:eConversationTypeChat];
    NSLog(@"_msg_waiting.nickname==%@,_msg_waiting.desc==%@,_msg_waiting.time==%@,_msg_waiting.headurl==%@",_msg_waiting.nickname,_msg_waiting.desc,_msg_waiting.time,_msg_waiting.headurl);
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:_msg_waiting.nickname,@"nickName",_msg_waiting.desc,@"desc",_msg_waiting.time,@"time",_msg_waiting.headurl,@"headIMG", nil];
    
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    //    [self.navigationController popViewControllerAnimated:YES];
    
    chatVC.strTopTitle = _msg_waiting?_msg_waiting.chatlabel:_msgWait.chatlabel;
    chatVC.strDesc = _msg_waiting?_msg_waiting.desc:_msgWait.desc;
//    if (!chatVC.ChatVCBackBlock)
//    {
//        chatVC.ChatVCBackBlock = ^()
//        {
//            [self.navigationController popViewControllerAnimated:NO];
//        };
//    }
    [self.navigationController pushViewController:chatVC animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self refreshUnreadCount];
    //等待中或接单中
    if(_connectsType == ConnectsWaiting||_connectsType == ConnectsTransfer){
    
    
        Msg_Waiting *msg = _mutAllWaiting[indexPath.row];
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WaitingDetailVC *waitingDetail = [story instantiateViewControllerWithIdentifier:@"StoryIDWaitingDetail"];
        [waitingDetail setConnectsDetailType:(NSInteger)_connectsType];
        [waitingDetail setMsg_waiting:msg];
    
        [self.navigationController pushViewController:waitingDetail animated:YES];
    }else{
        //接单中
        Msg_Waiting *msg = _mutAllWaiting[indexPath.row];
        NSLog(@",msg.Msg_Waiting_id==%@",msg.Msg_Waiting_id);
        
        
        
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:[NSString stringWithFormat:@"%@",msg.Msg_Waiting_id] conversationType:eConversationTypeChat];
        chatVC.strTopTitle = msg.chatlabel;
        chatVC.strDesc = msg.desc;
        //zou
//        chatVC.hidesBottomBarWhenPushed = YES;
        if (!chatVC.ChatVCBackBlock)
        {
            chatVC.ChatVCBackBlock = ^()
            {
                [self obtainServerData];
            };
        }
        [self.navigationController pushViewController:chatVC animated:YES];
        
    }
    
    
    /*
     
     Msg_Waiting *msg = _mutPersons[indexPath.row];
     ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:[NSString stringWithFormat:@"%@", msg.Msg_Waiting_id] conversationType:eConversationTypeChat];
     chatVC.strTopTitle = msg.chatlabel;
     chatVC.strDesc = msg.desc;
     chatVC.hidesBottomBarWhenPushed=YES;
     if (!chatVC.ChatVCBackBlock) {
     chatVC.ChatVCBackBlock = ^(){
     [self obtainPersons];
     };
     }
     if ([AppDelegate shareAppDelegate].unreadDict && [AppDelegate shareAppDelegate].unreadDict[msg.nickname]) {
     [[AppDelegate shareAppDelegate].unreadDict removeObjectForKey:msg.nickname];
     [self saveUnreadMessageToSandBox];
     [self refreshUnreadCount];
     }
     [self.navigationCurrent pushViewController:chatVC animated:YES];
     */
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight/6-20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

/*
//- (void)didReceiveMessage:(EMMessage *)message
//{
//    
////    [self refreshUnreadCount];
//    NSLog(@"return data VC: %@ \n %@", message, self);
//    
    //发送已读回执给服务器（防止出现badgeValue累加情况）
//    [[EaseMob sharedInstance].chatManager sendReadAckForMessage:message];
//    
//    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *mutTemp = [NSMutableArray array];;
//    if ([[userDef objectForKey:@"mutUnReadMsg"] isKindOfClass:[NSArray class]]) {
//        [mutTemp addObjectsFromArray:[userDef objectForKey:@"mutUnReadMsg"]];
//    }
//    
    //根据收到的信息判断是否弹出提示   您有新的订单，请及时查收
//    if (message.messageType == eMessageTypeChat) {
//        NSString *strCate = [message.ext valueForKey:@"type"];
//        if (strCate) {
//            if ([strCate intValue]== 2 || [strCate intValue]== 1 || [strCate intValue]== 3) {
//                if (![[message.to uppercaseString] isEqualToString:[[HTTPRequest shareRequest].currentUser.username uppercaseString]]) {
//                    return;
//                }
//                
//                NSString *strMsg = @"您有新的订单，请及时查收";
//                if ([message.ext valueForKey:@"em_apns_ext"]) {
//                    if ([[message.ext valueForKey:@"em_apns_ext"] valueForKey:@"em_push_title"]) {
//                        strMsg = [[message.ext valueForKey:@"em_apns_ext"] valueForKey:@"em_push_title"];
//                    }
//                }
//                
//                //发送本地推送
//                UILocalNotification *notification = [[UILocalNotification alloc] init];
//                notification.fireDate = [NSDate date]; //触发通知的时间
//                [notification setHasAction:NO];
//                notification.timeZone = [NSTimeZone defaultTimeZone];
//                [notification setAlertBody:strMsg];
//                notification.soundName= UILocalNotificationDefaultSoundName;
//                
//                //发送通知
//                [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//                
//                BOOL isExit = NO;
//                for (NSString *obj in mutTemp) {
//                    if ([message.messageId isEqualToString:[NSString stringWithFormat:@"%@", obj]]) {
//                        isExit = YES;
//                        break;
//                    }
//                }
//                if (!isExit) {
//                    [mutTemp addObject:message.messageId];
//                    [userDef setObject:mutTemp forKey:@"mutUnReadMsg"];
//                }
//                NSInteger unReadMsg = (NSInteger)mutTemp.count;
//                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:unReadMsg];
//                
//                NSLog(@"[message.ext valueForKey:order_id] =%@",[message.ext valueForKey:@"order_id"]);
//              
//                //未读消息处理
//                if ([message.ext valueForKey:@"order_id"]) {
//                    NSString *strUnReadKey = [NSString stringWithFormat:@"unRead_%@", [message.ext valueForKey:@"order_id"]];
//                    NSString *strUnReadCount = [userDef valueForKey:strUnReadKey];
//                    if (strUnReadCount) {
//                        NSInteger unRead = strUnReadCount.integerValue;
//                        [userDef setValue:[NSString stringWithFormat:@"%zd", ++unRead] forKey:strUnReadKey];
//                    }
//                    else {
//                        [userDef setValue:@"1" forKey:strUnReadKey];
//                    }
//                    
//                  
//                    [self.tableView reloadData];
//                }
//            }
//        }
//    }
//}
 */


#pragma mark 点击个人中心
- (void)clickPersonal
{
//    [self refreshUnreadCount];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonalVC *personal = [story instantiateViewControllerWithIdentifier:@"StoryIDPersonal"];
    [self.navigationController pushViewController:personal animated:YES];
}

- (void)setConnectsType:(ConnectsType)connectsType
{
    _connectsType = connectsType;
    switch (_connectsType) {
        case ConnectsWaiting:
            [self setTitle:@"等待中"];
            break;
        case ConnectsAcceptOrder:
            [self setTitle:@"接单中"];
            break;
        case ConnectsTransfer:
            [self setTitle:@"转接中"];
            break;
        default:
            break;
    }
}

#pragma mark 获取服务器数据
- (void)obtainServerData
{
//    [self unreadCount];
//    [self refreshUnreadCount];
    [self requestMessagesDone:^(id obj){
        NSArray *arrayData = [obj valueForKey:@"data"];
        _waitingCount =arrayData.count;
        [_mutAllWaiting removeAllObjects];
        if ([arrayData isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in arrayData) {
                Msg_Waiting *msgWait = [JsonToModel objectFromDic:dic className:@"Msg_Waiting"];
                [_mutAllWaiting addObject:msgWait];
                NSLog(@"_mutAllWaiting=%@",_mutAllWaiting);
//                [DEAULT_LOAD setObject:_mutAllWaiting forKey:@"count222"];
            }
        }
        NSLog(@"_mutAllWaiting= %@",_mutAllWaiting);
        if (_mutAllWaiting.count==0)
        {
            
            
            UIImage *image = [UIImage imageNamed:@"over.png"];
            self.view.layer.contents = (id) image.CGImage;
            [self.tableView reloadData];
            
        }
        else
        {
           
            
            UIImage *image = [UIImage imageNamed:@""];
            self.view.layer.contents =(id) image.CGImage;
            [self.tableView reloadData];
        }
        [AppDelegate shareAppDelegate].tabVC.GraBadgeView.value =_mutAllWaiting.count;
        
//        [self refreshUnreadCount];
    } withMessageType:_connectsType];
    
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    text = @"";
    switch (_connectsType) {
        case ConnectsWaiting:
            text = @"";
            break;
        case ConnectsAcceptOrder:
            text = @"2";
            break;
        case ConnectsTransfer:
            text = @"3";
            break;
        default:
            break;
    }
    font = [UIFont fontWithName:@"IdealSans-Book-Pro" size:16.0];
    textColor = [UIColor lightGrayColor];
    
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 22.0;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}




@end
