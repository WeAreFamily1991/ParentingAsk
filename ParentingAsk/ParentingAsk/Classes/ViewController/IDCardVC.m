//
//  IDCardVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "IDCardVC.h"
#import "MainTabBarViewController.h"
#import "UINavigationItem+ItemCustom.h"
#import "IDCardCell.h"
@interface IDCardVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end

@implementation IDCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    self.tableView.separatorStyle = NO;
   self.title = @"银行卡绑定";

    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
    [self.btnSave.layer setCornerRadius:3.0f];
    [self.btnSave setBackgroundColor:SystemGreenColor];
    [self.btnSave addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    
   
}

-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
//#pragma mark 设置区头的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//   
//        return ScreenHeight/80;
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IDCardCell *cell = [IDCardCell cellWithTableView:tableView IndexPath:indexPath];
    [cell.textDesc setDelegate:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0)
        
    {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"name-green.png"]];
        img.frame = CGRectMake(ScreenWidth/6.8, ScreenWidth/20, ScreenHeight/25, ScreenHeight/25);
        cell.textDesc.secureTextEntry = NO;
        [cell.contentView addSubview:img];
    }
    else if (indexPath.row == 1)
    {
        [cell.textDesc setKeyboardType:UIKeyboardTypeNumberPad];
         cell.textDesc.secureTextEntry = NO;
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"account-green.png"]];
        img.frame = CGRectMake(ScreenWidth/6.8, ScreenWidth/20, ScreenHeight/25, ScreenHeight/25);
        
        [cell.contentView addSubview:img];
    }
    else if (indexPath.row == 2)
    {
         cell.textDesc.secureTextEntry = NO;
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"deposit-green.png"]];
        img.frame = CGRectMake(ScreenWidth/6.8, ScreenWidth/20, ScreenHeight/25, ScreenHeight/25);
        
        [cell.contentView addSubview:img];
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight/10;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC appearTabbarView];
    //
}

- (void)clickSave
{
    IDCardCell *cellO = (IDCardCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    IDCardCell *cellN = (IDCardCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    IDCardCell *cellNA = (IDCardCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    if (cellO.textDesc.text.length == 0 || cellN.textDesc.text.length == 0 || cellNA.textDesc.text.length == 0) {
        MBE(@"请完善信息");
        return;
    }
   
    else {
       
//        MBShow
        [HTTPRequest httpWithPost:@"/cus/bindCard" Param:@{@"card_name": cellO.textDesc.text, @"card_no": cellN.textDesc.text, @"card_account": cellNA.textDesc.text} Success:^(id obj) {
            NSLog(@"obj=%@",obj);
           
             MBE(@"绑定成功")
             [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
            
            
        } Fail:^(NSString *errorMsg) {
            MBHide
            MBE_Sys
        }];
    }
}
- (void)timerFireMethod:(NSTimer*)theTimer
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
