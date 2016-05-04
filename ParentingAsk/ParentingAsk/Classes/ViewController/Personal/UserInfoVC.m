

#import "UserInfoVC.h"
#import "CellUserInfo.h"
#import "User.h"
#import "UINavigationItem+ItemCustom.h"
#import "UserInfoEditVC.h"

@interface UserInfoVC ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation UserInfoVC
{
    BOOL _isEdit;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"用户资料"];
    
    [self.view setBackgroundColor:SystemGrayColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.tableView setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5f]];
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(backClick)];
//    [self.navigationItem navigationRightWithTitle:@"编辑" Img:nil Delegate:self Action:@selector(clickEdit) IsHeader:NO];
    
    UIButton* rightBun = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBun.frame = CGRectMake(0, 0, ScreenWidth/20
                                , ScreenWidth/20);
    [rightBun setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBun addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* right = [[UIBarButtonItem alloc] initWithCustomView:rightBun];
    self.navigationItem.rightBarButtonItem = right;
    [self.tableView setScrollEnabled:NO];
    
    _isEdit = NO;
    if (!_user) {
        [self obtainUserInfo];
    }
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
    CellUserInfo *cell = [CellUserInfo cellWithTableView:tableView IndexPath:indexPath];
    HTTPImgView(cell.imageAvatar, _user.headurl)
    
    NSString *strAddressTemp = @"";
    NSArray *cities = [[NSUserDefaults standardUserDefaults] objectForKey:@"PACities"];
    if ([cities isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dic in cities) {
            if ([[NSString stringWithFormat:@"%ld", _user.location] isEqualToString:[NSString stringWithFormat:@"%@", [dic valueForKey:@"id"]]]) {
                strAddressTemp = [dic valueForKey:@"title"];
            }
        }
    }
    [cell.labName setText:_user.nickname];
    [cell.textArea setText:[NSString stringWithFormat:@"%@ %@", strAddressTemp, _user.address]];
    [cell.textArea setDelegate:self];
    [cell.textGender setDelegate:self];
    [cell.textName setText:_user.childname];
    [cell.textName setDelegate:self];

    
    NSDate *dateBorn = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(_user.childbirth / 1000)];
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    [dateForm setDateFormat:@"yyyy-MM-dd"];
    [cell.textBorn setText:[dateForm stringFromDate:dateBorn]];
    [cell.textBorn setDelegate:self];
    [cell.textPhone setText:_user.phone];
    [cell.textPhone setDelegate:self];
    NSDate *dateAskin = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(_user.lastAskTime / 1000)];
    [cell.textTime setText:[dateForm stringFromDate:dateAskin]];
    [cell.textTime setDelegate:self];
    
    if (_user.childsex == 1) {
        [cell.textGender setText:@"男孩"];
    }
    else if (_user.childsex == 2) {
        [cell.textGender setText:@"女孩"];
    }
    else {
        [cell.textGender setText:@"未知"];
    }
    
    [cell setUserInteractionEnabled:NO];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60.0;
    }
    return 40.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string) {
        _isEdit = YES;
    }
    return YES;
}

- (void)obtainUserInfo
{
    MBShow
    [HTTPRequest httpWithGet:@"/order/consulter" Param:@{@"id": _orderId} Success:^(id obj) {
        if (SUCCESS) {
            _user = [JsonToModel objectFromDic:[obj valueForKey:@"data"] className:@"User"];
            [self.tableView reloadData];
            if (self.UserInfoVCBlock) {
                self.UserInfoVCBlock();
            }
        }
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}

#pragma mark 编辑
- (void)clickEdit
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserInfoEditVC *userEdit = [story instantiateViewControllerWithIdentifier:@"StoryIDUserInfoEdit"];
    userEdit.orderId = _orderId;
    userEdit.user = _user;
    if (!userEdit.UserInfoEditBlock) {
        userEdit.UserInfoEditBlock = ^(){
            [self obtainUserInfo];
        };
    }
    
   
     [self.navigationController pushViewController:userEdit animated:YES];
}

@end
