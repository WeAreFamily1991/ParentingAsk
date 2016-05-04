

#import "DoctorListVC.h"
#import "User.h"
#import "MainVC.h"
#import "CellDoctorList.h"

@interface DoctorListVC ()<UISearchBarDelegate, UIActionSheetDelegate>

@end

@implementation DoctorListVC
{
    NSMutableArray *_mutAllData;
    NSMutableArray *_mutSearch;
    NSMutableArray *_mutSearchKeyword;
    
    UISearchBar *_searchKeyWord;
    UIButton *_btnCity;
    UIView *_viewCity;
    
    NSMutableArray *_arrayLayout;
    BOOL _isSearch;
    BOOL _isSearchKeyWord;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_btnCity removeFromSuperview];
    [_searchKeyWord removeFromSuperview];
    [_viewCity removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mutAllData = [NSMutableArray array];
    _mutSearch = [NSMutableArray array];
    _mutSearchKeyword = [NSMutableArray array];
    [self obtainList];
    
    _viewCity = [[UIView alloc] init];
    [_viewCity setBackgroundColor:[UIColor whiteColor]];
    _searchKeyWord = [[UISearchBar alloc] init];
    
    if (iPhone6) {
        [_viewCity setFrame:CGRectMake(60, 7, 120, 30)];
        [_searchKeyWord setFrame:CGRectMake(190, 6, 170, 32)];
    }
    else if (iPhone6P) {
        [_viewCity setFrame:CGRectMake(60, 7, 150, 30)];
        [_searchKeyWord setFrame:CGRectMake(190, 26, 180, 32)];
    }
    else {
        [_viewCity setFrame:CGRectMake(60, 7, 100, 30)];
        [_searchKeyWord setFrame:CGRectMake(170, 6, 130, 32)];
    }
    [_viewCity.layer setCornerRadius:5.0];
    UIImageView *imageCity = [[UIImageView alloc] initWithFrame:CGRectMake((_viewCity.bounds.size.width - 30), 9, 20, 12)];
    [imageCity setImage:[UIImage imageWithFile:@"arrow-down.png"]];
    [_viewCity addSubview:imageCity];
    _btnCity = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnCity setFrame:CGRectMake(10, 0, _viewCity.bounds.size.width - 10, 30)];
    [_btnCity setTitle:@"全部" forState:UIControlStateNormal];
    [_btnCity setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_btnCity setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_btnCity setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_btnCity addTarget:self action:@selector(clickChooseCity) forControlEvents:UIControlEventTouchUpInside];
    [_btnCity.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_viewCity addSubview:_btnCity];
    [self.navigationController.navigationBar addSubview:_viewCity];
    
    [_searchKeyWord setPlaceholder:@"请输入关键字"];
    [_searchKeyWord setDelegate:self];
    [self.navigationController.navigationBar addSubview:_searchKeyWord];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isSearch) {
        return _mutSearch.count;
    }
    else if (_isSearchKeyWord) {
        return 1;
    }
    return _mutAllData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearch) {
        return [[_mutSearch[0] valueForKey:@"data"] count];
    }
    else if (_isSearchKeyWord) {
        return _mutSearchKeyword.count;
    }
    NSString *indexLayout = _arrayLayout[section];
    if ([indexLayout isEqualToString:@"0"]) {
        return 0;
    }
    else {
        return [[_mutAllData[section] valueForKey:@"data"] count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user;
    if (_isSearch) {
        user = [_mutSearch[0] valueForKey:@"data"][indexPath.row];
    }
    else if (_isSearchKeyWord) {
        user = _mutSearchKeyword[indexPath.row];
    }
    else {
        user = [[[_mutAllData objectAtIndex:indexPath.section] valueForKey:@"data"] objectAtIndex:indexPath.row];
    }
    
    CellDoctorList *cell = [CellDoctorList cellWithTableView:tableView];
    [cell.labtTitle setText:user.viewName];
    [cell.imageCheck setHidden:YES];
    if (user.isOnline == 1) {
        //在线
        [cell.labStatus setText:@"在线"];
        [cell.labStatus setTextColor:SystemGreenColor];
    }
    else {
        [cell.labStatus setText:@"离线"];
        [cell.labStatus setTextColor:[UIColor darkGrayColor]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    User *user;
    if (_isSearch) {
        user = [_mutSearch[0] valueForKey:@"data"][indexPath.row];
    }
    else if (_isSearchKeyWord) {
        user = _mutSearchKeyword[indexPath.row];
    }
    else {
        user = [_mutAllData[indexPath.section] valueForKey:@"data"][indexPath.row];
    }
    [self transferDoctor:user.User_id];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isSearchKeyWord) {
        return .0f;
    }
    return 50.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50.0)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    NSDictionary *dic = _mutAllData[section];
    if (_isSearch) {
        dic = _mutSearch[section];
    }
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 50)];
    [labTitle setText:[NSString stringWithFormat:@"%@（%ld）", [dic valueForKey:@"title"], [[dic valueForKey:@"data"] count]]];
    [view addSubview:labTitle];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [imageV setFrame:CGRectMake((ScreenWidth - 30), 15, 12, 20)];
    [imageV setImage:[UIImage imageWithFile:@"icon-guide.png"]];
    [view addSubview:imageV];
    
    UIButton *btnHeader = [[UIButton alloc] initWithFrame:view.frame];
    [btnHeader setTag:section];
    [btnHeader addTarget:self action:@selector(clickHeader:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnHeader];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchKeyWord resignFirstResponder];
}

