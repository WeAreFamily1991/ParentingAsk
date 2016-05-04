

#import "PersonalVC.h"
#import "PersonalEditVC.h"
#import "CellPersonInfo.h"
#import "User.h"
#import "LoginVC.h"
#import "CellPersonInfoTemp.h"
#import "PersonalInfoSubmitVC.h"
#import "MainTabBarViewController.h"

@interface PersonalVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation PersonalVC
{
    User *_user;
    BOOL _isLaySender1;
    BOOL _isLaySender2;
    UIView *_viewStar;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self obtainPerson:YES];
    // zou tabbar不显示
//    //travel
//    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
//    [tabVC appearTabbarView];
    //
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //travel
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC appearTabbarView];
    //
}

- (void)viewDidLoad {
    [super viewDidLoad];
       self.title =@"基本信息";
//    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    
//    if (_isShowBack) {
//        
//        UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 12, 20, 20)];
//        [btnBack setImage:[UIImage imageWithFile:@"返回"] forState:UIControlStateNormal];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
//    }//add by xiaoxiao
    
//    [self.view setBackgroundColor:SystemGrayColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self obtainPerson:YES];
//    NSLog(@"_user = =%@",_user);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 6;
        case 1:
        {
            return (_isLaySender1?3:0);
        }
        case 2:
        {
            return (_isLaySender2?3:0);
        }
        case 3:
            return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CellPersonInfo *cell = [CellPersonInfo cellWithTableView:tableView IndexPath:indexPath];
        HTTPImgView(cell.imageAvatar, _user.headurl);
//        NSLog(@" _user.headurl==%@", _user.headurl);
        [cell.labNickName setText:_user.nickname?_user.nickname:@""];
        [cell.labUserName setText:[NSString stringWithFormat:@"用户名: %@", _user.username?_user.username:@""]];
        [cell.labLevel setHidden:NO];
        if (_user.type == 1) {
            [cell.labLevel setText:@"一类 已认证"];
        }
        else if (_user.type == 2){
            [cell.labLevel setText:@"二类 已认证"];
        }
        else {
            [cell.labLevel setHidden:YES];
        }
        
        switch (indexPath.row) {
            case 0:
            {
                [cell.btnEdit addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 1:
            {
                [cell.textDesc setText:[NSString stringWithFormat:@"%@", _user.locationName?_user.locationName:@""]];
            }
                break;
            case 2:
            {
                if (_user.type == 1) {
                    [cell.authLab setText:@"一类 已认证"];
                }
                else if (_user.type == 2){
                    [cell.authLab setText:@"二类 已认证"];
                }
                else {
                   [cell.authLab setText:@"未认证"];
                }

                
//                cell.authLab.text=@"一类";
//                while (_viewStar.subviews.lastObject) {
//                    [_viewStar.subviews.lastObject removeFromSuperview];
//                }
//                [_viewStar removeFromSuperview];
//                _viewStar = [[UIView alloc] initWithFrame:CGRectMake(126.0, 0, (ScreenWidth - 126.0), 44.0)];
//                [cell.contentView addSubview:_viewStar];
//                CGFloat imgX = 0;
//                for (int k = 0; k < _user.level; k ++) {
//                    imgX += k * 20.0;
//                    UIImageView *imageStar = [[UIImageView alloc] init];
//                    [imageStar setFrame:CGRectMake(imgX, 10, 20, 20)];
//                    [imageStar setImage:[UIImage imageWithFile:@"icon-doctor-step.png"]];
//                    imgX += 7.0;
//                    [_viewStar addSubview:imageStar];
//                }
            }
                break;
            case 3:
            {
                [cell.textDesc setText:[NSString stringWithFormat:@"%d分", _user.integral]];
            }
                break;
            case 4:
            {
                [cell.textDesc setText:_user.company];
            }
                break;
            case 5:
            {
                [cell.textDesc setText:_user.department];
            }
                break;
            default:
                break;
        }
        [cell setUserInteractionEnabled:NO];
        if (indexPath.row == 0) {
            [cell setUserInteractionEnabled:YES];
        }
        return cell;
    }
    else if (indexPath.section == 3) {
        CellPersonInfo *cell = [CellPersonInfo cellWithTableView:tableView Index:indexPath.row];
        [cell.textViewDesc setText:_user.memo];
        CGFloat descHeight = [NSString stringReturnSizeWithText:_user.memo Size:CGSizeMake((ScreenWidth - 36.0), 0) FontSize:14.0].height;
        CGRect descFrame = cell.textViewDesc.frame;
        descFrame.size.height = (descHeight + 20);
        [cell.textViewDesc setFrame:descFrame];
        [cell.btnExit addTarget:self action:@selector(clickInfoSubmit) forControlEvents:UIControlEventTouchUpInside];
        
        if(indexPath.row == 0){
            [cell setUserInteractionEnabled:NO];
        }
        
        if (indexPath.row == 1) {
            [cell setUserInteractionEnabled:YES];
        }
        return cell;
    }
//    else if (indexPath.section == 4) {
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identiTemp"];
//         UIButton *btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btnExit setFrame:CGRectMake(20.0, 15.0, (ScreenWidth - 50.0), 40.0)];
//        [btnExit setTitle:@"退出" forState:UIControlStateNormal];
//        [btnExit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btnExit.layer setCornerRadius:4.0f];
//        [btnExit.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
//        [btnExit setBackgroundColor:SystemGreenColor];
//        [btnExit addTarget:self action:@selector(clickExit) forControlEvents:UIControlEventTouchUpInside];
//        [cell.contentView addSubview:btnExit];
//        return cell;
//    }
    else {
        CellPersonInfoTemp *cell = [CellPersonInfoTemp cellWithTableView:tableView];
//        if (indexPath.section == 1) {
//            [cell.textDesc setUserInteractionEnabled:NO];
//            switch (indexPath.row) {
//                case 0:
//                {
//                    [cell.labTitle setText:@"姓名"];
//                    [cell.textDesc setText:_user.card_name];
//                }
//                    break;
//                case 1:
//                {
//                    [cell.labTitle setText:@"银行卡账号"];
//                    [cell.textDesc setText:_user.card_no];
//                }
//                    break;
//                case 2:
//                {
//                    [cell.labTitle setText:@"开户行"];
//                    [cell.textDesc setText:_user.card_account];
//                }
//                    break;
//                default:
//                    break;
//            }
//        }
        if (indexPath.section == 1) {
            [cell.textDesc setUserInteractionEnabled:NO];
            switch (indexPath.row) {
                case 0:
                {
                    [cell.labTitle setText:@"本周累计接单"];
                     cell.textDesc.textColor = SystemGrayColor;
                    [cell.textDesc setText:[NSString stringWithFormat:@"%zd次", _user.week_service_times]];
                    
                }
                    break;
                case 1:
                {
                    [cell.labTitle setText:@"本月累计接单"];
                    cell.textDesc.textColor = SystemGrayColor;
                    [cell.textDesc setText:[NSString stringWithFormat:@"%zd次", _user.month_service_times]];
                }
                    break;
                case 2:
                {
                    [cell.labTitle setText:@"累计接单"];
                     cell.textDesc.textColor = SystemGrayColor;
                    [cell.textDesc setText:[NSString stringWithFormat:@"%zd次", _user.service_times]];
                }
                    break;
                default:
                    break;
            }
        }
        return cell;
    }
}
#pragma mark 退出登录
- (void)clickExit
{
    MBShow
    [HTTPRequest httpWithPost:@"/cus/logout" Param:@{} Success:^(id obj) {
        if (SUCCESS) {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginVC *loginVC = [story instantiateViewControllerWithIdentifier:@"StoryIDLogin"];
            [HTTPRequest shareRequest].sessionID = nil;
            [self.navigationController pushViewController:loginVC animated:NO];
            
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setValue:@"" forKey:@"PersonIdPhoto"];
//            [defaults setValue:@"" forKey:@"PersonWorkPhoto"];
            [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
        }
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 ) {
        return 41.0;
    }
    return 0;
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44.0)];
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 0, 90.0, 44.0)];
    [labTitle setTextAlignment:NSTextAlignmentLeft];
    [labTitle setTextColor:[UIColor blackColor]];
    [labTitle setFont:[UIFont systemFontOfSize:15.0]];
    [viewHeader addSubview:labTitle];
    UIImageView *imageRight = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-50, 12, 20, 20)];
    [imageRight setImage:[UIImage imageWithFile:@"arrow.png"]];
    [viewHeader addSubview:imageRight];
