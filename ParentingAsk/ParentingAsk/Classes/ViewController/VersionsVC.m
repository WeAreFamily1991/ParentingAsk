//
//  VersionsVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/20.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "VersionsVC.h"
#import "UINavigationItem+ItemCustom.h"
@interface VersionsVC ()

@end

@implementation VersionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"版本";
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth/8, ScreenHeight/5, ScreenWidth/4, ScreenWidth/4)];
    img.layer.cornerRadius = ScreenWidth/8;
    img.layer.masksToBounds = ScreenWidth/8;
    img.image = [UIImage imageNamed:@"222.jpg"];
    [self.view addSubview:img];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight/3, ScreenWidth, ScreenHeight/10)];
    label.text = @"育儿问一问2.0.0";
    label.textColor = SystemGrayColor;
    label.font = [UIFont systemFontOfSize:22];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UILabel *comanyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,2*ScreenHeight/3+30, ScreenWidth, ScreenHeight/15)];
    comanyLabel.text = @"苏州问一问健康管理咨询有限公司 版权所有";
    comanyLabel.textColor = SystemGrayColor;
    comanyLabel.font = [UIFont systemFontOfSize:12];
    comanyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:comanyLabel];
    
    UILabel *Englishabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 2*ScreenHeight/3 +ScreenHeight/15, ScreenWidth, ScreenHeight/10)];
    Englishabel.text = @"Copright 2016-2017 Wellwin Health.ALL Rights Reserved";
    Englishabel.textColor = SystemGrayColor;
    Englishabel.font = [UIFont systemFontOfSize:12];
    Englishabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:Englishabel];
    
    
    
    
    
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
