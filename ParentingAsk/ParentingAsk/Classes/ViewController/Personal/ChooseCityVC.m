

#import "ChooseCityVC.h"
#import "DoctorListVC.h"

@interface ChooseCityVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ChooseCityVC
{
    UITableView *_tableLeft;
    UITableView *_tableRight;
    UITableView *_tableCenter;
    
    NSString *_strCode;
    NSString *_strProvince;
    NSString *_strCity;
    NSString *_strArea;
    
    NSMutableArray *_mutProvince;
    NSMutableArray *_mutCity;
    NSMutableArray *_mutArea;
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
   
//    self.view.alpha = 0.5;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"选择城市"];
    
    _tableLeft = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth*0.3, ScreenHeight*0.618)];
    _tableLeft.alpha = 0.5;
    _tableLeft.backgroundColor = [UIColor whiteColor];
    [_tableLeft setDelegate:self];
    [_tableLeft setDataSource:self];
    [self.view addSubview:_tableLeft];
    
    //如果涉及到从省份中选择城市，将注释打开即可（注意参数配置）
    
    _tableCenter = [[UITableView alloc] initWithFrame:CGRectMake((ScreenWidth * 0.32), 64, (ScreenWidth * 0.3), ScreenHeight*0.618)];
    _tableCenter.alpha = 0.5;
    _tableCenter.backgroundColor = [UIColor whiteColor];
    [_tableCenter setDelegate:self];
    [_tableCenter setDataSource:self];
    [self.view addSubview:_tableCenter];
    
    _tableRight = [[UITableView alloc] initWithFrame:CGRectMake((ScreenWidth * 0.64), 64, (ScreenWidth * 0.3), ScreenHeight*0.618)];
    _tableRight.alpha = 0.5;
    _tableRight.backgroundColor = [UIColor whiteColor];
    [_tableRight setDelegate:self];
    [_tableRight setDataSource:self];
    [self.view addSubview:_tableRight];
    
    _strProvince = @"江苏省";
    _strCity = @"苏州市";
    _strArea = @"工业园区";
    _strCode = @"320510";
    
    _mutProvince = [NSMutableArray array];
    _mutCity = [NSMutableArray array];
    _mutArea = [NSMutableArray array];
    [self obtainProvince:@"320000"];
    [self obtainCity:@"320000"];
    [self obtainArea:@"320510"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableLeft) {
        return _mutProvince.count;
    }else if(tableView == _tableCenter){
        return _mutCity.count;
    }else{
        return _mutArea.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strIdenti = @"identiChooseCity";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdenti];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdenti];
    }
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    
    if (tableView == _tableLeft) {
       
        [cell.textLabel setFont:[UIFont systemFontOfSize:15.0]];
        NSDictionary *dicPro = _mutProvince[indexPath.row];
//        NSLog(@"名字=%@",[dicPro valueForKey:@"name"]);
//        if ([[dicPro valueForKey:@"name"] isEqual:@"江苏省"])
//        {
            [cell.textLabel setText:[dicPro valueForKey:@"name"]];
//        }
        
    }else if(tableView == _tableCenter){
        [cell.textLabel setFont:[UIFont systemFontOfSize:14.0]];
        NSDictionary *dicCity = _mutCity[indexPath.row];
        [cell.textLabel setText:[dicCity valueForKey:@"name"]];
    }else {
        [cell.textLabel setFont:[UIFont systemFontOfSize:14.0]];
        NSDictionary *dicArea = _mutArea[indexPath.row];
        [cell.textLabel setText:[dicArea valueForKey:@"name"]];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _tableLeft) {
        NSDictionary *dic = _mutProvince[indexPath.row];
        _strProvince = [NSString stringWithFormat:@"%@", [dic valueForKey:@"name"]];
        _strCode = [NSString stringWithFormat:@"%@", [dic valueForKey:@"code"]];
        [self obtainCity:_strCode];
    }
    else if(tableView == _tableCenter){
        NSDictionary *dicCity = _mutCity[indexPath.row];
        _strCity = [NSString stringWithFormat:@"%@", [dicCity valueForKey:@"name"]];
        _strCode = [NSString stringWithFormat:@"%@", [dicCity valueForKey:@"code"]];
        //zou
        if (!self.isForDocList) {
            [self obtainArea:_strCode];
        }else
        {
            DoctorListVC *doctor = [[DoctorListVC alloc] init];
            [doctor setOrder_id:self.order_id];
            doctor.city_code = _strCode;
            [self.navigationController pushViewController:doctor animated:YES];
        }
        
    }else{
        NSDictionary *dicArea = _mutArea[indexPath.row];
        _strArea = [NSString stringWithFormat:@"%@", [dicArea valueForKey:@"name"]];
        _strCode = [NSString stringWithFormat:@"%@", [dicArea valueForKey:@"code"]];
        if (self.ChooseCityBlock) {
            self.ChooseCityBlock([NSString stringWithFormat:@"%@ %@ %@", _strProvince,_strCity,_strArea], _strCode);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableLeft]) {
        return 40.0;
    }
    return 35.0;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

- (void)obtainProvince:(NSString *)china
{
    MBShow
    [HTTPRequest httpWithPost:@"/location/province"/*@"/location/children"*/ Param:@{@"code": china} Success:^(id obj) {
        if (SUCCESS) {
            [_mutProvince removeAllObjects];
            if ([[obj valueForKey:@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in [obj valueForKey:@"data"]) {
                    [_mutProvince addObject:dic];
                }
            }
            [_tableLeft reloadData];
            NSDictionary *dicCity = _mutProvince[9];
            _strCity = [NSString stringWithFormat:@"%@", [dicCity valueForKey:@"name"]];
            _strCode = [NSString stringWithFormat:@"%@", [dicCity valueForKey:@"code"]];
            
            if (!self.isForDocList) {
                NSIndexPath *firstPath = [NSIndexPath indexPathForRow:9 inSection:0];
                [_tableLeft selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
                [self obtainArea:[[_strCode substringWithRange:NSMakeRange(0, 3)] stringByAppendingString:@"100"]];
            }

        }
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}

- (void)obtainCity:(NSString *)province
{
//    if (_strCode.length == 0) {
//        _strCode = [NSString stringWithFormat:@"%@", [HTTPRequest shareRequest].currentUser.location];
//    }
    MBShow
    [HTTPRequest httpWithPost:@"/location/children" Param:@{@"code": province} Success:^(id obj) {
        if (SUCCESS) {
            [_mutCity removeAllObjects];
            if ([[obj valueForKey:@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in [obj valueForKey:@"data"]) {
                    [_mutCity addObject:dic];
                }
            }
            [_tableCenter reloadData];
            
            // zou
            
            NSDictionary *dicCity = _mutCity[0];
            _strCity = [NSString stringWithFormat:@"%@", [dicCity valueForKey:@"name"]];
            _strCode = [NSString stringWithFormat:@"%@", [dicCity valueForKey:@"code"]];
            
            if (!self.isForDocList) {
                NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [_tableCenter selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
                [self obtainArea:[[_strCode substringWithRange:NSMakeRange(0, 3)] stringByAppendingString:@"100"]];
            }
        }
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}

- (void)obtainArea:(NSString *)city
{
    MBShow
    [HTTPRequest httpWithPost:@"/location/children" Param:@{@"code": city} Success:^(id obj) {
        if (SUCCESS) {
            [_mutArea removeAllObjects];
            if ([[obj valueForKey:@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in [obj valueForKey:@"data"]) {
                    [_mutArea addObject:dic];
                }
            }
            [_tableRight reloadData];
        }
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}
@end
