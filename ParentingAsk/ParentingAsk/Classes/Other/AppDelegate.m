

#import "AppDelegate.h"
#import "LoginVC.h"
#import <EaseMob.h>
#import "ChatViewController.h"


#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import "ChechNetStatus.h"
#import "WaitingVC.h"
// zou
//#define kEaseKey  @"szzsit#ylzx" //正式环信APPKey

#define kEaseKey  @"szzsit#yltest" //测试环信AppKey

//企业号证书配置
//#if DEBUG
//#define kEaseCer  @"w2d"
//#else
//#define kEaseCer  @"w2p"
//#endif

//appstore 账号证书配置
#if DEBUG
#define kEaseCer  @"Apns_Dev"
#else
#define kEaseCer  @"Apns_Pro"
#endif

@interface AppDelegate ()<EMChatManagerDelegate,WXApiDelegate,UIScrollViewDelegate>
{
    //判断是否进入后台，处理推送消息问题
    BOOL _isInBackground;
    LoginVC *loginVC;
    BOOL isOut;
}
@property (nonatomic,strong)WaitingVC *waithVC;
@end

@implementation AppDelegate

+ (AppDelegate *)shareAppDelegate
{
    static AppDelegate *appdelegate;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        appdelegate = [[AppDelegate alloc] init];
    });
    return appdelegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //测试123
   
    [self setNet];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor=[UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
  

    UIViewController *ImgVC = [[UIViewController alloc] init];
    ImgVC.view.frame =CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    UIImageView *niceView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight)];
    niceView.image = [UIImage imageNamed:@"launchNew1.png"];
    
    //添加到场景
    [ImgVC.view addSubview:niceView];
    
    //放到最顶层;
    [ImgVC.view bringSubviewToFront:niceView];
    self.window.rootViewController = ImgVC;
    //开始设置动画;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:ImgVC.view cache:YES];
    [UIView setAnimationDelegate:self];
    //這裡還可以設置回調函數;
    
    //[UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
    [UIView setAnimationDidStopSelector:@selector(delayMethod)];
    
    niceView.alpha = 0.0;
    niceView.frame = CGRectMake(-60, -85, 480, 1024);
    [UIView commitAnimations];

    
    

    //注册环信
   EMError *error = [[EaseMob sharedInstance] registerSDKWithAppKey:kEaseKey apnsCertName:kEaseCer otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    NSLog(@"%ld",(long)error.errorCode);
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [self registerRemoteNotification];
    
    //判断是否是点击推送消息进入程序，是则执行自动登录
    if (launchOptions) {
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (userInfo) {
            [loginVC clickLogin];
        }
    }
  
    return YES;
}

#pragma mark 设置网络的类型
-(void)setNet
{
    NSInteger status = [ChechNetStatus checkDreviceNetStatus];
    switch (status)
    {
        case 0:
            NSLog(@"没有网络");
            break;
            
        case 1:
            NSLog(@"Wifi");
            break;
            
        case 2:
            NSLog(@"数据");
            break;
            
        default:
            break;
    }
}
-(void)delayMethod
{
    isOut =NO;
    
    //在沙盒做一个文件，判断沙盒有没有这个文件
    NSFileManager *manager=[NSFileManager defaultManager];
    
    //1.创建文件夹路径
    NSString *fileFolderPath =[self filePath:@"123"];
    
    BOOL isHasFile=[manager fileExistsAtPath:fileFolderPath];
    
    if (isHasFile)
    {
        //为真表示已有文件 曾经进入过主页
        [self gotoMain];
    }
    else
    {
        //为假表示没有文件，没有进入过主页
        [self makeLaunchView];
    }
    
    
}
//引导页面
-(void)makeLaunchView
{
    //数组内存放的是我要显示的假引导页面图片
    NSArray *arr=[NSArray arrayWithObjects:@"1",@"2",@"3",nil];
    
    //通过scrollView 将这些图片添加在上面，从而达到滚动这些图片
    UIScrollView *scr=[[UIScrollView alloc] initWithFrame:self.window.bounds];
    scr.contentSize=CGSizeMake(ScreenWidth*arr.count, self.window.frame.size.height);
    scr.pagingEnabled=YES;
    scr.tag=7000;
    scr.delegate=self;
    [scr setShowsHorizontalScrollIndicator:NO];
    //[self.window addSubview:scr];
    UIViewController *vc =[[UIViewController alloc] init];
    vc.view.frame =CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    vc.view.backgroundColor = [UIColor whiteColor];
    [vc.view addSubview:scr];
    
    self.window.rootViewController = vc;
    
    
    for (int i=0; i<arr.count; i++)
    {
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, self.window.frame.size.height)];
        img.image=[UIImage imageNamed:arr[i]];
        [scr addSubview:img];
        
    }
    
    
}
#pragma mark scrollView的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //这里是在滚动的时候判断 我滚动到哪张图片了，如果滚动到了最后一张图片，那么
    //如果在往下面滑动的话就该进入到主界面了，我这里利用的是偏移量来判断的，当
    //一共五张图片，所以当图片全部滑完后 又像后多滑 的时候就做下一个动作
    if (scrollView.contentOffset.x>=2*ScreenWidth)
    {
        
        //这是我声明的一个全局变量Bool 类型的，初始值为no，当达到我需求的条件时将值改为yes
        isOut=YES;
        
    }
}
//停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //判断isout为真 就要进入主界面了
    if (isOut)
    {
        //这里添加了一个动画，（可根据个人喜好）
        [UIView animateWithDuration:0 animations:^{
            //让scrollview 渐变消失
            scrollView.alpha=0;
           
            
        }completion:^(BOOL finished) {
            
            //将scrollView移除
            [scrollView  removeFromSuperview];
            
            //进入主界面
             [self gotoMain];
            
        } ];
    }
    
}

