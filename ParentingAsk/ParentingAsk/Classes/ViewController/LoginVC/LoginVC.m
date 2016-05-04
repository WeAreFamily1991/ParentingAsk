

#import "LoginVC.h"
#import "MainVC.h"
#import "UINavigationItem+ItemCustom.h"
#import "ChatViewController.h"
#import "CellLogin.h"
#import "MainTabBarViewController.h"
#import "ForgetVC.h"
#import "TMWebViewController.h"
#import "AuditViewController.h"
#import "IngAuthVC.h"
#import "BackVC.h"

#import "RegistViewController.h"
@interface LoginVC ()<UITextFieldDelegate>

@end

@implementation LoginVC
{
    NSString *_errorMess;
    NSString *_headerUrl;
    NSString *_codeStr;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
      self.navigationController.navigationBarHidden=NO;
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC hiddenTabbarView];
   
    //
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (UIView *)textViewWithImage:(NSString *)imageName
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *imageLeft = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 23)];
    [imageLeft setImage:[UIImage imageWithFile:imageName]];
    [view addSubview:imageLeft];
    
    return view;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CellLogin *cellHeaderUrl = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    HTTPImgView(cellHeaderUrl.imageIcon, _headerUrl)
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellLogin *cell = [CellLogin cellWithTableView:tableView IndexPath:indexPath];
    
    [cell.btnRemember addTarget:self action:@selector(clickRemember:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnLogin addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.textPassword setDelegate:self];
    [cell.textUsername setDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (indexPath.row == 2) {
    
     
            
            self.imageLeft = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/6, ScreenWidth/18, ScreenWidth/18, ScreenWidth/18)];
            
        
            self.imageLeft.image =[UIImage imageNamed:@"name-gray.png"];
            
            [cell.contentView addSubview:self.imageLeft];
            
       

        [cell.textUsername setText:[defaults objectForKey:@"PAUserName"]];
        _headerUrl = [defaults objectForKey:cell.textUsername.text];
    }
    else if (indexPath.row == 3) {
        self.imageLeft2 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/6, ScreenWidth/18, ScreenWidth/18, ScreenWidth/18)];
        
        
        self.imageLeft2.image =[UIImage imageNamed:@"lock-gray.png"];
        
        [cell.contentView addSubview:self.imageLeft2];

        [cell.textPassword setText:[defaults objectForKey:@"PAPassword"]];
    }
     else if (indexPath.row == 4)
      
     {
//         UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//         button.frame = CGRectMake(ScreenWidth-ScreenWidth/5, 0, ScreenWidth/6, ScreenWidth/12);
//         [button setTitleColor:SystemGreenColor forState:UIControlStateNormal];
//         [button setTitle:@"忘记密码" forState:UIControlStateNormal];
//         [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//         [cell.contentView addSubview:button];
     }
     else if (indexPath.row == 0)
       
     {
//         UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"head111.png"]];
//         img.frame = CGRectMake(ScreenWidth/2-ScreenWidth/8, ScreenHeight/10-ScreenWidth/8, ScreenWidth/4, ScreenWidth/4);
//         img.layer.cornerRadius = ScreenWidth/8;
//         [cell.contentView addSubview:img];Ï
     }
     else if (indexPath.row == 1)
     {
         UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"育儿问一问.png"]];
         img.frame = CGRectMake(ScreenWidth/2-ScreenWidth/5, ScreenHeight/16-ScreenWidth/28, ScreenWidth/2.5, ScreenWidth/14);
        
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
    switch (indexPath.row) {
        case 0:
            return ScreenHeight/5;
            
        case 1:
            return ScreenHeight/8;
        case 2:
            return ScreenHeight/10;
        case 3:
            return ScreenHeight/10;
        case 4:
            return ScreenHeight/12.3;
        case 5:
            return ScreenHeight/11;
        case 6:
            return ScreenHeight/11;

        default:
            break;
    }
    return .0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CellLogin *cellUsername = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    CellLogin *cellPassword = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    [cellUsername.textUsername resignFirstResponder];
    [cellPassword.textPassword resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CellLogin *cellUsername = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    _headerUrl = [[NSUserDefaults standardUserDefaults] objectForKey:cellUsername.textUsername.text];
    CellLogin *cellHeaderUrl = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    HTTPImgView(cellHeaderUrl.imageIcon, _headerUrl)
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CellLogin *cellUsername = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    CellLogin *cellImageIcon = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if ([textField isEqual:cellUsername.textUsername]) {
        [cellImageIcon.imageIcon setImage:[UIImage imageWithFile:@"app-icon.png"]];
        HTTPImgView(cellImageIcon.imageIcon, cellUsername.textUsername.text)
    }
    return [textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    CellLogin *cellUsername = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if ( textField==cellUsername.textUsername)
    {
       
        self.imageLeft.image = [UIImage imageWithFile:@"name-green.png"];
       
       
    }
   else
    {
        self.imageLeft2.image = [UIImage imageWithFile:@"lock-green.png"];    }
    
   

    return YES;
}
- (void)clickRemember:(UIButton *)sender
{
    CellLogin *cellRemeber = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    CellLogin *cellUsername = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    CellLogin *cellPassword = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    [cellUsername.textUsername resignFirstResponder];
    [cellPassword.textPassword resignFirstResponder];
    
    sender.selected = !sender.selected;
    if (!sender.selected) {
        [cellRemeber.imageRemeber setImage:[UIImage imageWithFile:@"btn-nopwd.png"]];
    }
    else {
        [cellRemeber.imageRemeber setImage:[UIImage imageWithFile:@"choice.png"]];
    }
}
//按钮跳转
- (void)clickLogin
{
    CellLogin *cellImageIcon = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    CellLogin *cellUsername = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    CellLogin *cellPassword = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    CellLogin *cellRemeber = (CellLogin *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    if (cellUsername.textUsername.text.length == 0 || cellPassword.textPassword.text.length == 0)
    
    {
        MBE(@"请输入有效用户名及密码")
    }
    else
    {
        [cellUsername.textUsername resignFirstResponder];
        [cellPassword.textPassword resignFirstResponder];
        
        MBShow
        [HTTPRequest httpWithPost:@"/cus/loginWithPhone" Param:@{@"phone": cellUsername.textUsername.text, @"password": cellPassword.textPassword.text} Success:^(id obj)
        {
            NSLog(@"登录obj = %@",obj);
            if (SUCCESS)
            {
                _errorMess = nil;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"" forKey:@"PAUserName"];
                [defaults setObject:@"" forKey:@"PAPassword"];
                if (cellRemeber.btnRemember.selected)
                {
                    [defaults setObject:cellUsername.textUsername.text forKey:@"PAUserName"];
                    [defaults setObject:cellPassword.textPassword.text forKey:@"PAPassword"];
                }
                
                //将相关区域代号，名称存入沙盒
                NSArray *arrayCities = @[@{@"title": @"市辖区", @"id": @"320501"}, @{@"title": @"虎丘区", @"id": @"320505"}, @{@"title": @"吴中区", @"id": @"320506"}, @{@"title": @"相城区", @"id": @"320507"}, @{@"title": @"姑苏区", @"id": @"320508"}, @{@"title": @"吴江区", @"id": @"320509"}, @{@"title": @"常熟市", @"id": @"320581"}, @{@"title": @"张家港市", @"id": @"320582"}, @{@"title": @"昆山市", @"id": @"320583"}, @{@"title": @"太仓市", @"id": @"320585"}];
                [defaults setObject:arrayCities forKey:@"PACities"];
                
                NSLog(@"登录界面token =%@",[[obj valueForKey:@"data"] valueForKey:@"token"]);
                [HTTPRequest shareRequest].sessionID = [[obj valueForKey:@"data"] valueForKey:@"token"];
                User *currentUser = [JsonToModel objectFromDic:[obj valueForKey:@"data"] className:@"User"];
                
                if (currentUser.type==0)
                {
                    
                    if (![_errorMess isEqual:@"error"])
                    {
                        
                        [HTTPRequest httpWithPost:@"/cus/cusDetail" Param:@{@"phone": cellUsername.textUsername.text} Success:^(id obj) {
                            
                            NSLog(@"得到obj =%@",obj);
                            
                            if ([[obj valueForKey:@"code"] isEqual:[NSNumber numberWithInt:1]])
                            {
                                NSString *str = [obj valueForKey:@"desc"];
                                
                                MBS(str)
                                return ;
                            }
                            else
                            {
                                NSLog(@"得到obj =%@",obj);
                                _codeStr = [[obj valueForKey:@"data"] valueForKey:@"validateStatus"];
                                MBHide
                                NSLog(@"_codeStr=%@",_codeStr);
                                if ([_codeStr isEqual:[NSNumber numberWithInt:0]])
                                {
                                    IngAuthVC *authVCING = [[IngAuthVC alloc]init];
                                    [self.navigationController pushViewController:authVCING animated:YES];
                                }
                                
                                else if ([_codeStr isEqual:[NSNumber numberWithInt:3]])
                                {
                                    AuditViewController *auditVC = [[AuditViewController alloc]init];
                                    [self.navigationController pushViewController:auditVC animated:YES];
                                }
                                
                                else if ([_codeStr isEqual:[NSNumber numberWithInt:2]])
                                {
                                    
                                    BackVC *back = [[BackVC alloc]init];
                                    NSString *dicStr =[[obj valueForKey:@"data"] valueForKey:@"reason"];
                                    [back setValue:dicStr forKey:@"reasonStr"];
                                    [self.navigationController pushViewController:back animated:YES];
                                }
                                
                                else if ([_codeStr isEqual:[NSNumber numberWithInt:1]])
                                {
                                    
                                    UIWindow *window = [UIApplication sharedApplication].keyWindow;//add by xiaoxiao
                                    window.rootViewController = [[MainTabBarViewController alloc] init];//add by xiaoxiao
                                    
                                    [defaults setValue:currentUser.headurl forKey:cellUsername.textUsername.text];
                                    HTTPImgView(cellImageIcon.imageIcon, currentUser.headurl)
                                    
                                    [HTTPRequest shareRequest].currentUser = currentUser;
                                    //登录环信
                                    [self loginEaseMob];
                                    
                                  }
                                
                            }
                            
                            
                        } Fail:^(NSString *errorMsg) {
                            MBHide
                            MBE(@"数据LOSE")
                            return ; 
                        }];
                        
                        
                    }
                    else if ([_errorMess isEqual:@"error"])
                    {
                        
                        UIWindow *window = [UIApplication sharedApplication].keyWindow;//add by xiaoxiao
                        window.rootViewController = [[MainTabBarViewController alloc] init];//add by xiaoxiao
                        
                        [defaults setValue:currentUser.headurl forKey:cellUsername.textUsername.text];
                        HTTPImgView(cellImageIcon.imageIcon, currentUser.headurl)
                        
                        [HTTPRequest shareRequest].currentUser = currentUser;
                        //登录环信
                        [self loginEaseMob];
                        
                        
                    }

                   
                }
                else
                {
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;//add by xiaoxiao
                    window.rootViewController = [[MainTabBarViewController alloc] init];//add by xiaoxiao
                    
                    [defaults setValue:currentUser.headurl forKey:cellUsername.textUsername.text];
                    HTTPImgView(cellImageIcon.imageIcon, currentUser.headurl)
                    
                    [HTTPRequest shareRequest].currentUser = currentUser;
                    //登录环信
                    [self loginEaseMob];

                }
                
            


            }
            else
            {
                MBHide
               
                MBE(@"用户名或密码错误")
                _errorMess = @"error";
                NSLog(@"_errorMess=%@",_errorMess);
                 return ;
            }
            
            NSLog(@"已来过");
        } Fail:^(NSString *errorMsg)
         {
             
            MBHide
            MBE_Sys
             _errorMess = @"error";
             return ;
        }];
       
         NSLog(@"已来过22");
    }
     NSLog(@"已来过33");
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)loginEaseMob
{
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[HTTPRequest shareRequest].currentUser.chatid password:[HTTPRequest shareRequest].currentUser.chatpd completion:^(NSDictionary *loginInfo, EMError *error) {
        NSLog(@"error=%@",error);
        if (!error) {
            [[EaseMob sharedInstance].chatManager setApnsNickname:[HTTPRequest shareRequest].currentUser.nickname];
            
            //获取数据库中数据
            [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
        }
        else {
//            MBE(@"开启会话失败")
           
        }
    } onQueue:nil];
}
- (IBAction)resiBtn:(id)sender
{
    RegistViewController *registVC = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
    
}

@end
