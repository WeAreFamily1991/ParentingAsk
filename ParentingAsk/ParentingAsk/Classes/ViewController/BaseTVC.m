

#import "BaseTVC.h"
#import "UINavigationItem+ItemCustom.h"
#import "LoginVC.h"

@interface BaseTVC ()<EMChatManagerDelegate,IChatManagerDelegate,UIAlertViewDelegate>

@end

@implementation BaseTVC
{
    //设置一个临时变量，记录当前是否可以执行弹出提示（防止订单提示更多的弹出，影响用户使用）
    BOOL _isIgnoreMsg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(returnBack)];
    [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [HTTPRequest shareRequest].currentBaseVC = @"CurrentBaseTVC";
    
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needReLogin) name:@"NotiNeedReLogin" object:nil];
        [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];

    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    
}

- (void)didReceiveMessage:(EMMessage *)message
{
    NSLog(@"return data TVC: %@ \n %@", message, self);
    
    //发送已读回执给服务器（防止出现badgeValue累加情况）
    [[EaseMob sharedInstance].chatManager sendReadAckForMessage:message];
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSMutableArray *mutTemp = [NSMutableArray array];;
    if ([[userDef objectForKey:@"mutUnReadMsg"] isKindOfClass:[NSArray class]]) {
        [mutTemp addObjectsFromArray:[userDef objectForKey:@"mutUnReadMsg"]];
    }
    
    if (message.messageType == eMessageTypeChat)
    {
        NSString *strCate = [message.ext valueForKey:@"type"];
        if (strCate) {
            if ([strCate intValue]== 2 || [strCate intValue]== 1 || [strCate intValue]== 3) {
                if (![[message.to uppercaseString] isEqualToString:[[HTTPRequest shareRequest].currentUser.username uppercaseString]]) {
                    return;
                }
                
                NSString *strMsg = @"您有新的订单，请及时查收";
                if ([message.ext valueForKey:@"em_apns_ext"]) {
                    if ([[message.ext valueForKey:@"em_apns_ext"] valueForKey:@"em_push_title"]) {
                        strMsg = [[message.ext valueForKey:@"em_apns_ext"] valueForKey:@"em_push_title"];
                        //Travel
                        [self saveUnreadMessage:strMsg];
                        if ([strCate isEqual:@"3"])
                        {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"GrabMessageNotication" object:nil];
                        }
                        else
                        {
                            [[NSNotificationCenter defaultCenter] postNotificationName:kNewMessageNotification object:nil];
                        }

                    }
                }
                
                //发送本地推送
                UILocalNotification *notification = [[UILocalNotification alloc] init];
                notification.fireDate = [NSDate date]; //触发通知的时间
                [notification setHasAction:NO];
                notification.timeZone = [NSTimeZone defaultTimeZone];
                [notification setAlertBody:strMsg];
                notification.soundName= UILocalNotificationDefaultSoundName;
                
                //发送通知
                [[UIApplication sharedApplication] scheduleLocalNotification:notification];
                
                BOOL isExit = NO;
                for (NSString *obj in mutTemp) {
                    if ([message.messageId isEqualToString:[NSString stringWithFormat:@"%@", obj]]) {
                        isExit = YES;
                        break;
                    }
                }
                if (!isExit) {
                    [mutTemp addObject:message.messageId];
                    [userDef setObject:mutTemp forKey:@"mutUnReadMsg"];
                }
                NSInteger unReadMsg = (NSInteger)mutTemp.count;
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:unReadMsg];
                
                
                //未读消息处理
                if ([message.ext valueForKey:@"order_id"]) {
                    NSString *strUnReadKey = [NSString stringWithFormat:@"unRead_%@", [message.ext valueForKey:@"order_id"]];
                    NSString *strUnReadCount = [userDef valueForKey:strUnReadKey];
                    if (strUnReadCount) {
                        NSInteger unRead = strUnReadCount.integerValue;
                        [userDef setValue:[NSString stringWithFormat:@"%zd", ++unRead] forKey:strUnReadKey];
                    }
                    else {
                        [userDef setValue:@"1" forKey:strUnReadKey];
                    }
                }
            }
        }
    }
}
- (void)needReLogin
{
    //注销环信登录 zou
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginVC *loginVC = [story instantiateViewControllerWithIdentifier:@"StoryIDLogin"];
    [HTTPRequest shareRequest].sessionID = nil;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.tableView endEditing:YES];
}

- (void)didLoginFromOtherDevice
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"loginAtOtherDevice", @"your login account has been in other places") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        alertView.tag = 100;
        [alertView show];
        
    } onQueue:nil];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
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
//-(void)setNavBackBarHidden
//{
//    [self.navigationItem navigationBackWithDelegate:nil Action:nil];
//    self.navigationItem.leftBarButtonItem = nil;
//}
@end
