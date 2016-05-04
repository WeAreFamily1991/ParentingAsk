//
//  TipsTVC.m
//  ParentingAsk
//
//  Created by zouzeng on 15/12/25.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "TipsTVC.h"
#import "TipsInfo.h"
#import "TMWebViewController.h"
#import "CellTips.h"
#import "AppDelegate.h"
#import "UINavigationItem+ItemCustom.h"
@interface TipsTVC ()
{
    NSMutableArray *_tipsArray;
    long intID;
    long tipImg;
    NSArray *tipList;
    NSMutableArray *temList;
    TipsInfoDetail *tipDetail;
    TipsInfo       *_tipsInfo;
}

@end

@implementation TipsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.00];
//    self.tableView.backgroundColor = [UIColor redColor];
    self.title = @"通知";
    
    _tipsArray = [NSMutableArray array];
    
    [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.navigationItem navigationRightWithTitle:nil Img:[UIImage imageWithFile:@"u0.png"] Delegate:self Action:@selector(clickPersonal) IsHeader:YES];
//    [self getTipsInfoWithPageNo:1];
    
//    [self setNavBackBarHidden];
    
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)clickPersonal
{
    
}

//用于设置cell分割线15像素空白问题
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        UIEdgeInsets insets = {20,20,20,20};
        [self.tableView setSeparatorInset:insets];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        UIEdgeInsets insets = {20,20,20,20};
        
        [self.tableView setLayoutMargins:insets];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //zou
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC appearTabbarView];
    [self getTipsInfoWithPageNo:1];
    [self httpRequest];

}
-(void)httpRequest
{
    [HTTPRequest httpWithPost:@"/cus/article" Param:@{ } Success:^(id obj)
     {
         if (SUCCESS)
     {
         
         NSLog(@"returnData:%@",obj);
         
         NSDictionary *tipDic = [obj objectForKey:@"data"];
         _tipsInfo = [[TipsInfo alloc]init];
         _tipsInfo.lastPage = [[tipDic objectForKey:@"lastPage"] intValue];
         _tipsInfo.pageSize = [[tipDic objectForKey:@"lastPage"] intValue];
         _tipsInfo.pageNumber = [[tipDic objectForKey:@"lastPage"] intValue];
         _tipsInfo.firstPage = [[tipDic objectForKey:@"lastPage"] intValue];
         _tipsInfo.totalPage = [[tipDic objectForKey:@"lastPage"] intValue];
         _tipsInfo.totalRow  = [[tipDic objectForKey:@"lastPage"] intValue];
         NSArray *tipList = [tipDic objectForKey:@"list"];
         
         temList = [NSMutableArray array];
         for (NSDictionary *tempTipDetail in tipList) {
             tipDetail =[[TipsInfoDetail alloc]init];
             tipDetail.idNum = [[tempTipDetail objectForKey:@"id"] longValue];
             intID=tipDetail.idNum;
             tipDetail.time = [[tempTipDetail objectForKey:@"time"] longValue];
             tipDetail.title = [tempTipDetail objectForKey:@"title"];
             tipDetail.desc = [tempTipDetail objectForKey:@"desc"];
             tipDetail.url = [tempTipDetail objectForKey:@"url"];
             tipDetail.stats = [[tempTipDetail objectForKey:@"status"]longValue];
             tipImg = tipDetail.stats;
             [temList addObject:tipDetail];
             NSLog(@"tipDetail.stats=%ld",tipDetail.stats);
             
             
         }
         [self.tableView reloadData];
     }
         
         
         MBHide
     } Fail:^(NSString *errorMsg) {
         MBHide
         MBE_Sys
     }];

    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //travel
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC hiddenTabbarView];
    //
}

