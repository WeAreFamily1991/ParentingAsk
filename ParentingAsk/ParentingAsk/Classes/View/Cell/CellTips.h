//
//  CellTips.h
//  ParentingAsk
//
//  Created by zouzeng on 15/12/29.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TipsInfo.h"

@interface CellTips : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title_label;
@property(nonatomic,strong)UILabel *labUnRead;
@property (strong, nonatomic) IBOutlet UILabel *time_label;

@property (strong, nonatomic) IBOutlet UILabel *content_label;
@property (weak, nonatomic) IBOutlet UIImageView *tip_Img;

+ (CellTips *)cellWithTableView:(UITableView *)tableView;

- (void) loadCellWithData:(TipsInfoDetail*) detailData;

@end
