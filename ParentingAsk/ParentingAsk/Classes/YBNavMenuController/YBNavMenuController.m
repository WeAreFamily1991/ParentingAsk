//
//  YBNavMenuController.m
//  Wanyingjinrong
//
//  Created by Jason on 15/11/13.
//  Copyright © 2015年 www.jizhan.com. All rights reserved.
//

#import "YBNavMenuController.h"
#import "UIView+Extension.h"
#import "YBDefine.h"

@interface YBNavMenuController ()

@end

@implementation YBNavMenuController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleBlackOpaque;
}

- (void)registerNibNames:(NSArray *)nibNames forIndex:(NSInteger)index
{
    for (NSString *nibName in nibNames) {
        [self.tableArr[index] registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
    }
}

- (void)layout:(NSArray<NSString *> *)items
{
    NSInteger count = items.count;
    NavMenuScrollView *menuScorllView = [NavMenuScrollView navMenuScrollViewWithFrame:CGRectMake(kScreenW/4, 0, kScreenW/2, 44) items:items];
    menuScorllView.delegate2 = self;
    self.menuScorllView = menuScorllView;
    [self.view addSubview:menuScorllView];
    
    UIScrollView *tableScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(menuScorllView.frame), kScreenW, kScreenH-44)];
    tableScrollView.delegate = self;
    tableScrollView.pagingEnabled = YES;
    tableScrollView.contentSize = CGSizeMake(count * kScreenW, 0);
    tableScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:tableScrollView];
    self.tableScrollView = tableScrollView;
    
    NSMutableArray *tableArr = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        YBTableView *tableView = [YBTableView tableWithFrame:CGRectMake(i*kScreenW, 0, kScreenW, tableScrollView.height) delegate:self tag:i registerNibNames:nil style:UITableViewStylePlain];
        [self.tableScrollView addSubview:tableView];
        [tableArr addObject:tableView];
    }
    self.tableArr = tableArr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[YBTableView class]]) return;
    if (self.isClick) return;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger count = self.menuScorllView.items.count;
    self.menuScorllView.animationView.x = kScreenW/count/2.0 + offsetX/count - self.menuScorllView.animationView.width/2;
    
    //计算出第几页
    int page = (scrollView.contentOffset.x + kScreenW/2)/kScreenW;
    self.currentPage = page;
    self.menuScorllView.currentSelectIndex = page;
    [self.menuScorllView setCurrentSelectIndex:page markViewAnimate:NO];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.isClick = NO;
}

#pragma mark - NavMenuScrollViewDelegate
- (void)navMenuScrollView:(NavMenuScrollView *)navMenuScrollView didClickButtonIndex:(NSInteger)index
{
    self.currentPage = index;
    //计算出第几页
    int page = (self.tableScrollView.contentOffset.x + kScreenW/2)/kScreenW;
    if (index == page) return;
    self.isClick = YES;
    [self.tableScrollView setContentOffset:CGPointMake(index * kScreenW, 0) animated:YES];
}

@end
