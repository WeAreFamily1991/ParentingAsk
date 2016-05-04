//
//  联系人页面

#import "MessageVC.h"
#import "CellConnects.h"
#import "ChatViewController.h"
#import "Msg_Waiting.h"
#import "UserInfoVC.h"
#import "MainTabBarViewController.h"
#import "AppDelegate.h"

@interface MessageVC ()<UISearchBarDelegate>

@end

@implementation MessageVC
{
    NSMutableArray *_mutPersons;
    NSMutableArray *_mutSearch;
    NSMutableArray *_unreadCount;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//     [self unreadMess];
   
    //travel
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC appearTabbarView];
    [self refreshUnreadCount];
    //
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //travel
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC hiddenTabbarView];
    //
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-114);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.title = @"联系人";
    [self refreshUnreadCount];
    _mutPersons = [NSMutableArray array];
    _mutSearch = [NSMutableArray array];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40.0)];
    [_searchBar setDelegate:self];
    _searchBar.barTintColor =[UIColor whiteColor];
//    _searchBar.backgroundColor =
    _searchBar.searchBarStyle =UISearchBarStyleMinimal;
    _searchBar.barStyle =UIBarStyleDefault;
//     _searchBar.backgroundColor = [UIColor clearColor];
    [_searchBar setPlaceholder:@"搜索"];
    
    [ _searchBar setBarTintColor :[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00]];
    
//    [ _searchBar setBackgroundColor :[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00]];
//    UIView *segment = [_searchBar.subviews objectAtIndex:0];
//    segment.backgroundColor = [UIColor redColor];
    [self.tableView setTableHeaderView:_searchBar];
   
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    
    //zou
//    self.hidesBottomBarWhenPushed= YES;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    if (_isShowBack) {
//        self.title = @"联系人";
//        
//        UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 12, 20, 20)];
//        [btnBack setImage:[UIImage imageWithFile:@"返回"] forState:UIControlStateNormal];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
//    }//add by xiaoxiao
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obtainPersons) name:@"SlideSwitchRight" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obtainPersons) name:kRequestContactsNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUnreadCount) name:kNewMessageNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unreadCount_mess) name:kNewMessageNotification object:nil];
//    [self unreadMess];
    }
-(void)unreadCount_mess
{
    [AppDelegate shareAppDelegate].tabVC.GraBadgeView.value = [AppDelegate shareAppDelegate].tabVC.GraBadgeView.value +1;
}
//-(void)unreadMess
//{
//    [self requestMessagesDone:^(id obj)
//     {
//         NSMutableArray *arrayData = [obj valueForKey:@"data"];
//         _unreadCount = arrayData;
//     } withMessageType:_connectsType];
//    [AppDelegate shareAppDelegate].tabVC.GraBadgeView.value = _unreadCount.count;
//NSLog(@"联系人界面 _unreadCount = %ld", _unreadCount.count);
//}
-(void)refreshUnreadCount{
//    [self unreadMess];
     NSLog(@"[[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey]=%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey]);
    if (![AppDelegate shareAppDelegate].unreadDict) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey]) {
            [AppDelegate shareAppDelegate].unreadDict=[[[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey] mutableCopy];
        }else{
            [AppDelegate shareAppDelegate].unreadDict=[NSMutableDictionary dictionary];
        }
    }
    NSInteger msgCount=0;
    for (NSString *key in [AppDelegate shareAppDelegate].unreadDict.allKeys) {
        if ([AppDelegate shareAppDelegate].contactNames) {
            if ([[AppDelegate shareAppDelegate].contactNames containsObject:key]) {
                msgCount+=[[AppDelegate shareAppDelegate].unreadDict[key] integerValue];
            }else{
                [[AppDelegate shareAppDelegate].unreadDict removeObjectForKey:key];
            }
        }
    }
    NSLog(@"%@",[AppDelegate shareAppDelegate].unreadDict);
    [AppDelegate shareAppDelegate].tabVC.contactBadgeView.value=msgCount;
    
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mutSearch.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellConnects *cell = [CellConnects cellWithTableView:tableView];
    cell.badgeViewOnImg.hidden=YES;
    cell.badgeView.hidden=YES;
    [cell.labCount setHidden:YES];
    [cell.imageRight setHidden:YES];
    [cell.imageIcon.layer setCornerRadius:22.0];
    
    Msg_Waiting *msg = _mutSearch[indexPath.row];
//      if (![msg.evaluation isEqual:[NSNull null]])
//    {
        [cell.labAssess setText:msg.evaluation];
