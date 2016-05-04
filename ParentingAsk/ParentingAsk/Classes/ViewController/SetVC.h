//
//  SetVC.h
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
@interface SetVC : BaseVC<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UITableView *tableView;
@end
