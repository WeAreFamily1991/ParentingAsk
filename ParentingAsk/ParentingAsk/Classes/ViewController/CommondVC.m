//
//  CommondVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "CommondVC.h"
#import "MainTabBarViewController.h"
#import "UINavigationItem+ItemCustom.h"
#import "CommondCell.h"
#import "LTAlertView.h"
#import "CellFrame.h"
#import "NSString+Addition.h"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH ScreenWidth-20.0f
#define CELL_CONTENT_MARGIN 0.0f
@interface CommondVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArr;
    NSString *dataStr;
    NSString *_addContStr;
    
     NSString *_IDContStr;
    NSString *_typeStr;
}


@end

@implementation CommondVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self httpRequest];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self httpRequest];
    [self.tableView reloadData];
     self.navigationController.navigationBar.titleTextAttributes =[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
   [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    UIButton* rightBun = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBun.frame = CGRectMake(0, 0, ScreenWidth/20
                                , ScreenHeight/35);
    [rightBun setBackgroundImage:[UIImage imageNamed:@"add2"] forState:normal];
    [rightBun addTarget:self action:@selector(Shareit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* right = [[UIBarButtonItem alloc] initWithCustomView:rightBun];
    self.navigationItem.rightBarButtonItem = right;
    self.title = @"常用语设置";

   
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
     [self GreatTab];
    [self setExtraCellLineHidden:self.tableView];
   
}
-(void)httpRequest
{
    [HTTPRequest httpWithPost:@"/cus/expressionList" Param:@{} Success:^(id obj)
     {
         NSLog(@"obj=%@",obj);
         _dataArr = [[obj valueForKey:@"data"]valueForKey:@"data"];
         
       
         NSLog(@"_dataArr==%@",_dataArr);
         
         [self.tableView reloadData];
     } Fail:^(NSString *errorMsg) {
         MBHide
         MBE_Sys
     }];

}
-(void)Shareit
{
    [LTAlertView showConfigBlock:^(LTAlertView *alertView) {
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    } Title:@"添加常用语" message:nil ButtonTitles:@[@"确定",@"取消"] OnTapBlock:^(LTAlertView* alert,NSInteger num) {
        NSString* str = [alert textFieldAtIndex:0].text;
        _addContStr = str;
        NSLog(@"输入的文字是%@,点击了第%ld个按钮",str,(long)num);
        if (num==0)
        {
            NSLog(@"点击了确定按钮");
            [self HTTPREQUEST];
            [self.tableView reloadData];
        }
        if (num==1)
        {
             NSLog(@"点击了取消按钮");
        }
        
        
    }];
}
-(void)HTTPREQUEST
{
    
    NSMutableDictionary *_adddic = [[NSMutableDictionary alloc]init];
    if (_addContStr.length==0)
    {
        MBS(@"请输入内容")
        
    }
    else
    {
        if (_addContStr.length>0)
        {
            [_adddic setObject:_addContStr forKey:@"content"];
        }
        [HTTPRequest httpWithPost:@"/cus/setExpression" Param:_adddic Success:^(id obj)
         {
             NSLog(@"obj=%@",obj);
             if ([[obj valueForKey:@"code"] isEqual:[NSNumber numberWithInt:1]] ) {
                 
                 MBS([obj valueForKey:@"desc"])
                 [self.tableView reloadData];
             }
             else if ([[obj valueForKey:@"code"] isEqual:[NSNumber numberWithInt:0]])
                 
             {
                 MBS([obj valueForKey:@"desc"])
                 [self httpRequest];
                 [self.tableView reloadData];
             }
             [self.tableView reloadData];
         } Fail:^(NSString *errorMsg) {
             MBHide
             MBE_Sys
         }];
        [self.tableView reloadData];

    }
    
   
    
    

}
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    [tableView setTableHeaderView:view];
    
}

#pragma mark 创建tableView
-(void)GreatTab
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)style:UITableViewStylePlain];
    
    
     self.tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.00];
    self.tableView.estimatedRowHeight = ScreenHeight/15;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    //    self.tableView.automaticallyAdjustsScrollViewInsets = NO;
    //    self.tableView.separatorStyle = NO;
    
    
    [self.view addSubview:self.tableView];
    
    
    
}

#pragma mark 按钮返回点击事件
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark  单元格返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSLog(@"_dataArr.count=%lu",(unsigned long)_dataArr.count);
    return _dataArr.count;
   
}
#pragma mark 单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *index = @"cell";
    CommondCell*cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (cell==nil)
    {
    cell =[[CommondCell alloc]initWithStyle:0 reuseIdentifier:index];
    }
    
    
    NSLog(@"接受id=%@",_IDContStr);
    
   
    cell.titleLab.text = _dataArr[indexPath.row][@"content"];
    
    
//    CGSize boundSize = CGSizeMake(216, CGFLOAT_MAX);
//    cell.userInteractionEnabled = NO;
//    cell.titleLab.numberOfLines = 0;
//    CGSize requiredSize = [cell.titleLab.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:boundSize lineBreakMode:UILineBreakModeWordWrap];
//    CGRect rect = cell.frame;
//    rect.size.height = requiredSize.height+5;
//    cell.frame = rect;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *text = cell.titleLab.text;
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    if (!cell.titleLab.text)
        cell.titleLab.text = (UILabel*)[cell viewWithTag:1];
    
    cell.titleLab.text =text;
    cell.titleLab.frame=CGRectMake(10, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - 20, MAX(size.height, 44.0f));
    
    return cell;

//    return cell;
}
#pragma mark 单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = _dataArr[indexPath.row][@"content"];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    
//    NSLog(@"cell height %f",cell.frame.size.height);
//    
//    return cell.frame.size.height;
////        return ScreenHeight/15;
   
//    return ScreenHeight/15;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC appearTabbarView];
    //
}
#pragma mark 单元格的区头高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    
//    return ScreenHeight/80;
//}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //实现编辑状态多选
    if (self.tableView.editing) {
        return UITableViewCellEditingStyleInsert|UITableViewCellEditingStyleDelete;
    }
    //普通状态左滑删除
    else{
        _typeStr = [_dataArr[indexPath.row] valueForKey:@"type"];
        if ([_typeStr isEqual:[NSNumber numberWithInt:1]])
        {
            return UITableViewCellEditingStyleNone;
        }
        return UITableViewCellEditingStyleDelete;
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source 删除内容
        NSMutableDictionary *IDDic = [NSMutableDictionary dictionary];
        _IDContStr = [_dataArr[indexPath.row] valueForKey:@"id"];
         [IDDic setObject:_IDContStr forKey:@"id"];
         NSLog(@"传参的id=%@",_IDContStr);
        [HTTPRequest httpWithPost:@"/cus/deleteExpression" Param:IDDic Success:^(id obj)
         {
             NSLog(@"obj=%@",obj);
             if (SUCCESS)
             {
                  [_dataArr removeObjectAtIndex:indexPath.row];
                 [self.tableView beginUpdates];
                 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                 [self.tableView endUpdates];
                 if ([[obj valueForKey:@"code"] isEqual:[NSNumber numberWithInt:0]] ) {
                     
                    MBS([obj valueForKey:@"desc"])
                     [self.tableView reloadData];
                 }
                 

             }
             else
             {
                 if ([[obj valueForKey:@"code"] isEqual:[NSNumber numberWithInt:1]] ) {
                     
                     MBS([obj valueForKey:@"desc"])
                     [self.tableView reloadData];
                 }

             }
                      } Fail:^(NSString *errorMsg) {
             MBHide
             MBE_Sys
         }];
       
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
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
