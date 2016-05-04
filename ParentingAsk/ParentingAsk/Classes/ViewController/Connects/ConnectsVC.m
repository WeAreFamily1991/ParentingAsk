
//  订单主页
#define DEFAULT_USER  [NSUserDefaults standardUserDefaults]
#import "ConnectsVC.h"
#import "CellConnects.h"
#import "WaitingVC.h"
#import "Msg_Waiting.h"
#import "BPMKNumberBadgeView.h"
#import "CustomCell.h"
#import "ChatViewController.h"
#import "MyModel.h"
#import "PersonalVC.h"
#import "AYBubbleView.h"
#import "AppDelegate.h"
@interface ConnectsVC ()<UITableViewDataSource,UITableViewDelegate>
//小气泡
@property (nonatomic, strong) AYBubbleView *bubbleView;

@property (nonatomic) NSInteger acceptedOrderMsgCount;
@property (nonatomic) NSInteger OrderMsgCount;
@property(nonatomic,strong)NSString *nicknameStr,*timeStr,*descStr,*headerStr;

@end

@implementation ConnectsVC
{
    NSMutableArray *_unConnectMess;
    NSMutableArray *_mutPersons;
    NSMutableArray *_mutSearch;
    UILabel *label;
    UIImageView *img;
    //    NSInteger _waitingCount;
    NSInteger _orderCount;
    NSInteger _transferCount;
    
    NSMutableArray *_dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSHomeDirectory());
    [self obtainData:@"/cus/servering" Receiver:1];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    //    self.tableView.separatorStyle =YES;
    
    //4.26改 解注释
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obtainPersonCount) name:@"SlideSwitchLeft" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obtainPersonCount) name:kNewMessageNotification object:nil];
    _dataArr = [NSMutableArray array];
    [self unreadMess];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self obtainData:@"/cus/servering" Receiver:1];
        [self obtainServerData];
    [self refreshUnreadCount];
    [self.tableView reloadData];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self refreshUnreadCount];
    
    ChatViewController *charVC = [[ChatViewController alloc]init];
    
    
    if (charVC.ChatVCBackBlock) {
        charVC.ChatVCBackBlock = ^(){
            [self obtainData:@"/cus/servering" Receiver:1];
            [self refreshUnreadCount];
        };    }
    
     [self.tableView reloadData];
    
}
-(void)unreadMess
{
    [self requestMessagesDone:^(id obj)
     {
         NSMutableArray *arrayData = [obj valueForKey:@"data"];
         _unConnectMess = arrayData;
         [AppDelegate shareAppDelegate].tabVC.GraBadgeView.value = _unConnectMess.count;
     } withMessageType:_connectsType];
    
}

//Travel
-(void)refreshUnreadCount{
    //    [self unreadMess];
    NSLog(@"[[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey]=%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey]);
    if (![AppDelegate shareAppDelegate].unreadDict) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey]) {
            [AppDelegate shareAppDelegate].unreadDict=[[[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey] mutableCopy];
        }else{
            [AppDelegate shareAppDelegate].unreadDict=[NSMutableDictionary dictionary];
        }
    }
    //    _acceptedOrderMsgCount =0;
    for (NSString *key in [AppDelegate shareAppDelegate].unreadDict.allKeys) {
        if ([AppDelegate shareAppDelegate].messageNames) {
            if ([[AppDelegate shareAppDelegate].messageNames containsObject:key])
            {
                
                _acceptedOrderMsgCount+=[[AppDelegate shareAppDelegate].unreadDict[key] integerValue];
            }else{
                [[AppDelegate shareAppDelegate].unreadDict removeObjectForKey:key];
            }
        }
    }
    NSLog(@"%@",[AppDelegate shareAppDelegate].unreadDict);
    [AppDelegate shareAppDelegate].tabVC.messageBadgeView.value=_acceptedOrderMsgCount;
    
    
    [self.tableView reloadData];
}