//去主页
-(void)gotoMain
{
    //如果第一次进入没有文件，我们就创建这个文件
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *fileFolderPath =[self filePath:@"123"];
    //判断 我是否创建了文件，如果没创建 就创建这个文件（这种情况就运行一次，也就是第一次启动程序的时候）
    if (![manager fileExistsAtPath:fileFolderPath]) {
        [manager createFileAtPath:fileFolderPath contents:nil attributes:nil];
    }
    //创建tabbar
    
    
    //1.初始化ShareSDK应用,字符串"iosv1101"是应该换成你申请的ShareSDK应用中的Appkey
    [self initShare];
    
//    sleep(0.1);
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
   loginVC = [story instantiateViewControllerWithIdentifier:@"StoryIDLogin"];
    _navigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.window setRootViewController:_navigation];
//    [self.window makeKeyAndVisible];

    
}
-(NSString *)filePath:(NSString *)name
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:name];
}

- (void)initShare
{
    /****************************ShareSDK分享****************************/
    
    [ShareSDK registerApp:@"10fdd2b7b6182"];//字符串api20为您的ShareSDK的AppKey
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"2030420248" appSecret:@"ca5f823f9fc4432ce4da380244680d39"
                             redirectUri:@"http://www.baidu.com"];
    
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"2030420248"
                                appSecret:@"ca5f823f9fc4432ce4da380244680d39"
                              redirectUri:@"http://www.baidu.com"
                              weiboSDKCls:[WeiboSDK class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1105187395"
                           appSecret:@"f7sHj68qwk3AZQ4M"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址   http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"1105187395"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //微信登陆的时候需要初始化
    [ShareSDK connectWeChatWithAppId:@"wx83d6510841eef02d"
                           appSecret:@"4ebad9adfd14db9f0a4f08ad9ada0d0a"wechatCls:[WXApi class]];
}
#pragma mark 微信代理
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}
#pragma mark 微信代理
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

//添加两个回调方法,return的必须要ShareSDK的方法。如果要支持微信支付，请通过回调返回的url来判断

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (application.applicationState == UIApplicationStateActive) {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.userInfo = userInfo;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.alertBody = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        localNotification.fireDate = [NSDate date];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
    
    NSLog(@"\n\n\n\n\nreturn data: %@", userInfo);
}

//注册推送
- (void)registerRemoteNotification{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
  
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self saveUnreadMessageToSandBox];
    //此处注册一个通知，进入后台，改变聊天收消息的delegate，试试吧
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notiInBackground" object:nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"mutUnReadMsg"];
    application.applicationIconBadgeNumber = 0;

    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notiInForeground" object:nil];
    
    //唤起程序的时候，对对应的基本控制器发出通知
    if (![_navigation.topViewController isKindOfClass:[ChatViewController class]]) {
//        UIApplicationState state = application.applicationState;
        NSString *strVC = [HTTPRequest shareRequest].currentBaseVC;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notiEnterForeground" object:strVC];
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"mutUnReadMsg"];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveUnreadMessageToSandBox];
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    
    NSLog(@"return data: 注册device token失败");
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = application.applicationState;
    if (state == UIApplicationStateActive && ![_navigation.topViewController isKindOfClass:[ChatViewController class]]) {
        [MBProgressHUD showMessag:notification.alertBody toWindow:self.window];
    }
    
    NSArray* localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    if (localNotifications) {
        for (UILocalNotification *notifi in localNotifications) {
            [application cancelLocalNotification:notifi];
        }
    }
}


@end
