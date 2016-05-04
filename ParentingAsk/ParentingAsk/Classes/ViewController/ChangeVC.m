//
//  ChangeVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/4/13.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "ChangeVC.h"
#import "MainTabBarViewController.h"
#import "UINavigationItem+ItemCustom.h"
#import "ChangeCell.h"
@interface ChangeVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property(nonatomic,strong)NSString *nameStr,*IDNumStr,*bankStr;

@end

@implementation ChangeVC

-(void)httpRequest
{
    [HTTPRequest httpWithGet:@"/cus/detail" Param:@{} Success:^(id obj) {
        if (SUCCESS)
        {
            self.nameStr = [[obj valueForKey:@"data"] valueForKey:@"card_name"];
            self.IDNumStr = [[obj valueForKey:@"data"] valueForKey:@"card_no"];
            self.bankStr = [[obj valueForKey:@"data"] valueForKey:@"card_account"];
        }
        else
        {
            MBHide
            MESSAGE
        }
        [self.tableView reloadData];
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE(@"数据LOSE")
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    [self httpRequest];
    self.tableView.separatorStyle = NO;
    self.title = @"银行卡修改";
    
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
    [self.btnSave.layer setCornerRadius:3.0f];
    [self.btnSave setBackgroundColor:[UIColor whiteColor]];
//    [self.btnSave addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* rightBun = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBun.frame = CGRectMake(0, 0, ScreenWidth/20
                                , ScreenWidth/20);
    [rightBun setBackgroundImage:[UIImage imageNamed:@"write_new"] forState:normal];
    [rightBun addTarget:self action:@selector(Shareit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* right = [[UIBarButtonItem alloc] initWithCustomView:rightBun];
    self.navigationItem.rightBarButtonItem = right;
}
-(void)Shareit
{
    ChangeCell *cellO = (ChangeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cellO.textDesc setEnabled:YES];
    ChangeCell *cellN = (ChangeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cellN.textDesc setEnabled:YES];
    ChangeCell *cellNA = (ChangeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [cellNA.textDesc setEnabled:YES];
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
//    return ScreenHeight/80;
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeCell *cell = [ChangeCell cellWithTableView:tableView IndexPath:indexPath];
    [cell.textDesc setDelegate:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0)
        
    {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"name-green.png"]];
        img.frame = CGRectMake(ScreenWidth/6.8, ScreenWidth/20, ScreenHeight/25, ScreenHeight/25);
        cell.textDesc.secureTextEntry = NO;
        cell.textDesc.text = self.nameStr;
        [cell.textDesc setEnabled:NO];
        [cell.contentView addSubview:img];
    }
    else if (indexPath.row == 1)
    {
        [cell.textDesc setKeyboardType:UIKeyboardTypeNumberPad];
        cell.textDesc.secureTextEntry = NO;
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"account-green.png"]];
        img.frame = CGRectMake(ScreenWidth/6.8, ScreenWidth/20, ScreenHeight/25, ScreenHeight/25);
         cell.textDesc.text = self.IDNumStr;
        [cell.textDesc setEnabled:NO];
        [cell.contentView addSubview:img];
    }
    else if (indexPath.row == 2)
    {
        cell.textDesc.secureTextEntry = NO;
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"deposit-green.png"]];
        img.frame = CGRectMake(ScreenWidth/6.8, ScreenWidth/20, ScreenHeight/25, ScreenHeight/25);
         cell.textDesc.text = self.bankStr;
        [cell.textDesc setEnabled:NO];
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
    ChangeCell *cellO = (ChangeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ChangeCell *cellN = (ChangeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    ChangeCell *cellNA = (ChangeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    if (cellO.textDesc.text.length == 0 || cellN.textDesc.text.length == 0 || cellNA.textDesc.text.length == 0) {
        MBE(@"请完善信息");
        return;
    }
    
    else {
        
        
        //        MBShow
        [HTTPRequest httpWithPost:@"/cus/bindCard" Param:@{@"card_name": cellO.textDesc.text, @"card_no": cellN.textDesc.text, @"card_account": cellNA.textDesc.text} Success:^(id obj) {
            NSLog(@"obj=%@",obj);
            
            
            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:obj[@"success"],@"textOne", nil];
            
            //创建通知
            
            NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
            
            //通过通知中心发送通知
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            MBE(@"修改成功")
            [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
//            [self.navigationController popViewControllerAnimated:YES];
            
            
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
