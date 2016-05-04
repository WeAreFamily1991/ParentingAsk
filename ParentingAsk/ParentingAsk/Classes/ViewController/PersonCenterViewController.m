//
//  PersonCenterViewController.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/15.
//  Copyright © 2016年 Jerry. All rights reserved.
//


#import "PersonCenterViewController.h"
#import "CustomTableViewCell.h"
#import "MainTabBarViewController.h"
#import "MoneyVC.h"
#import "IntegralVC.h"
#import "PersonalInfoSubmitVC.h"
#import "CommondVC.h"
#import "IDCardVC.h"
#import "WelcomeVC.h"
#import "SetVC.h"
#import "User.h"
#import "CustomHeaderCell.h"
#import "ChangeVC.h"
#import "AuthSuccessVC.h"

#import "PersonalVC.h"
@interface PersonCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
     User *_user;
    NSString *_countStr;
    NSString *_NOStr;
    
}
@property (nonatomic,retain)NSString *perTimeStr,*perGoodsStr,*salaryStr,*bonusStr,*loveStr;
@property (nonatomic,assign) int servicetimes;
@property (strong,nonatomic)NSArray *titArr,*imgArr;
@end

@implementation PersonCenterViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

    [self obtainPerson:YES];
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC appearTabbarView];
    
   
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
// [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obtainPersonCount) name:@"SlideSwitchLeft" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obtainPersonCount) name:kNewMessageNotification object:nil];
    
    NSLog(@"_user = =%@",_user);
    self.edgesForExtendedLayout = UIRectEdgeNone;
//self.view.backgroundColor = [UIColor redColor];

//       self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor] ,NSFontAttributeName : [UIFont boldSystemFontOfSize:17]};
//self.title = @"个人中心";
    self.imgArr =[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"renzhen"],[UIImage imageNamed:@"changyongyu"],[UIImage imageNamed:@"yinhangka"],[UIImage imageNamed:@"xinxi"], nil];
    self.titArr = [[NSArray alloc]initWithObjects:@"认证资料", @"常用语设置",@"银行卡绑定",@"基本信息",@"设置",nil];
    [self GreatTab];
//    [self GreatHeader];
    [self setExtraCellLineHidden:self.tableView];
    
    
    
    
}

- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    [tableView setTableHeaderView:view];
    
}

- (void)obtainPerson:(BOOL)isRefresh
{
    MBShow
    [HTTPRequest httpWithGet:@"/cus/detail" Param:@{} Success:^(id obj)
    {
        if (SUCCESS)
        {
            if ([obj valueForKey:@"data"])
            {
                NSLog(@"%@",[[obj valueForKey:@"data"]valueForKey:@"service_times"]);
                _NOStr =[[obj valueForKey:@"data"]valueForKey:@"card_no"];
                self.servicetimes= [[[obj valueForKey:@"data"]valueForKey:@"service_times"] intValue];
                self.perTimeStr = [[obj valueForKey:@"data"]valueForKey:@"perTime"];
                self.perGoodsStr = [[obj valueForKey:@"data"]valueForKey:@"perGoods"];
                self.salaryStr = [[obj valueForKey:@"data"]valueForKey:@"salary"];
                self.loveStr = [[obj valueForKey:@"data"]valueForKey:@"salary"];
                
                NSLog(@"self.salaryStr=%@",self.salaryStr);
                self.bonusStr = [[obj valueForKey:@"data"]valueForKey:@"bonus"];
                _user = [JsonToModel objectFromDic:[obj valueForKey:@"data"] className:@"User"];
                [HTTPRequest shareRequest].currentUser = _user;
                NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                [userDef setValue:_user.headurl forKey:_user.phone];
                //认证状态和图片
                [userDef setValue:[NSString stringWithFormat:@"%d",_user.type] forKey:@"_type"];
                [userDef setValue:_user.idurl forKey:@"PersonIdPhoto"];
                [userDef setValue:_user.ceurl forKey:@"PersonWorkPhoto"];
                [userDef setValue:_user.oturl forKey:@"PersonOturlPhoto"];
                
                if (isRefresh) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"notiRefreshHeadUrl" object:nil];
                }
            }
            [self.tableView reloadData];
        }
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}
-(void)btnClick
{
    
}
-(void)GreatTab
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    

}
//钱的点击事件
-(void)monBtnClick
{
//    MoneyVC *monVC = [[MoneyVC alloc]init];
//    [self.navigationController pushViewController:monVC animated:YES];
}
//积分点击事件


