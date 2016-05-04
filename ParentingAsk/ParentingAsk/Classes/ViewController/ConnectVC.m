//
//  ConnectVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/20.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "ConnectVC.h"
#import "UINavigationItem+ItemCustom.h"
#import "connectCell.h"
@interface ConnectVC ()
@property (strong,nonatomic)NSArray *titArr,*numArr;
@end

@implementation ConnectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系我们";
    
  
    [self GreatTab];
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
    self.numArr = [[NSArray alloc]initWithObjects:@"电话", @"QQ",@"微信",@"邮箱",nil];

    self.titArr = [[NSArray alloc]initWithObjects:@"400-685-1212", @"2239076675",@"aicanyu",@"kf@yewyw.com",nil];
    [self setExtraCellLineHidden:self.tableView];
}
-(void)GreatTab
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScreenHeight/40, ScreenWidth,  ScreenHeight)];
    
    
    self.tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.00];
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = ScreenHeight/15;
//  self.tableView.separatorStyle = NO;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    [self.view addSubview:self.tableView];
    
    
    
}

- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    [tableView setTableHeaderView:view];
    
}

-(void)btnClick
{
     [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *index = @"cell";
    connectCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    
    if (cell==nil)
    {
        cell =[[connectCell alloc]initWithStyle:0 reuseIdentifier:index];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.numLab.text = self.numArr[indexPath.row];
    
    cell.titLab.text =self.titArr[indexPath.row];
    return cell;
    
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
