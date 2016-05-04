//
//  MainTabBarViewController.m
//  ChinaPoetryNet
//
//  Created by User on 5/6/15.
//  Copyright (c) 2015 User. All rights reserved.
//
#import "AYBubbleView.h"
#import "MainTabBarViewController.h"
#import "PersonalVC.h"
#import "MessageVC.h"
#import "ConnectsVC.h"
#import "MainVC.h"
#import "AppDelegate.h"
#import "PersonalVC.h"
#import "WaitingVC.h"
#import "PersonCenterViewController.h"
#import "TipsTVC.h"
#import "MessageViewController.h"
#define DEAULT_LOAD [NSUserDefaults standardUserDefaults]
#define btnHeight 49
#define btnWidth 80
#define tabBarHeight 49
#define mainDetailColor [UIColor colorWithRed:151.0/255 green:151.0/255 blue:151.0/255 alpha:1]
#define mainGreenColor [UIColor colorWithRed:58.0/255 green:178.0/255 blue:50.0/255 alpha:1]

@interface MainTabBarViewController ()<IChatManagerDelegate>

@property (nonatomic, strong) AYBubbleView *bubbleView;
@property (strong,nonatomic)MainVC *mainvc;
@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUnreadCount) name:kNewMessageNotification object:nil];
    //创建TabBar
    [self initTabBar];
    //创建视图控制器
    [self initViewContollers];
    // Do any additional setup after loading the view.
}
//-(void)refreshUnreadCount{
//    if (![AppDelegate shareAppDelegate].unreadDict) {
//        if ([[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey]) {
//            [AppDelegate shareAppDelegate].unreadDict=[[[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey] mutableCopy];
//        }else{
//            [AppDelegate shareAppDelegate].unreadDict=[NSMutableDictionary dictionary];
//        }
//    }
//    NSInteger msgCount=0;
//    for (NSString *key in [AppDelegate shareAppDelegate].unreadDict.allKeys) {
//        if ([AppDelegate shareAppDelegate].GrabNames) {
//            if ([[AppDelegate shareAppDelegate].GrabNames containsObject:key]) {
//                msgCount+=[[AppDelegate shareAppDelegate].unreadDict[key] integerValue];
//            }else{
//                [[AppDelegate shareAppDelegate].unreadDict removeObjectForKey:key];
//            }
//        }
//    }
//    NSLog(@"%@",[AppDelegate shareAppDelegate].unreadDict);
//    [AppDelegate shareAppDelegate].tabVC.GraBadgeView.value=msgCount;
//    
//   
//}
- (void)initViewContollers
{
    //zou
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    PersonalVC *personal = [story instantiateViewControllerWithIdentifier:@"StoryIDPersonal"];
//    personal.isShowBack = YES;
    
    
    _mainvc  = [[MainVC alloc] init];
    _mainvc.hidesBottomBarWhenPushed = YES;
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:_mainvc];

    
    MessageVC *conVc = [[MessageVC alloc] init];
    conVc.hidesBottomBarWhenPushed= YES;
