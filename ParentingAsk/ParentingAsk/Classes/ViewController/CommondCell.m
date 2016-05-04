//
//  CommondCell.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/24.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "CommondCell.h"

@implementation CommondCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/15, 0, ScreenWidth, ScreenHeight/15)];
        self.titleLab.textColor = [UIColor blackColor];
        self.titleLab.numberOfLines =0;
        self.titleLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