//    }
//    
//   
//         [cell.labAssess setText:@"暂无评价，请邀请"];
//    
    
    [cell.labTitle setText:msg.nickname];
    NSLog(@"cell.labTitle==%@",cell.labTitle);
    if ([AppDelegate shareAppDelegate].unreadDict && [AppDelegate shareAppDelegate].unreadDict[msg.nickname]) {
        cell.badgeViewOnImg.hidden=NO;
        cell.badgeViewOnImg.value=[[AppDelegate shareAppDelegate].unreadDict[msg.nickname] integerValue];
         NSLog(@"cell.badgeViewOnImg.value=%lu",(unsigned long)cell.badgeViewOnImg.value);
        cell.badgeViewOnImg.shadow=NO;
        cell.badgeViewOnImg.shine=NO;
    }
    HTTPImgView(cell.imageIcon, msg.headurl)
    [cell.imageIcon setTag:(indexPath.row + 1)];
    [cell.imageIcon setUserInteractionEnabled:YES];
    [cell.imageIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageIcon:)]];
    cell.consTitleWidth.constant = (ScreenWidth - 93.0);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Msg_Waiting *msg = _mutPersons[indexPath.row];
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:[NSString stringWithFormat:@"%@", msg.Msg_Waiting_id] conversationType:eConversationTypeChat];
    chatVC.strTopTitle = msg.chatlabel;
    chatVC.strDesc = msg.desc;
    //zou
//    chatVC.hidesBottomBarWhenPushed=YES;
    if (!chatVC.ChatVCBackBlock) {
        chatVC.ChatVCBackBlock = ^(){
            [self obtainPersons];
        };
    }
    NSLog(@"_DATA.NAICK联系人==%@",msg.nickname);
   
     NSLog(@"[[AppDelegate shareAppDelegate].unreadDict=%@",[AppDelegate shareAppDelegate].unreadDict);
    if ([AppDelegate shareAppDelegate].unreadDict && [AppDelegate shareAppDelegate].unreadDict[msg.nickname]) {
        [[AppDelegate shareAppDelegate].unreadDict removeObjectForKey:msg.nickname];
        [self saveUnreadMessageToSandBox];
        [self refreshUnreadCount];
    }
    [self.navigationCurrent pushViewController:chatVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSMutableArray *mutTemp = [NSMutableArray array];
    for (Msg_Waiting *msg in _mutPersons) {
        if ([[msg.nickname uppercaseString] rangeOfString:[searchText uppercaseString]].location != NSNotFound) {
            [mutTemp addObject:msg];
        }
    }
    _mutSearch = [NSMutableArray arrayWithArray:mutTemp];
    
    if (searchBar.text.length == 0 && searchText.length == 0) {
        [_mutSearch removeAllObjects];
        [_mutSearch addObjectsFromArray:_mutPersons];
    }
    
    [self.tableView reloadData];
}

- (void)clickImageIcon:(UIGestureRecognizer *)gesture
{
    Msg_Waiting *msg = _mutSearch[gesture.view.tag - 1];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserInfoVC *userInfo = [story instantiateViewControllerWithIdentifier:@"StoryIDUserInfo"];
    NSString *strOrderId = [NSString stringWithFormat:@"%@", msg.Msg_Waiting_id];
    [userInfo setOrderId:strOrderId];
    [self.navigationCurrent pushViewController:userInfo animated:YES];
}
#pragma mark 请求数据
- (void)obtainPersons
{
    MBShow
//    [HTTPRequest httpWithPost:@"/cus/servering" Param:@{} Success:^(id obj) {
    [HTTPRequest httpWithPost:@"/cus/contact" Param:@{} Success:^(id obj) {

        if (SUCCESS) {
            NSLog(@"obj=%@",obj);
            NSArray *arrayData = [obj valueForKey:@"data"];
            if (arrayData.count==0)
            {
                 UIImage *image = [UIImage imageNamed:@"message_new"];
                self.view.layer.contents = (id) image.CGImage;
                [self.tableView reloadData];
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@""];
                self.view.layer.contents =(id) image.CGImage;
                [self.tableView reloadData];
            }

            [_mutPersons removeAllObjects];
            [_mutSearch removeAllObjects];
            if ([arrayData isKindOfClass:[NSArray class]]) {
                if (![AppDelegate shareAppDelegate].contactNames) {
                    [AppDelegate shareAppDelegate].contactNames=[NSMutableArray array];
                }else{
                    [[AppDelegate shareAppDelegate].contactNames removeAllObjects];
                }
                
                
                for (NSDictionary *dic in arrayData) {
                    Msg_Waiting *msgWait = [JsonToModel objectFromDic:dic className:@"Msg_Waiting"];
                    [_mutPersons addObject:msgWait];
                    

                    [[AppDelegate shareAppDelegate].contactNames addObject:msgWait.nickname];
                }
            }
//            [self refreshUnreadCount];
            [_mutSearch addObjectsFromArray:_mutPersons];
            [self.tableView reloadData];
        }
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}

@end