- (void)countUnreadMessages
{
    //    [self unreadMess];
    [self requestMessagesDone:^(id obj)
     {
         NSArray *arrayData = [obj valueForKey:@"data"];
         _acceptedOrderMsgCount=0;
         if ([arrayData isKindOfClass:[NSArray class]])
         {
             for (NSDictionary *dic in arrayData)
             {
                 Msg_Waiting *msgWait = [JsonToModel objectFromDic:dic className:@"Msg_Waiting"];
                 NSString *strUnReadKey = [NSString stringWithFormat:@"unRead_%@", msgWait.Msg_Waiting_id];
                 NSString *strUnReadCount = [[NSUserDefaults standardUserDefaults] valueForKey:strUnReadKey];
                 if (strUnReadCount.integerValue > 0)
                 {
                     _acceptedOrderMsgCount+=[strUnReadCount integerValue];
                 }
             }
         }
         [self refreshUnreadCount];
         [self.tableView reloadData];
     } withMessageType:ConnectsAcceptOrder];
}
//获取服务器数据
- (void)obtainServerData
{
    
    [self requestMessagesDone:^(id obj){
        NSArray *arrayData = [obj valueForKey:@"data"];
        

        [_dataArr removeAllObjects];
        if ([arrayData isKindOfClass:[NSArray class]])
        {
            for (NSDictionary *dic in arrayData)
            {
                Msg_Waiting *msgWait = [JsonToModel objectFromDic:dic className:@"Msg_Waiting"];
                [_dataArr addObject:msgWait];
            }
        }
        [self refreshUnreadCount];
        [self.tableView reloadData];

    } withMessageType:_connectsType];
    
}
//分类
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    text = @"";
    switch (_connectsType) {
        case ConnectsWaiting:
            text = @"暂无数据";
            break;
        case ConnectsAcceptOrder:
            text = @"暂无用户";
            break;
        case ConnectsTransfer:
            text = @"暂无用户";
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

//分类
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

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//
//    return ScreenHeight/80;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"_mutAllWaiting.count=%lu",(unsigned long)_dataArr.count);
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    CustomCell*cell = [CustomCell cellWithTableView:tableView];
    cell.badgeViewOnImg.hidden=YES;
    cell.badgeView.hidden=YES;
    [cell.labUnRead setHidden:YES];
    //    Msg_Waiting *muConnect = _dataArr[indexPath.row];
    
    NSLog(@"_dataArrnickname=%@",_dataArr[indexPath.row][@"nickname"]);
    
    cell.labName.text =_dataArr[indexPath.row][@"nickname"];
    cell.labDesc.text = _dataArr[indexPath.row][@"desc"];
    NSString *str = _dataArr[indexPath.row][@"time"];
    cell.labTime.text =[NSString stringReturnFromTime:str];
    
    
    NSString *headStr = _dataArr[indexPath.row][@"headurl"];
    [cell.imageAvatar sd_setImageWithURL:[NSURL URLWithString:headStr] placeholderImage:[UIImage imageNamed:@"head"]];
    
    
    //    if (_dataArr.count > 0) {
    //        [cell.labUnRead setText:[NSString stringWithFormat:@"%zd", _dataArr.count]];
    //
    //         cell.labDesc.text = _dataArr[indexPath.row][@"desc"];
    //    }
    
    //    if (_waitingCount > 0) {
    //        [cell.labCount setText:[NSString stringWithFormat:@"%zd", _waitingCount]];
    //    }
    
    //    [cell.labUnRead setHidden:YES];
    
    //
    //    if (_acceptedOrderMsgCount>0) {
    //        cell.badgeView.hidden=NO;
    //        cell.badgeView.value=_acceptedOrderMsgCount;
    //        cell.badgeView.shadow=NO;
    //        cell.badgeView.shine=NO;
    //    }
    
    //
    //    if (_acceptedOrderMsgCount>0) {
    //        cell.badgeView.hidden=NO;
    //        cell.badgeView.value=_acceptedOrderMsgCount;
    //        cell.badgeView.shadow=NO;
    //        cell.badgeView.shine=NO;
    //    }
    //
    
    //未读消息处理
    NSLog(@"_dataArr_id = %@",_dataArr[indexPath.row][@"id"]);
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *strUnReadKey = [NSString stringWithFormat:@"unRead_%@",_dataArr[indexPath.row][@"id"]];
    NSString *strUnReadCount = [userDef valueForKey:strUnReadKey];
    if (strUnReadCount.integerValue > 0) {
        [cell.labUnRead setHidden:NO];
        [cell.labUnRead setText:strUnReadCount];
    }
    return cell;
   
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"id"]] conversationType:eConversationTypeChat];
    
    chatVC.strTopTitle = _dataArr[indexPath.row][@"chatlabel"];
    chatVC.strDesc = _dataArr[indexPath.row][@"desc"];
    NSLog(@" chatVC.strTopTitle=%@,chatVC.strDesc=%@", chatVC.strTopTitle,chatVC.strDesc);
    //zou
    chatVC.hidesBottomBarWhenPushed = YES;
    
