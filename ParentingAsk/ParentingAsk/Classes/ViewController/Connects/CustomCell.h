//
//  CustomCell.h
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/21.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPMKNumberBadgeView.h"
@class Msg_Waiting;
@interface CustomCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *imageAvatar;
@property (nonatomic, weak) IBOutlet UILabel *labName;
@property (nonatomic, weak) IBOutlet UILabel *labDesc;
@property (nonatomic, weak) IBOutlet UILabel *labTime;
@property (nonatomic, strong)  UILabel *labUnRead;
@property (weak, nonatomic) IBOutlet BPMKNumberBadgeView *badgeView;
@property (weak, nonatomic) IBOutlet BPMKNumberBadgeView *badgeViewOnImg;


@property(nonatomic,strong)NSString *nicknameStr,*timeStr,*descStr,*headerStr;

@property (nonatomic, strong) Msg_Waiting *msg_Waiting;
+ (CustomCell *)cellWithTableView:(UITableView *)tableView;
@end