//    conVc.isShowBack = YES;
    [conVc obtainPersons];
    UINavigationController *conNav = [[UINavigationController alloc] initWithRootViewController:conVc];

    WaitingVC *wathVC = [[WaitingVC alloc]init];

    wathVC.hidesBottomBarWhenPushed = YES;
     UINavigationController *waithNav = [[UINavigationController alloc] initWithRootViewController:wathVC];
    
    
    TipsTVC *tipsVc = [[TipsTVC alloc]init];
    tipsVc.hidesBottomBarWhenPushed = YES;
    UINavigationController *tipsNav = [[UINavigationController alloc] initWithRootViewController:tipsVc];


    PersonCenterViewController *personVC=[[PersonCenterViewController alloc]init];
       personVC.hidesBottomBarWhenPushed = YES;
    UINavigationController *personNav = [[UINavigationController alloc]initWithRootViewController:personVC];
    

    
    self.viewControllers = [[NSArray alloc] initWithObjects:mainNav,conNav,waithNav,tipsNav,personNav, nil];
    [AppDelegate shareAppDelegate].tabVC=self;
}
#pragma mark 下面五个tabbar
- (void)initTabBar
{
    //隐藏自带的TabBar
//    self.tabBar.hidden = YES;ScreenWidth - 5*btnWidth)/6
    
    float gapWidth = ScreenWidth/12;
    float with = ScreenWidth/12;
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - tabBarHeight, ScreenWidth, tabBarHeight)];
    _tabbarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabbarView];
    
    UIImageView *liner = [[UIImageView alloc] init];
    liner.backgroundColor = [UIColor colorWithRed:211.0/255 green:209.0/255 blue:211.0/255 alpha:1];
    liner.frame = CGRectMake(0, 0, ScreenWidth, 1);
    [_tabbarView addSubview:liner];
    //消息的按钮
    _msgBtn = [[CustomButton alloc] initWithFrame:CGRectMake(gapWidth, 0, with, btnHeight) withIcon:@"icon1_nor" withName:nil withIsShowNum:NO];
    _msgBtn.nameLabel.textColor = mainDetailColor;
    [_msgBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _msgBtn.tag = 1;
    [_tabbarView addSubview:_msgBtn];
    
    //联系人的按钮
    _conBtn = [[CustomButton alloc] initWithFrame:CGRectMake(3*gapWidth , 0, with, btnHeight) withIcon:@"icon2_nor" withName:nil withIsShowNum:NO];
    _conBtn.nameLabel.textColor = mainDetailColor;
    [_conBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _conBtn.tag = 2;
    [_tabbarView addSubview:_conBtn];

    //抢单按钮
    _GrabBtn = [[CustomButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth/12
                                                              
                                                              , -ScreenWidth/19, ScreenWidth/6, ScreenWidth/6) withIcon:@"icon3_pre" withName:nil withIsShowNum:NO];
    _GrabBtn.nameLabel.textColor = mainDetailColor;
//    _GrabBtn.backgroundColor = SystemGreenColor;
    _GrabBtn.layer.cornerRadius = ScreenWidth/12;
    [_GrabBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _GrabBtn.tag = 3;
    [_tabbarView addSubview:_GrabBtn];
//    
//    self.bubbleView = [[AYBubbleView alloc] initWithCenterPoint:_GrabBtn.center bubleRadius:15 addToSuperView:_GrabBtn];
//    self.bubbleView.decayCoefficent = .2;
////   NSArray *countArr =[DEAULT_LOAD objectForKey:@"count222"];
////    NSString *countStr =[NSString stringWithFormat:@"%ld",countArr.count];
//    self.connectCount = [[ConnectsVC alloc]init];
//    NSString *str = [NSString stringWithFormat:@"%zd",self.connectCount.waitingCount];
//    
//    self.bubbleView.unReadLabel.text =str;
//    //    bubbleView.unReadLabel.font = [UIFont systemFontOfSize:11.0];
//    self.bubbleView.bubbleColor = [UIColor redColor];
////    __weak typeof(self) weakSelf = self;
//    self.bubbleView.cleanMessageBlock = ^(BOOL isClean)
//    {
//        if (isClean)
//        {
////            weakSelf..value = 0;
//        }
//        else
//        {
//            
//        }
//    };
    
    //通知提示按钮
    _setBtn = [[CustomButton alloc] initWithFrame:CGRectMake(8*gapWidth , 0, with, btnHeight) withIcon:@"icon4_nor" withName:nil withIsShowNum:NO];
    _setBtn.nameLabel.textColor = mainDetailColor;
    [_setBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _setBtn.tag = 4;
    [_tabbarView addSubview:_setBtn];
//    self.bubbleView = [[AYBubbleView alloc] initWithCenterPoint:_setBtn.center  bubleRadius:15 addToSuperView:_setBtn];
//    self.bubbleView.decayCoefficent = 2;
//    self.bubbleView.unReadLabel.text = @"69";
//    //    bubbleView.unReadLabel.font = [UIFont systemFontOfSize:11.0];
//    self.bubbleView.bubbleColor = [UIColor redColor];
//    //    __weak typeof(self) weakSelf = self;
//    self.bubbleView.cleanMessageBlock = ^(BOOL isClean)
//    {
//        if (isClean)
//        {
//            //            weakSelf..value = 0;
//        }
//        else
//        {
//            
//        }
//    };
//
//    
    //我的按钮
    _MineBtn = [[CustomButton alloc] initWithFrame:CGRectMake(10*gapWidth , 0, with, btnHeight) withIcon:@"icon5_nor" withName:nil withIsShowNum:NO];
    _MineBtn.nameLabel.textColor = mainDetailColor;
    [_MineBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _MineBtn.tag = 5;
    [_tabbarView addSubview:_MineBtn];
    
    
    
    
    
    //消息未读消息数
    if (!_messageBadgeView) {
        CGRect frame=_msgBtn.bounds;
        frame.origin.y=-10;
        frame.origin.x=20;
        _messageBadgeView=[[BPMKNumberBadgeView alloc] initWithFrame:frame];
        [_msgBtn addSubview:_messageBadgeView];
        _messageBadgeView.hideWhenZero=YES;
        _messageBadgeView.shadow=NO;
        _messageBadgeView.shine=NO;
        _messageBadgeView.value=0;
        _messageBadgeView.userInteractionEnabled=NO;
    }
    NSLog(@" _contactBadgeView.value==%lu", (unsigned long)_contactBadgeView.value);
   
    //抢单未读消息数
    if (!_GraBadgeView) {
        CGRect frame=_GrabBtn.bounds;
        frame.origin.y=-10;
        frame.origin.x=20;
        _GraBadgeView=[[BPMKNumberBadgeView alloc] initWithFrame:frame];
        [_GrabBtn addSubview:_GraBadgeView];
        _GraBadgeView.hideWhenZero=YES;
        _GraBadgeView.shadow=NO;
        _GraBadgeView.shine=NO;
        _GraBadgeView.value=0;
        _GraBadgeView.userInteractionEnabled=NO;
    }

    
//    //联系人未读消息数
//    if (!_contactBadgeView) {
//        CGRect frame=_setBtn.bounds;
//        frame.origin.y=-10;
//        frame.origin.x=20;
//        _contactBadgeView=[[BPMKNumberBadgeView alloc] initWithFrame:frame];
//        [_setBtn addSubview:_contactBadgeView];
//        _contactBadgeView.hideWhenZero=YES;
//        _contactBadgeView.shadow=NO;
//        _contactBadgeView.shine=NO;
//        _contactBadgeView.value=1;
//        _contactBadgeView.userInteractionEnabled=NO;
//    }

      //联系人未读消息数
    if (!_contactBadgeView) {
        CGRect frame=_conBtn.bounds;
        frame.origin.y=-10;
        frame.origin.x=20;
        _contactBadgeView=[[BPMKNumberBadgeView alloc] initWithFrame:frame];
        [_conBtn addSubview:_contactBadgeView];
        _contactBadgeView.hideWhenZero=YES;
        _contactBadgeView.shadow=NO;
        _contactBadgeView.shine=NO;
        _contactBadgeView.value=0;
        _contactBadgeView.userInteractionEnabled=NO;
    }
    //控制初始加载为抢单界面
  
    [self itemBtnClick:_msgBtn];
  
}
#pragma mark 点击个人中心
- (void)clickPersonal:(CustomButton *)sender
{
//    UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否更新版本" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    
//    [alertview show];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonalVC *personal = [story instantiateViewControllerWithIdentifier:@"StoryIDPersonal"];
    [self.navigationController pushViewController:personal animated:YES];
}
//Travel控制tabbar点击时跳转界面
- (void)itemBtnClick:(CustomButton *)sender{
    
    if (sender==_conBtn)
    {
        [self itemBtnClick:_msgBtn changeColorOnly:NO];
        [_mainvc clickChoose:_mainvc.btnConnects];
    }
    else if (sender==_msgBtn)
    {
        [self itemBtnClick:_msgBtn changeColorOnly:NO];
        [_mainvc clickChoose:_mainvc.btnMessages];
    }
    
    else
    {
        [self itemBtnClick:sender changeColorOnly:NO];
    }
    [self appearTabbarView];
}//Travel
- (void)itemBtnClick:(CustomButton *)sender changeColorOnly:(BOOL)changeColorOnly
{
    //Travel
    if (!changeColorOnly)
    {
        self.selectedIndex = sender.tag -1 ;
    }
    //
    _msgBtn.nameLabel.textColor = mainDetailColor;
    _msgBtn.iconView.image = [UIImage imageNamed:@"icon1_nor"];
    
    _conBtn.nameLabel.textColor = mainDetailColor;
    _conBtn.iconView.image = [UIImage imageNamed:@"icon2_nor"];
    
    _GrabBtn.nameLabel.textColor = mainDetailColor;
    _GrabBtn.iconView.image = [UIImage imageNamed:@"icon3_nor"];

    _setBtn.nameLabel.textColor = mainDetailColor;
    _setBtn.iconView.image = [UIImage imageNamed:@"icon4_nor"];
    
    
    _MineBtn.nameLabel.textColor = mainDetailColor;
    _MineBtn.iconView.image = [UIImage imageNamed:@"icon5_nor"];
    
    sender.nameLabel.textColor = mainGreenColor;
    sender.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%d_pre",(int)sender.tag]];
}

- (void)hiddenTabbarView
{
    [UIView animateWithDuration:0.35 animations:^{

        _tabbarView.frame = CGRectMake(0, self.view.frame.size.height + tabBarHeight, self.view.frame.size.width, tabBarHeight);

    }];
}

- (void)appearTabbarView
{
    [UIView animateWithDuration:0.35 animations:^{
        _tabbarView.frame = CGRectMake(0, self.view.frame.size.height - tabBarHeight, self.view.frame.size.width, tabBarHeight);
    }];
}
- (void)didLoginFromOtherDevice
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"loginAtOtherDevice", @"your login account has been in other places") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        alertView.tag = 100;
        [alertView show];
        
    } onQueue:nil];
}
-(void)didReceiveMessage:(EMMessage *)message
{
    WaitingVC *waitVC = self.viewControllers[2];
    
    if (![AppDelegate shareAppDelegate].unreadDict) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey])
        {
            [AppDelegate shareAppDelegate].unreadDict=[[[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey] mutableCopy];
        }else{
            [AppDelegate shareAppDelegate].unreadDict=[NSMutableDictionary dictionary];
        }
    }
    //    NSInteger msgCount=0;
    for (NSString *key in [AppDelegate shareAppDelegate].unreadDict.allKeys) {
        if ([AppDelegate shareAppDelegate].GrabNames) {
            if ([[AppDelegate shareAppDelegate].GrabNames containsObject:key]) {
                waitVC.waitingCount +=[[AppDelegate shareAppDelegate].unreadDict[key] integerValue];
            }else{
                [[AppDelegate shareAppDelegate].unreadDict removeObjectForKey:key];
            }
        }
    }
    NSLog(@"%@",[AppDelegate shareAppDelegate].unreadDict);
    [AppDelegate shareAppDelegate].tabVC.GraBadgeView.value= waitVC.waitingCount;
    
//    [self.tableView reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