//    if (!chatVC.ChatVCBackBlock) {
//        chatVC.ChatVCBackBlock = ^(){
//            [self obtainPersonCount];
//            
//        };
//    }
    
    if (!chatVC.ChatVCBackBlock) {
        chatVC.ChatVCBackBlock = ^(){
            [self obtainData:@"/cus/servering" Receiver:1];
        };
        
    }
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *strUnReadKey = [NSString stringWithFormat:@"unRead_%@",_dataArr[indexPath.row][@"id"]];
    NSString *strUnReadCount = [userDef valueForKey:strUnReadKey];
    
    //点击时减少tab上未读数目
    if([AppDelegate shareAppDelegate].tabVC.messageBadgeView.value - [strUnReadCount integerValue]>0){
        _acceptedOrderMsgCount = [AppDelegate shareAppDelegate].tabVC.messageBadgeView.value - [strUnReadCount integerValue];
    }else{
        _acceptedOrderMsgCount = 0;
    }
    //点击时减少tab上未读数目
    //存储下标值 解决聊天期间其他人发消息问题
    long temp = 0;
    if([AppDelegate shareAppDelegate].tabVC.messageBadgeView.value - [strUnReadCount integerValue]>0){
        temp = [AppDelegate shareAppDelegate].tabVC.messageBadgeView.value - [strUnReadCount integerValue];
    }else{
        temp = 0;
    }
    [DEFAULT_USER setObject:[NSString stringWithFormat:@"%ld",temp] forKey:@"firstvalue"];
    //存储下标值
    
    
    NSLog(@"[[AppDelegate shareAppDelegate].unreadDict=%@",[AppDelegate shareAppDelegate].unreadDict);
    if ([AppDelegate shareAppDelegate].unreadDict && [AppDelegate shareAppDelegate].unreadDict[_dataArr[indexPath.row][@"nickname"]]) {
        [[AppDelegate shareAppDelegate].unreadDict removeObjectForKey:_dataArr[indexPath.row][@"nickname"]];
        [self saveUnreadMessageToSandBox];
        [self refreshUnreadCount];
    }
    
    [self.navigationCurrent pushViewController:chatVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

- (void)obtainPersonCount
{
    [self countUnreadMessages];
    NSArray *arrayUrl = @[@"/order/unserver", @"/cus/servering", @"/cus/forwarding"];
    
    for (NSInteger k = 0; k < arrayUrl.count; k ++) {
        [self obtainData:arrayUrl[k] Receiver:k];
    }
}
- (void)obtainData:(NSString *)urlPath Receiver:(NSInteger)receIndex
{
    MBShow
    [HTTPRequest httpWithPost:urlPath Param:@{} Success:^(id obj) {
        if (SUCCESS) {
            NSMutableArray *arrayData = [obj valueForKey:@"data"];
            //            [_mutPersons removeAllObjects];
            //            [_mutSearch removeAllObjects];
            //            if ([arrayData isKindOfClass:[NSArray class]]) {
            //                if (![AppDelegate shareAppDelegate].contactNames) {
            //                    [AppDelegate shareAppDelegate].contactNames=[NSMutableArray array];
            //                }else{
            //                    [[AppDelegate shareAppDelegate].contactNames removeAllObjects];
            //                }
            //                for (NSDictionary *dic in arrayData) {
            //                    Msg_Waiting *msgWait = [JsonToModel objectFromDic:dic className:@"Msg_Waiting"];
            //                    [_mutPersons addObject:msgWait];
            //
            //                    [[AppDelegate shareAppDelegate].contactNames addObject:msgWait.nickname];
            //                }
            //            }
            //            [self refreshUnreadCount];
            //            [_mutSearch addObjectsFromArray:_mutPersons];
            //
            if (receIndex == 0) {
                self.waitingCount = arrayData.count;
                NSLog(@"self.waitingCount=%ld",(long)self.waitingCount);
            }
            else if (receIndex == 1)
            {
                _orderCount = arrayData.count;
                _dataArr = arrayData;
                
                NSLog(@"_dataArr==%@",_dataArr);
                if (arrayData.count==0)
                {
                    UIImage *image = [UIImage imageNamed:@"over_mes.png"];
                    self.view.layer.contents = (id) image.CGImage;
                    [self.tableView reloadData];
                }
                else
                {
                    UIImage *image = [UIImage imageNamed:@""];
                    self.view.layer.contents =(id) image.CGImage;
                    [self.tableView reloadData];
                }
                
                
                
            }
            else {
                _transferCount = arrayData.count;
            }
            [self.tableView reloadData];
            
        }
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}


//- (void)didReceiveMessage:(EMMessage *)message
//{
//    NSLog(@"return data VC: %@ \n %@", message, self);
//
//    //发送已读回执给服务器（防止出现badgeValue累加情况）
//    [[EaseMob sharedInstance].chatManager sendReadAckForMessage:message];
//
////    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *mutTemp = [NSMutableArray array];;
//    if ([[userDef objectForKey:@"mutUnReadMsg"] isKindOfClass:[NSArray class]]) {
//        [mutTemp addObjectsFromArray:[userDef objectForKey:@"mutUnReadMsg"]];
//    }
//
//    //根据收到的信息判断是否弹出提示   您有新的订单，请及时查收
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
//
//                //未读消息处理
//
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
//                    [self.tableView reloadData];
//                }
//            }
//        }
//    }
//}


@end