- (void)obtainList
{
    MBShow
    
    //zou
    int cityCodeInt = [self.city_code intValue];
    
    [HTTPRequest httpWithPost:@"/cus/list1" Param:@{@"location": [NSNumber numberWithInt:cityCodeInt]} Success:^(id obj) {
        if (SUCCESS) {
            [_mutAllData removeAllObjects];
            for (NSDictionary *dicTemp in [obj valueForKey:@"data"]) {
                NSMutableArray *mutUsers = [NSMutableArray array];
                for (NSDictionary *dicUser in [dicTemp valueForKey:@"customers"]) {
                    User *user = [JsonToModel objectFromDic:dicUser className:@"User"];
                    if ([HTTPRequest shareRequest].currentUser.User_id != user.User_id) {
                        [mutUsers addObject:user];
                    }
                }
                if ([dicTemp valueForKey:@"location"]) {
                    NSDictionary *dicF = @{@"title": [[dicTemp valueForKey:@"location"] valueForKey:@"name"], @"data": mutUsers};
                    [_mutAllData addObject:dicF];
                }
            }
            
            _arrayLayout = [NSMutableArray array];
            for (NSDictionary *dic in _mutAllData) {
                [_arrayLayout addObject:@"0"];
            }
            [self.tableView reloadData];
            
            //筛选操作在这里暂时不需要，如果后期需要，打开即可
//            [self groupCityList:mutArrayTemp];
        }
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}
- (void)groupCityList:(NSArray *)citys
{
    NSMutableArray *mutTemp = [NSMutableArray array];
    if (citys) {
        for (User *userT in citys) {
            BOOL _isExit = NO;
            for (NSDictionary *dicT in mutTemp) {
                if ([userT.locationName isEqualToString:[dicT valueForKey:@"title"]]) {
                    NSMutableArray *mutAdd = [NSMutableArray arrayWithArray:[dicT valueForKey:@"data"]];
                    [mutAdd addObject:userT];
                    _isExit = YES;
                    
                    [_mutAllData removeObject:dicT];
                    NSDictionary *dic = @{@"title": userT.locationName, @"data": mutAdd};
                    [_mutAllData addObject:dic];
                    
                    break;
                }
            }
            if (!_isExit) {
                NSDictionary *dic = @{@"title": userT.locationName, @"data": @[userT]};
                [_mutAllData addObject:dic];
            }
            mutTemp = [NSMutableArray arrayWithArray:_mutAllData];
        }
    }
    _arrayLayout = [NSMutableArray array];
    for (NSDictionary *dic in _mutAllData) {
        [_arrayLayout addObject:@"0"];
    }
    [self.tableView reloadData];
}

- (void)clickHeader:(UIButton *)sender
{
    NSString *strIndex = _arrayLayout[sender.tag];
    if ([strIndex isEqualToString:@"0"]) {
        strIndex = @"1";
    }
    else {
        strIndex = @"0";
    }
    [_arrayLayout replaceObjectAtIndex:sender.tag withObject:strIndex];
    [self.tableView reloadData];
}

- (void)transferDoctor:(long)docId
{
    MBShow
    [HTTPRequest httpWithPost:@"/order/forward" Param:@{@"id": _order_id, @"customer_id": [NSNumber numberWithLong:docId]} Success:^(id obj) {
        MBHide
        if (SUCCESS) {
            [self.navigationController pushViewController:[[MainVC alloc] init] animated:NO];
        }
        else {
            MESSAGE
        }
    } Fail:^(NSString *errorMsg) {
        MBE_Sys
        MBHide
    }];
}

- (void)clickChooseCity
{
    _isSearchKeyWord = NO;
    [_searchKeyWord resignFirstResponder];
    [_searchKeyWord setText:@""];
    
    if (!_mutAllData || _mutAllData.count == 0) {
        return;
    }
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    for (NSDictionary *dic in _mutAllData) {
        if (dic) {
            [action addButtonWithTitle:[dic valueForKey:@"title"]];
        }
    }
    [action showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex > 0) {
        _isSearch = YES;
        NSDictionary *dic = _mutAllData[buttonIndex - 1];
        [_mutSearch removeAllObjects];
        [_mutSearch addObject:dic];
        [_btnCity setTitle:[dic valueForKey:@"title"] forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [_btnCity setTitle:@"全部" forState:UIControlStateNormal];
    _isSearch = NO;
    _isSearchKeyWord = YES;
    
    [_mutSearchKeyword removeAllObjects];
    for (NSDictionary *dic in _mutAllData) {
        for (User *user in [dic valueForKey:@"data"]) {
            if ([user.viewName rangeOfString:searchBar.text].location != NSNotFound) {
                [_mutSearchKeyword addObject:user];
            }
        }
    }
    if (searchBar.text.length == 0 && searchText.length == 0) {
        [_mutSearchKeyword removeAllObjects];
        for (NSDictionary *dic in _mutAllData) {
            for (User *user in [dic valueForKey:@"data"]) {
                [_mutSearchKeyword addObject:user];
            }
        }
    }
    
    [self.tableView reloadData];
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

@end
