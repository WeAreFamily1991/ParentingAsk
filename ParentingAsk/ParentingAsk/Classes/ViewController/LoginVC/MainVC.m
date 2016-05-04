

#import "MainVC.h"
#import "UINavigationItem+ItemCustom.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "SlideVC.h"
#import "PersonalVC.h"
#import "MainTabBarViewController.h"
#import "ConnectsVC.h"
@interface MainVC ()<SlideVCDelegate>
@property (nonatomic,copy) NSString *currentVersion;
@property (nonatomic, strong) UIView *viewChoose;

@end

@implementation MainVC
{
    
    UIView *_viewChoose;
    
    UISegmentedControl *_segmentControl;
    UIScrollView *_scrollView;
    MMDrawerController *_mmDrawerController;
    SlideVC *_slideVC;
    ConnectsVC *_connectsVC;
    
    UILabel *MessagesLab;
    UILabel *ConnectsLab;
}
//swich
- (UIView *)viewChoose
{
    if (!_viewChoose)
    {
        _viewChoose = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/3, 7, 2 *ScreenWidth/3, ScreenHeight/30)];

//        _viewChoose.backgroundColor = [UIColor redColor];
        _btnConnects = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_btnConnects setBackgroundImage:[UIImage imageWithFile:@"btn- contactsBlueR.png"] forState:UIControlStateSelected];
//        [_btnConnects setBackgroundImage:[UIImage imageWithFile:@"btn- contactsGrayR.png"] forState:UIControlStateNormal];
        [_btnConnects setFrame:CGRectMake(1.5 * ScreenWidth/9, 0, ScreenWidth/5, ScreenHeight/30)];
        [_btnConnects setTitle:@"联系人" forState:UIControlStateNormal];
        [_btnConnects setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.800] forState:UIControlStateNormal];
        [_btnConnects setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnConnects.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        _btnMessages = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_btnMessages setBackgroundImage:[UIImage imageWithFile:@"btn- contactsBlueL.png"] forState:UIControlStateSelected];
//        [_btnMessages setBackgroundImage:[UIImage imageWithFile:@"btn- contactsGrayL.png"] forState:UIControlStateNormal];
        [_btnMessages setFrame:CGRectMake(0, 0, ScreenWidth/9, ScreenHeight/30)];
        [_btnMessages setTitle:@"消息" forState:UIControlStateNormal];
        [_btnMessages setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.800] forState:UIControlStateNormal];
        [_btnMessages setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnMessages.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        [_btnMessages addTarget:self action:@selector(clickChoose:) forControlEvents:UIControlEventTouchUpInside];
        [_btnConnects addTarget:self action:@selector(clickChoose:) forControlEvents:UIControlEventTouchUpInside];
        
        MessagesLab = [[UILabel alloc]initWithFrame:CGRectMake(-1, ScreenHeight/19, ScreenWidth/9, 2)];
        MessagesLab.backgroundColor = [UIColor whiteColor];
        [_btnMessages addSubview:MessagesLab];
        ConnectsLab = [[UILabel alloc]initWithFrame:CGRectMake(7, ScreenHeight/19, ScreenWidth/7, 2)];
        ConnectsLab.backgroundColor = SYSNAVGETION_COLOR;
        [_btnConnects addSubview:ConnectsLab];
        
        _btnOffLine = [UIButton buttonWithType:UIButtonTypeCustom];
//       _btnOffLine.backgroundColor = SystemGrayColor;
        [_btnOffLine setBackgroundImage:[UIImage imageWithFile:@"btn- contactsBlueR.png"] forState:UIControlStateNormal];
        [_btnOffLine setBackgroundImage:[UIImage imageWithFile:@"btn- contactsGrayR.png"] forState:UIControlStateSelected];
        [_btnOffLine setFrame:CGRectMake(ScreenWidth/2, 0, ScreenHeight/20, ScreenHeight/30)];
        [_btnOffLine setTitle:@"离线" forState:UIControlStateNormal];
        [_btnOffLine setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.800] forState:UIControlStateNormal];
//        [_btnOffLine setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [_btnOffLine.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        _btnOnline = [UIButton buttonWithType:UIButtonTypeCustom];
//        _btnOnline.backgroundColor = SystemGrayColor;
        
        [_btnOnline setBackgroundImage:[UIImage imageWithFile:@"btn- contactsBlueL.png"] forState:UIControlStateNormal];
        [_btnOnline setBackgroundImage:[UIImage imageWithFile:@"btn- contactsGrayL.png"] forState:UIControlStateSelected];
        [_btnOnline setFrame:CGRectMake(ScreenWidth/2-ScreenHeight/20, 0, ScreenHeight/20, ScreenHeight/30)];
        [_btnOnline setTitle:@"在线" forState:UIControlStateNormal];
        [_btnOnline setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.800] forState:UIControlStateNormal];
