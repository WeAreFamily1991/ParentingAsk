

#import "UserInfoEditVC.h"
#import "CellPersonal.h"
#import "ChooseCityVC.h"


@interface UserInfoEditVC ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation UserInfoEditVC
{
    int _genderSelected;
    BOOL _isEdit;
    NSString *_cityCode;
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
    [self setTitle:@"完善资料"];
    
    [self.view setBackgroundColor:SystemGrayColor];
    UIView *viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15.0)];
    [viewTop setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.08f]];
    [self.tableView setTableHeaderView:viewTop];
    [self.tableView setScrollEnabled:YES];
    _genderSelected = 0;
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
    CellPersonal *cell = [CellPersonal cellWithTableView:tableView IndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell.btnAddress addTarget:self action:@selector(clickAddress) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnAddress setTitle:_user.locationName forState:UIControlStateNormal];
    [cell.btnMale addTarget:self action:@selector(clickGender:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnMale setUserInteractionEnabled:YES];
    [cell.btnFemale addTarget:self action:@selector(clickGender:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnFemale setUserInteractionEnabled:YES];
    [cell.btnSave addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *strAddressTemp = @"";
    NSArray *cities = [[NSUserDefaults standardUserDefaults] objectForKey:@"PACities"];
    if ([cities isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dic in cities) {
            if ([[NSString stringWithFormat:@"%ld", _user.location] isEqualToString:[NSString stringWithFormat:@"%@", [dic valueForKey:@"id"]]]) {
                strAddressTemp = [dic valueForKey:@"title"];
            }
        }
    }
    [cell.btnAddress setTitle:strAddressTemp forState:UIControlStateNormal];
    
    if (indexPath.row == 1) {
        //具体地址
        [cell.textDesc setText:_user.address];
    }
    else if (indexPath.row == 3) {
        [cell.textDesc setText:_user.nickname];
    }
    else if (indexPath.row == 4) {
        NSDate *dateBorn = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(_user.childbirth / 1000)];
        NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
        [dateForm setDateFormat:@"yyyy-MM-dd"];
        [cell.textDesc setText:[dateForm stringFromDate:dateBorn]];
    }
    else if (indexPath.row == 5) {
        [cell.textDesc setText:_user.phone];
    }
    
    [cell setUserInteractionEnabled:YES];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        return 65.0;
    }
    return 50.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .0001;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (void)clickGender:(UIButton *)sender
{
    //1. 男  2.女
    int genderTag = (int)sender.tag;
    CellPersonal *cellGender = (CellPersonal *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    _genderSelected = genderTag;
    if (genderTag == 1) {
        [cellGender.btnMale setSelected:YES];
        [cellGender.btnFemale setSelected:NO];
        
        [cellGender.imageMale setImage:[UIImage imageNamed:@"did"]];
        [cellGender.imageFemale setImage:[UIImage imageNamed:@"nodid"]];
    }
    else {
        [cellGender.btnFemale setSelected:YES];
        [cellGender.btnMale setSelected:NO];
        
        [cellGender.imageMale setImage:[UIImage imageNamed:@"nodid"]];
        [cellGender.imageFemale setImage:[UIImage imageNamed:@"did"]];
    }
}

- (void)clickAddress
{
    CellPersonal *cell = (CellPersonal *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ChooseCityVC *chooseCity = [[ChooseCityVC alloc] init];
    //zou
    chooseCity.isForDocList = NO;
    
    if (!chooseCity.ChooseCityBlock) {
        chooseCity.ChooseCityBlock = ^(NSString *strName, NSString *strCode) {
            [cell.btnAddress setTitle:strName forState:UIControlStateNormal];
            _cityCode = strCode;
        };
    }
    [self.navigationController pushViewController:chooseCity animated:YES];
}

- (void)clickSave
{
    CellPersonal *cellAddress = (CellPersonal *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    CellPersonal *cellName = (CellPersonal *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    CellPersonal *cellBorn = (CellPersonal *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    CellPersonal *cellPhone = (CellPersonal *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    
    NSString *strAddress = (cellAddress.textDesc.text)?(cellAddress.textDesc.text):@"";
    NSString *strChildName = (cellName.textDesc.text)?(cellName.textDesc.text):@"";
    NSString *strChildBorn = (cellBorn.textDesc.text)?(cellBorn.textDesc.text):@"";
    NSString *strPhone = (cellPhone.textDesc.text)?(cellPhone.textDesc.text):@"";
    
    //转换成毫秒数
    NSDateFormatter *dateFrom = [[NSDateFormatter alloc] init];
    [dateFrom setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateBorn = [dateFrom dateFromString:strChildBorn];
    long long dBorn = [dateBorn timeIntervalSince1970];
    dBorn *= 1000;
    
    NSString *strId = [NSString stringWithFormat:@"%@", _orderId];
    if (_cityCode.length == 0) {
        _cityCode = [NSString stringWithFormat:@"%ld", [HTTPRequest shareRequest].currentUser.location];
    }
    NSDictionary *dic = @{@"id": strId, @"location": _cityCode, @"address": strAddress, @"childname": strChildName, @"childsex": [NSNumber numberWithInt:_genderSelected], @"childbirth": [NSNumber numberWithLongLong:dBorn], @"phone": strPhone};
    
    [HTTPRequest httpWithPost:@"/order/consulter" Param:dic Success:^(id obj) {
        if (SUCCESS) {
            if (self.UserInfoEditBlock) {
                self.UserInfoEditBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } Fail:^(NSString *errorMsg) {
        MBE(@"保存失败")
    }];
}

@end