//    
//    if (section == 1) {
//        [labTitle setText:@"绑定银行卡"];
//    }
     if (section == 1) {
        [labTitle setText:@"业绩统计"];
        UILabel *labCount = [[UILabel alloc] initWithFrame:CGRectMake(126, 12, 60, 20)];
        [labCount setText:[NSString stringWithFormat:@"%zd次", _user.service_times]];
        [labCount setFont:[UIFont systemFontOfSize:15.0]];
        [labCount setTextColor:[UIColor darkGrayColor]];
        [viewHeader addSubview:labCount];
        [imageRight setFrame:CGRectMake(ScreenWidth-50, 12, 15, 15)];
    }
    UIButton *btnHeader = [[UIButton alloc] initWithFrame:viewHeader.bounds];
    [viewHeader addSubview:btnHeader];
    [viewHeader bringSubviewToFront:btnHeader];
    [btnHeader setTag:section];
    [btnHeader addTarget:self action:@selector(clickHeader:) forControlEvents:UIControlEventTouchUpInside];
    return viewHeader;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"indexPath.section=%ld",(long)indexPath.section);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60.0;
    }
    else if (indexPath.section == 3 && indexPath.row == 0) {
        CGFloat descHeight = [NSString stringReturnSizeWithText:_user.memo Size:CGSizeMake((ScreenWidth - 36.0), 0) FontSize:14.0].height;
        return (descHeight + 60.0);
    }
    else if (indexPath.section == 3 && indexPath.row == 1) {
        return 70.0;
    }
    
    else if (indexPath.section == 4) {
        return 70.0;
    }
    return 41.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

