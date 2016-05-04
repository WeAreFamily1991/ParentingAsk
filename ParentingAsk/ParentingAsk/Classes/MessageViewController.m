//
//  MessageViewController.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//
#import "UINavigationItem+ItemCustom.h"
#import "MessageViewController.h"
#import "MainTabBarViewController.h"
@interface MessageViewController ()

@end

@implementation MessageViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   self.navigationController.navigationBarHidden = YES;
    //
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
      [self.navigationItem navigationRightWithTitle:nil Img:[UIImage imageWithFile:@"u0.png"] Delegate:self Action:@selector(clickPersonal) IsHeader:YES];
//    [self.navigationItem navigationRightWithTitle:nil Img:[UIImage imageWithFile:@"app-icon.png"] Delegate:self Action:@selector(clickPersonal) IsHeader:YES];
//    [self.navigationController.navigationBar setTranslucent:NO];
//    [self.navigationItem navigationLeftWithTitle:nil Img:nil Delegate:nil Action:nil];
    [self layout];
}

- (void)layout
{
    [self layout:@[@"抢单", @"消息" ]];
}
-(void)clickPersonal
{
    
}
#pragma mark - 代理方法
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 0:
            return 10;
            break;
        case 1:
            return 20;
            break;
        case 2:
            return 30;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSString *str = nil;
    switch (tableView.tag) {
        case 0:
            str = [NSString stringWithFormat:@"这个tableView的tag为0-----%zi", indexPath.row];
            break;
        case 1:
            str = [NSString stringWithFormat:@"这个tableView的tag为1-----%zi", indexPath.row];
            break;
        case 2:
            str = [NSString stringWithFormat:@"这个tableView的tag为2-----%zi", indexPath.row];
            break;
        default:
            break;
    }
    
    cell.textLabel.text = str;
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [super scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)navMenuScrollView:(NavMenuScrollView *)navMenuScrollView didClickButtonIndex:(NSInteger)index
{
    [super navMenuScrollView:navMenuScrollView didClickButtonIndex:index];
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