//头像点击事件
-(void)headerBtn
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else if (section==1)
    {
        return 4;
    }
    return 1;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.01;
    }
    else return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
        
        return ScreenHeight/3 -ScreenHeight/14;
    else
        return ScreenHeight/15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *index = @"cell";
    if (indexPath.section==0)
    {
        CustomHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
        if (cell==nil)
        {
            cell =[[CustomHeaderCell alloc]initWithStyle:0 reuseIdentifier:index];
        }
        self.tableView.separatorStyle = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
         HTTPImgView(cell.headIMG, _user.headurl);
        NSLog(@" _user.headurl==%@", _user.headurl);
        cell.nameLab.text =_user.nickname?_user.nickname:@"";
        if ([self.perGoodsStr isEqual:@"(null)"])
        {
            cell.presentLab.text =@"";
        }
        else
        {
            cell.presentLab.text = [NSString stringWithFormat:@"%@%%",self.perGoodsStr ] ;
        }
        
        cell.loveCountLab.text =[NSString stringWithFormat:@"%@", self.loveStr];
        cell.secLab.text =[NSString stringWithFormat:@"%@", self.perTimeStr];
        cell.countLab.text =[NSString stringWithFormat:@"%zd", self.servicetimes];
        [cell.iglBtn setTitle:[NSString stringWithFormat:@"%d分", _user.integral] forState:UIControlStateNormal];
        [cell.moneyBtn setTitle:self.salaryStr forState:UIControlStateNormal];
        [cell.iglBtn addTarget:self action:@selector(iglBtnClick) forControlEvents:UIControlEventTouchUpInside];
        cell.moneyIMG.image = [UIImage imageNamed:@"money"];
        cell.iglIMG.image = [UIImage imageNamed:@"integral"];
        if (_user.type == 1) {
            cell.authLab.text = @"一类 已认证";
        }
        else if (_user.type == 2){
            cell.authLab.text =@"二类 已认证";
        }
        else {
             cell.authLab.text =@"未认证";
        }

        return cell;

    }
   
    else if (indexPath.section==1)
    {
        CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
        
        if (cell==nil)
        {
            cell =[[CustomTableViewCell alloc]initWithStyle:0 reuseIdentifier:index];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         self.tableView.separatorStyle = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titImg.image = self.imgArr[indexPath.row];
        
        cell.titLab.text =self.titArr[indexPath.row];
//        if (indexPath.row==2)
//        {
//           if ([_countStr isEqualToString:@"1"])
//           {
//                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth/4, 0, ScreenWidth/4, ScreenHeight/15)];
//                label.text = @"已绑定";
//                label.textColor = [UIColor redColor];
//                label.font = [UIFont systemFontOfSize:16];
//                [cell.contentView addSubview:label];
//            }
//        }
        return cell;
    }        
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    
    if (cell==nil)
    {
        cell =[[CustomTableViewCell alloc]initWithStyle:0 reuseIdentifier:index];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.tableView.separatorStyle = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titImg.image = [UIImage imageNamed:@"set"];
    cell.lineLab.backgroundColor = [UIColor clearColor];
    cell.titLab.text =@"设置";
    return cell;
    
    


   }


#pragma mark 积分按钮点击事件
-(void)iglBtnClick
{
//    IntegralVC *itgVC = [[IntegralVC alloc]init];
//    [self.navigationController pushViewController:itgVC animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==1)
    {
        NSLog(@"indexPath.row =%ld",(long)indexPath.row);
         NSLog(@"section =%ld",(long)indexPath.section);
        if (indexPath.row==0)
        {
            AuthSuccessVC *authVC = [[AuthSuccessVC alloc]init];
            [self.navigationController pushViewController:authVC animated:YES];
        }
        else if (indexPath.row==1)
        {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CommondVC *commond = [story instantiateViewControllerWithIdentifier:@"CommondVC"];
            [self.navigationController pushViewController:commond animated:YES];
        }
        else if (indexPath.row==2)
        {
            NSLog(@"_codeStr=%@",_NOStr);
            if ([_NOStr isEqual:[NSNull null]])
            {
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                IDCardVC *card = [story instantiateViewControllerWithIdentifier:@"IDCardVC"];
                [self.navigationController pushViewController:card animated:YES];
                
            }
            else
            {
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ChangeVC *changVC = [story instantiateViewControllerWithIdentifier:@"changeVC"];
                [self.navigationController pushViewController:changVC animated:YES];
            }
        }
        else if (indexPath.row==3)
        {
            
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PersonalVC *personal = [story instantiateViewControllerWithIdentifier:@"StoryIDPersonal"];
            [self.navigationController pushViewController:personal animated:YES];

        }
//        else if (indexPath.row==4)
//            
//        {
//           
//            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            WelcomeVC *welcome = [story instantiateViewControllerWithIdentifier:@"WelcomeVC"];
//            [self.navigationController pushViewController:welcome animated:YES];
//        }
//        
    }
    
    else if (indexPath.section==2)
        
    {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SetVC*set = [story instantiateViewControllerWithIdentifier:@"SetVC"];
        [self.navigationController pushViewController:set animated:YES];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.hidden = NO;
     MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC hiddenTabbarView];
    //
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
   
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