- (void)clickHeader:(UIButton *)sender
{
    if (sender.tag == 1) {
        _isLaySender1 = !_isLaySender1;
    }
    else {
        _isLaySender2 = !_isLaySender2;
    }
    [self.tableView reloadData];
}

#pragma mark 退出登录
//- (void)clickExit
//{
//    MBShow
//    [HTTPRequest httpWithPost:@"/cus/logout" Param:@{} Success:^(id obj) {
//        if (SUCCESS) {
//            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            LoginVC *loginVC = [story instantiateViewControllerWithIdentifier:@"StoryIDLogin"];
//            [HTTPRequest shareRequest].sessionID = nil;
//            [self.navigationController pushViewController:loginVC animated:NO];
//            
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setValue:@"" forKey:@"PersonIdPhoto"];
//            [defaults setValue:@"" forKey:@"PersonWorkPhoto"];
//            [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
//        }
//        MBHide
//    } Fail:^(NSString *errorMsg) {
//        MBHide
//        MBE_Sys
//    }];
//}
- (void)clickInfoSubmit
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonalInfoSubmitVC *personSubmit = [story instantiateViewControllerWithIdentifier:@"StoryIDPersonSubmit"];
    [self.navigationController pushViewController:personSubmit animated:YES];
}

- (void)obtainPerson:(BOOL)isRefresh
{
    MBShow
    [HTTPRequest httpWithGet:@"/cus/detail" Param:@{} Success:^(id obj) {
        if (SUCCESS) {
            if ([obj valueForKey:@"data"]) {
//                NSLog(@"%@",obj);
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

- (void)clickEdit
{
    UIStoryboard *storyB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonalEditVC *personEdit = [storyB instantiateViewControllerWithIdentifier:@"StoryIDPersonalEdit"];
    personEdit.user = _user;
    if (!personEdit.PersonalEditSusBlock) {
        personEdit.PersonalEditSusBlock = ^(){
            [self obtainPerson:YES];
        };
    }
    
    //添加 字典，将label的值通过key值设置传递
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:_user.nickname,@"name",_user.company,@"comany",_user.department,@"department", nil];
    
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"edit" object:nil userInfo:dict];
    
    //通过通知中心发送通知
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController pushViewController:personEdit animated:YES];
    
}
@end
