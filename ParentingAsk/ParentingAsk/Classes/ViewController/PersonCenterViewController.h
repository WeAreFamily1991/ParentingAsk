//
//  PersonCenterViewController.h
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/15.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
@interface PersonCenterViewController : BaseVC
@property (nonatomic ,retain) UITableView *tableView;
@property (nonatomic, strong) UINavigationController *navigationCurrent;
@end
