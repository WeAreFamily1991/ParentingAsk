//
//  statusVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/4/22.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "statusVC.h"
#import "UINavigationItem+ItemCustom.h"
@interface statusVC ()

@end

@implementation statusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes =[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    self.title = @"认证说明";
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
   
    UIImageView *imageView =[[UIImageView alloc]init];
    imageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    imageView.image = [UIImage imageNamed:@"approv.png"];
    [self.view addSubview:imageView];
}
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
