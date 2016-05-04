//
//  IntegralVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "IntegralVC.h"
#import "MainTabBarViewController.h"
#import "UINavigationItem+ItemCustom.h"
@interface IntegralVC ()
{
    UILabel *_salaryLab;
    UILabel *_rewardLab;
}
@end

@implementation IntegralVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"积分";
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
 [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    [self setIntegral];
}
-(void)setIntegral
{
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/4, ScreenWidth/4, ScreenWidth/2, ScreenWidth/2)];
    img.layer.cornerRadius = ScreenWidth/4;
    img.layer.masksToBounds = ScreenWidth/4;
    img.backgroundColor = SystemGreenColor;
    [self.view addSubview:img];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/2-ScreenWidth/3)/2, ScreenWidth/4-ScreenWidth/10, ScreenWidth/3, ScreenWidth/10)];
    label.text = @"接单工资";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    
    [img addSubview:label];
    _salaryLab = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/2-ScreenWidth/3)/2, ScreenWidth/5, ScreenWidth/3, ScreenWidth/5)];
    _salaryLab.text = @"1823.65";
    _salaryLab.textAlignment = NSTextAlignmentCenter;
    _salaryLab.textColor = [UIColor whiteColor];
    _salaryLab.font = [UIFont systemFontOfSize:25];
    
    [img addSubview:_salaryLab];
    
    
    
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/4,ScreenWidth-ScreenWidth/8, ScreenWidth/2, ScreenWidth/2)];
    img2.layer.cornerRadius = ScreenWidth/4;
    img2.layer.masksToBounds = ScreenWidth/4;
    img2.backgroundColor = SystemGreenColor;
    [self.view addSubview:img2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/2-ScreenWidth/3)/2, ScreenWidth/4-ScreenWidth/10, ScreenWidth/3, ScreenWidth/10)];
    label2.text = @"奖励金额";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:16];
    
    [img2 addSubview:label2];
    _rewardLab = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/2-ScreenWidth/3)/2, ScreenWidth/5, ScreenWidth/3, ScreenWidth/5)];
    _rewardLab.text = @"2105.13";
    _rewardLab.textAlignment = NSTextAlignmentCenter;
    _rewardLab.textColor = [UIColor whiteColor];
    _rewardLab.font = [UIFont systemFontOfSize:25];
    
    
    [img2 addSubview:_rewardLab];

}
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
