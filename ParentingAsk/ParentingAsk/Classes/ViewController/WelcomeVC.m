//
//  WelcomeVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "WelcomeVC.h"
#import "MainTabBarViewController.h"
#import "UINavigationItem+ItemCustom.h"
#import <ShareSDK/ShareSDK.h>
#import "YasinCustomAlertView.h"
@interface WelcomeVC ()

@end

@implementation WelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    self.title = @"邀请";
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
    [self Great];
    [self GreatH];
  
    [self GreatBtn];
}
#pragma mark 创建基本控件
-(void)Great
{
    UIImageView  *headImg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"head.png"]];
    headImg.frame = CGRectMake(ScreenWidth/2 -ScreenWidth/10,ScreenHeight/8, ScreenWidth/5, ScreenWidth/5);
    headImg.layer.cornerRadius = ScreenWidth/10;
    headImg.layer.masksToBounds = ScreenWidth/10;
    [self.view addSubview:headImg];
    
    
    UILabel *welLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight/10 +ScreenWidth/4, ScreenWidth, ScreenHeight/20)];
    welLab.text = @"邀请你的医生朋友，你将获得¥30";
    welLab.textColor = [UIColor blackColor];
    welLab.font = [UIFont systemFontOfSize:16];
    
    welLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:welLab];
    
    UIButton *DetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    DetailBtn.frame = CGRectMake(ScreenWidth/2 -ScreenWidth/6,3 * ScreenHeight/20 +ScreenWidth/4  , ScreenWidth/3, ScreenHeight/20);
    [DetailBtn setTitleColor:SystemGreenColor forState:UIControlStateNormal];
    [DetailBtn setTitle:@"点击详情" forState:UIControlStateNormal];
    DetailBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [DetailBtn addTarget:self action:@selector(detailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:DetailBtn];

    UILabel *peoLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/7, ScreenHeight/4 +ScreenWidth/4, ScreenWidth/2, ScreenHeight/20)];
    peoLab.text = @"我邀请的人数";
    peoLab.textColor = [UIColor blackColor];
    peoLab.font = [UIFont systemFontOfSize:15];
    
    peoLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:peoLab];
    UILabel *countLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/7, 3 * ScreenHeight/10 +ScreenWidth/4, ScreenWidth/2, ScreenHeight/20)];
    countLab.text = @"我获得的奖励";
    countLab.textColor = [UIColor blackColor];
    countLab.font = [UIFont systemFontOfSize:15];
    
    countLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:countLab];
    
    UILabel *peoCountLab = [[UILabel alloc]initWithFrame:CGRectMake(7 * ScreenWidth/20, ScreenHeight/4 +ScreenWidth/4, ScreenWidth/2, ScreenHeight/20)];
    peoCountLab.text = @"个数";
    peoCountLab.textColor =SystemGreenColor;
    peoCountLab.font = [UIFont systemFontOfSize:15];
    peoCountLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:peoCountLab];
    
    UILabel *rewardLab = [[UILabel alloc]initWithFrame:CGRectMake(7 * ScreenWidth/20, 3 * ScreenHeight/10 +ScreenWidth/4, ScreenWidth/2, ScreenHeight/20)];
    rewardLab.text = @"¥100";
    rewardLab.textColor = SystemGreenColor;
    rewardLab.font = [UIFont systemFontOfSize:15];
    
    rewardLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rewardLab];
    
    
}

-(void)GreatH
{
    UILabel *sendLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth/4, 26 * ScreenHeight/48 , ScreenWidth/2, ScreenHeight/20)];
    sendLab.text = @"发送您的邀请码";
    sendLab.textColor = SystemGrayColor;
    sendLab.font = [UIFont systemFontOfSize:12];
    sendLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:sendLab];
    
    
    UILabel *countLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth/4, 7 * ScreenHeight/12 , ScreenWidth/2, ScreenHeight/20)];
    countLab.text = @"dsdsdsdewewe";
    countLab.textColor = [UIColor blackColor];
    countLab.font = [UIFont systemFontOfSize:17];
    
    countLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:countLab];
}
-(void)detailBtnClick
{

    [YasinCustomAlertView showTitle:nil Message:@"分享model推荐码给其他医生，他们注册审核后，当月成功接单超过五单(有效单)，即可获得30元奖励" DetermineButtonTitle:@"确定" DetermineBlock:^{
        NSLog(@"你点击了确定！");
    }];

}
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)GreatBtn
{
    UIButton *WechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    WechatBtn.frame = CGRectMake(ScreenWidth/8,7 * ScreenHeight/10  , ScreenWidth-ScreenWidth/4, ScreenHeight/18);
    [WechatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    WechatBtn.layer.cornerRadius = ScreenWidth/60;
    WechatBtn.layer.masksToBounds = ScreenWidth/60;
    WechatBtn.backgroundColor = SystemGreenColor;
    
    [WechatBtn setTitle:@"一键分享给你的医生好友" forState:UIControlStateNormal];
    [WechatBtn addTarget:self action:@selector(WechatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WechatBtn];
    
}
#pragma mark 分享的点击按钮
-(void)WechatBtnClick
{
    //(1)设置要截屏的图片的大小
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    //(2)对哪个视图截图固定大小的图片
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //(3)获取截图的图片对象
    UIImage *imge = UIGraphicsGetImageFromCurrentImageContext();
    
    //(4)结束绘制图片
    UIGraphicsEndImageContext();
    
    //(5)保存到相册
    UIImageWriteToSavedPhotosAlbum(imge, nil,nil, nil);
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:nil
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"育儿问一问"
                                                  url:@"http://www.baidu.com"
                                          description:@"我们的育儿专家"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:self.view arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                                }
                            }];

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC appearTabbarView];
    //
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
