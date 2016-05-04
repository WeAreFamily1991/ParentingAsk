//
//  HelpVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/20.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "HelpVC.h"
#import "UINavigationItem+ItemCustom.h"
@interface HelpVC ()<UIWebViewDelegate>

@end

@implementation HelpVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"帮助中心";
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.00];
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
    
    NSString *url =[NSString stringWithFormat:@"%@/profile/help",HostAddress] ;
    UIWebView *_webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    _webview.scalesPageToFit = YES;
    _webview.delegate=self;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webview loadRequest:request];
    [self.view addSubview:_webview];}
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