-(void)getTipsInfoWithPageNo:(int)pageNo
{
    MBShow
    
    if (pageNo == 1) {
        [_tipsArray removeAllObjects];
    }
    
    [HTTPRequest httpWithPost:@"/cus/article" Param:@{@"pageNo":[NSNumber numberWithInt:pageNo],@"pageSize":[NSNumber numberWithInt:20] } Success:^(id obj) {
        if (SUCCESS) {
            
            NSLog(@"returnData:%@",obj);
            
            NSDictionary *tipDic = [obj objectForKey:@"data"];
            _tipsInfo = [[TipsInfo alloc]init];
            _tipsInfo.lastPage = [[tipDic objectForKey:@"lastPage"] intValue];
            _tipsInfo.pageSize = [[tipDic objectForKey:@"lastPage"] intValue];
            _tipsInfo.pageNumber = [[tipDic objectForKey:@"lastPage"] intValue];
            _tipsInfo.firstPage = [[tipDic objectForKey:@"lastPage"] intValue];
            _tipsInfo.totalPage = [[tipDic objectForKey:@"lastPage"] intValue];
            _tipsInfo.totalRow  = [[tipDic objectForKey:@"lastPage"] intValue];
            NSArray *tipList = [tipDic objectForKey:@"list"];
        
            temList = [NSMutableArray array];
            for (NSDictionary *tempTipDetail in tipList) {
               tipDetail =[[TipsInfoDetail alloc]init];
                tipDetail.idNum = [[tempTipDetail objectForKey:@"id"] longValue];
                tipDetail.imgage =[tempTipDetail objectForKey:@"imgurl"];
                
                NSLog(@"intID=%ld",intID);
                tipDetail.time = [[tempTipDetail objectForKey:@"time"] longValue];
                tipDetail.title = [tempTipDetail objectForKey:@"title"];
                tipDetail.desc = [tempTipDetail objectForKey:@"desc"];
                tipDetail.url = [tempTipDetail objectForKey:@"url"];
                tipDetail.stats = [[tempTipDetail objectForKey:@"status"]longValue];
                tipImg = tipDetail.stats;
                [temList addObject:tipDetail];
                NSLog(@"tipDetail.stats=%ld",tipDetail.stats);
                
                
            }
            _tipsInfo.list = temList;
            
            [_tipsArray addObjectsFromArray:_tipsInfo.list];
            
            
            [self.tableView reloadData];
        }
        
        
                MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tipsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellTips *cell = [CellTips cellWithTableView:tableView];
    
    // Configure the cell...
    [cell loadCellWithData:[_tipsArray objectAtIndex:indexPath.row]];
//    NSLog(@"_tipsArray=%@",_tipsArray);
//    NSString *str = [_tipsAr]
//      int str =[NSString stringWithFormat]][_tipsArray valueForKey:@"status"];
//    NSLog(@"str=%@",str);
//    int x =[[tipList[indexPath.row] valueForKey:@"status"] intValue];
//        NSLog(@"x=%d",x);
//    if (tipDetail.stats==1)
//    {
//        cell.tip_Img.image =[UIImage imageNamed:@"tongzhi-gray"];
//        NSLog(@"显示img=%@",cell.tip_Img.image);
//    }
//    else
//    {
//        cell.tip_Img.image =[UIImage imageNamed:@"tongzhi-green"];
//    }
//   
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight/8;
}

#pragma mark 单元格的区头高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    
//    return ScreenHeight/80;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return ScreenHeight/80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    tipDetail =[[TipsInfoDetail alloc]init];
//    tipDetail.idNum = [[ objectForKey:@"id"] longValue];
    NSLog(@"%ld",(long)indexPath.row);
    NSString *url = [(TipsInfoDetail *)[_tipsArray objectAtIndex:indexPath.row] url];
  long articleId = [(TipsInfoDetail *)[_tipsArray objectAtIndex:indexPath.row] idNum];
    NSLog(@"url=%@",url);
     NSLog(@"intID=%ld",intID);
    [HTTPRequest httpWithPost:@"/cus/setArticleReadStatus" Param:@{@"article_id":[NSNumber numberWithLong:articleId]} Success:^(id obj) {
        if (SUCCESS)
        {
//            if (intID==1)
//            {
//                cell.tip_Img.image =[UIImage imageNamed:@"tongzhi-gray"];
//                NSLog(@" 点击cell.tip_Img.image=%@", cell.tip_Img.image);
//                NSLog(@"obj = %@",obj);
//            }
            
            [self.tableView reloadData];
        }
        
//
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE_Sys
    }];

    TMWebViewController *webVC = [[TMWebViewController alloc]initWithNibName:@"TMWebViewController" bundle:nil withUrl:url andTitle:nil];
    NSLog(@"url=%@",url);
    //zou
//    webVC.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:webVC animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _tipsArray.count) {
        if (_tipsInfo.pageNumber < _tipsInfo.totalPage) {
            [self getTipsInfoWithPageNo:_tipsInfo.totalPage - _tipsInfo.pageNumber];
        }else
        {
            [self showHint:@"数据已全部加载完成"];
        }
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