//        [_btnOnline setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [_btnOnline.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [_btnOffLine addTarget:self action:@selector(clickchange:) forControlEvents:UIControlEventTouchUpInside];
        [_btnOnline addTarget:self action:@selector(clickchange:) forControlEvents:UIControlEventTouchUpInside];
        

        [_viewChoose addSubview:_btnOnline];
        [_viewChoose addSubview:_btnOffLine];
        [_viewChoose addSubview:_btnMessages];
        [_viewChoose addSubview:_btnConnects];
    }
    return _viewChoose;
}
//获取版本更新提示
- (void)updateSystemVersion {
    
    [HTTPRequest httpWithPost:@"/profile/version" Param:nil Success:^(id obj) {
        
        if (SUCCESS) {
            NSDictionary *dataDic = obj[@"data"];
            self.currentVersion = dataDic[@"ios"];
//            NSString *key = (NSString *)kCFBundleVersionKey;
            NSString *saveVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
            
            if ([self.currentVersion isEqualToString:saveVersion]) {
                
                NSLog(@"self.currentVersion==%@,saveVersion==%@",self.currentVersion,saveVersion);
            }
            else{
                NSLog(@"self.currentVersion==%@,saveVersion==%@",self.currentVersion,saveVersion);
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"版本更新通知" message:@"育儿问一问有新版本，是否愿意前往更新" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSString *urlstring = @"https://itunes.apple.com/cn/app/yu-er-wen-yi-wen/id1033218639?mt=8";
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstring]];
                }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        }
        
    } Fail:^(NSString *errorMsg) {
        
    }];
    
}
//选择在线离线按钮
-(void)clickchange:(UIButton *)sender
{
    
    NSLog(@"sender = %@",sender);
    if ([sender isEqual:_btnOffLine])
    {
                [HTTPRequest httpWithGet:@"/cus/setOnlineStatus" Param:@{@"onlineStatus":@0,} Success:^(id obj) {
            if (SUCCESS)
            {
                NSLog(@"obj=%@",obj);
                [_btnOnline setSelected:YES];
                [_btnOffLine setSelected:NO];
                [_btnOffLine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [_btnOnline setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.800] forState:UIControlStateNormal];

            }
            MBHide
        } Fail:^(NSString *errorMsg) {
            MBHide
            MBE_Sys
        }];

        NSLog(@"离线");
    }
    else if ([sender isEqual:_btnOnline])
    {
                [HTTPRequest httpWithGet:@"/cus/setOnlineStatus" Param:@{@"onlineStatus":@1,} Success:^(id obj) {
            if (SUCCESS)
            {
                [_btnOnline setSelected:NO];
                [_btnOffLine setSelected:YES];
                [_btnOffLine setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.800] forState:UIControlStateNormal];
                [_btnOnline setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

                NSLog(@"obj=%@",obj);
            }
            MBHide
        } Fail:^(NSString *errorMsg) {
            MBHide
            MBE_Sys
        }];

        NSLog(@"在线");
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.viewChoose setHidden:YES];
    //travel
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC hiddenTabbarView];

    //
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.viewChoose setHidden:NO];
    //travel
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC appearTabbarView];
    //
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(needRefreshHead:) name:@"notiRefreshHeadUrl" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateSystemVersion];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem navigationRightWithTitle:nil Img:[UIImage imageWithFile:@"app-icon.png"] Delegate:self Action:@selector(clickPersonal) IsHeader:YES];
    [self.navigationController.navigationBar setTranslucent:NO];
//    [self.navigationItem navigationLeftWithTitle:nil Img:nil Delegate:nil Action:nil];
    
    _slideVC = [[SlideVC alloc] init];
    [_slideVC setDelegate:self];
    [_slideVC setNavigationCurrent:self.navigationController];
    [self.view addSubview:_slideVC.view];
//    _connectsVC = [[ConnectsVC alloc]init];
//    [_connectsVC setdele]

    _slideVC = [[SlideVC alloc] init];
    [_slideVC setDelegate:self];
    [_slideVC setNavigationCurrent:self.navigationController];
    [self.view addSubview:_slideVC.view];
    
    [self.navigationController.navigationBar addSubview:self.viewChoose];
    [self clickChoose:_btnMessages];
    
    
   
    [self.navigationController.navigationBar addSubview:self.viewChoose];
    [self clickchange:_btnOnline];
}

- (void)needRefreshHead:(NSNotification *)notification
{
    [self.navigationItem navigationRightWithTitle:nil Img:[UIImage imageWithFile:@"app-icon.png"] Delegate:self Action:@selector(clickPersonal) IsHeader:YES];
}

- (void)slideSwitch:(NSInteger)switchIndex
{
    [_btnMessages setSelected:(switchIndex == 0)];
    [_btnConnects setSelected:(switchIndex == 1)];
}

#pragma mark 选择消息或联系人
- (void)clickChoose:(UIButton *)sender
{
    NSLog(@"消息 = %@",sender);
    if ([sender isEqual:_btnMessages]) {
        [_btnMessages setSelected:YES];
        [_btnConnects setSelected:NO];
        
        MessagesLab.backgroundColor = [UIColor whiteColor];
        ConnectsLab.backgroundColor = SYSNAVGETION_COLOR;
        [_slideVC slideIndex:0];
        //travel
        MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
        [tabVC itemBtnClick:tabVC.msgBtn changeColorOnly:YES];
        //
    }
    else {
        [_btnConnects setSelected:YES];
        [_btnMessages setSelected:NO];
        MessagesLab.backgroundColor = SYSNAVGETION_COLOR;
        ConnectsLab.backgroundColor = [UIColor whiteColor];
        [_slideVC slideIndex:1];
        //travel
        MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
        [tabVC itemBtnClick:tabVC.conBtn changeColorOnly:YES];
        //
    }
    
    [_slideVC.waithVC.searchBar resignFirstResponder];
}

#pragma mark 点击个人中心
- (void)clickPersonal
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonalVC *personal = [story instantiateViewControllerWithIdentifier:@"StoryIDPersonal"];
    [self.navigationController pushViewController:personal animated:YES];
}
@end
