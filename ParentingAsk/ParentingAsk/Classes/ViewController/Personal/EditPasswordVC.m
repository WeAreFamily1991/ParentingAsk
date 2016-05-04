
#import "EditPasswordVC.h"
#import "CellEditPassword.h"
#import "LoginVC.h"
@interface EditPasswordVC ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *btnSave;

@end

@implementation EditPasswordVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   self.tableView.separatorStyle = NO;
    [self setTitle:@"修改密码"];
    [self.view setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.00]];
    [self.btnSave.layer setCornerRadius:3.0f];
    [self.btnSave setBackgroundColor:SystemGreenColor];
    [self.btnSave addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellEditPassword *cell = [CellEditPassword cellWithTableView:tableView IndexPath:indexPath];
    [cell.textDesc setDelegate:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 0)
        
    {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mima-green.png"]];
        img.frame = CGRectMake(ScreenWidth/6.8, ScreenWidth/20, ScreenHeight/25, ScreenHeight/25);
       
        [cell.contentView addSubview:img];
    }
    else if (indexPath.row == 1)
    {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mima-green.png"]];
        img.frame = CGRectMake(ScreenWidth/6.8, ScreenWidth/20, ScreenHeight/25, ScreenHeight/25);
        
        [cell.contentView addSubview:img];
    }
    else if (indexPath.row == 2)
    {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mima-green.png"]];
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
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}
#pragma mark 设置区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    else return ScreenHeight/8;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (void)clickSave
{
    CellEditPassword *cellO = (CellEditPassword *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CellEditPassword *cellN = (CellEditPassword *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    CellEditPassword *cellNA = (CellEditPassword *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    if (cellO.textDesc.text.length == 0 || cellN.textDesc.text.length == 0 || cellNA.textDesc.text.length == 0) {
        return;
    }
    else if (![cellN.textDesc.text isEqualToString:cellNA.textDesc.text]) {
        MBE(@"两次输入密码不一致")
    }
    else if (cellN.textDesc.text.length<6||cellNA.textDesc.text.length<6)
    {
        MBE(@"密码需超过六位")
    }
    else {
        MBShow
        [HTTPRequest httpWithPost:@"/cus/changepd" Param:@{@"old": cellO.textDesc.text, @"new": cellNA.textDesc.text} Success:^(id obj) {
            MBHide
            
            NSLog(@"obj.code =%@",obj);
            if ([obj valueForKey:@"code"]==[NSNumber numberWithLong:0])
            {
                MBS([obj valueForKey:@"desc"])
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginVC *loginVC = [story instantiateViewControllerWithIdentifier:@"StoryIDLogin"];
                [HTTPRequest shareRequest].sessionID = nil;
                [self.navigationController pushViewController:loginVC animated:NO];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:@"" forKey:@"PersonIdPhoto"];
                [defaults setValue:@"" forKey:@"PersonWorkPhoto"];
                [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
                

            }
            else
            {
                  MBS([obj valueForKey:@"desc"])
            }
            
            
            
        } Fail:^(NSString *errorMsg) {
            MBHide
            MBE_Sys
        }];
    }
}

-(void)timerFireMethod_Change:(NSTimer*)theTimer
{
    
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
