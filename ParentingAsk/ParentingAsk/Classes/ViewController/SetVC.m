//
//  SetVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "SetVC.h"
#import "MainTabBarViewController.h"
#import "UINavigationItem+ItemCustom.h"
#import "SetCell.h"
#import "EditPasswordVC.h"
#import "HelpVC.h"
#import "ConnectVC.h"
#import "VersionsVC.h"
#import "LoginVC.h"

@interface SetVC ()
@property (strong,nonatomic)NSArray *titArr,*imgArr;

@end

@implementation SetVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    self.title = @"设置";
    [self GreatTab];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];

      self.imgArr =[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"mimaxiugai"],[UIImage imageNamed:@"bangzhuzhongxin"],[UIImage imageNamed:@"lianxiwom"],[UIImage imageNamed:@"banben"], nil];
    self.titArr = [[NSArray alloc]initWithObjects:@"修改密码", @"帮助中心",@"联系我们",@"版本",nil];
//    [self setExtraCellLineHidden:self.tableView];
}
-(void)GreatTab
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)style:UITableViewStylePlain ];
    
    
    self.tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.00];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.tableView.separatorStyle = NO;
    
    
    [self.view addSubview:self.tableView];
    
    
    
}

#pragma mark 设置区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    else return 0;
}
#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
        
        return ScreenHeight/15;
    else
        return ScreenHeight/10;
}

- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    [tableView setTableHeaderView:view];
    
}

-(void)btnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *index = @"cell";
    if (indexPath.section==0)
    {
        SetCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
        
        if (cell==nil)
        {
            cell =[[SetCell alloc]initWithStyle:0 reuseIdentifier:index];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titImg.image = self.imgArr[indexPath.row];
        
        cell.titLab.text =self.titArr[indexPath.row];
        return cell;
 
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:index];
    }
    self.tableView.separatorStyle = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    UIButton *btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnExit setFrame:CGRectMake(ScreenWidth/10, ScreenHeight/8-ScreenHeight/15, ScreenWidth-ScreenWidth/5, ScreenHeight/15)];
    [btnExit setTitle:@"退出" forState:UIControlStateNormal];
    [btnExit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnExit.layer setCornerRadius:4.0f];
    [btnExit.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [btnExit setBackgroundColor:SystemGreenColor];
    [btnExit addTarget:self action:@selector(clickExit_out) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btnExit];
    
    return cell;
    
}
//#pragma mark 退出登录
- (void)clickExit_out
{
    MBShow
    [HTTPRequest httpWithPost:@"/cus/logout" Param:@{} Success:^(id obj) {
        if (SUCCESS)
        {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginVC *loginVC = [story instantiateViewControllerWithIdentifier:@"StoryIDLogin"];
            [HTTPRequest shareRequest].sessionID = nil;
            [self.navigationController pushViewController:loginVC animated:NO];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:@"" forKey:@"PersonIdPhoto"];
            [defaults setValue:@"" forKey:@"PersonWorkPhoto"];
            [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
            
     
        }
        MBHide
        
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}
//弹出框定时器

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            EditPasswordVC *pswSubmit = [story instantiateViewControllerWithIdentifier:@"StoryIDEditPassword"];
            [self.navigationController pushViewController:pswSubmit animated:YES];
        }
        else if (indexPath.row==1)
        {
            HelpVC *helpVC = [[HelpVC alloc]init];
            [self.navigationController pushViewController:helpVC animated:YES];
        }
        else if (indexPath.row==2)
            
        {
            ConnectVC *connVC = [[ConnectVC alloc]init];
            [self.navigationController pushViewController:connVC animated:YES];
        }
        else if (indexPath.row==3)
        {
            VersionsVC *versionVC = [[VersionsVC alloc]init];
            [self.navigationController pushViewController:versionVC animated:YES];
            
        }

    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
