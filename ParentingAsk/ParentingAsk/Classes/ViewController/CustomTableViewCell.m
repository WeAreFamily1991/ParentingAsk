//
//  CustomTableViewCell.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "CustomTableViewCell.h"
#define COLOR_SYS  [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.00]
@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, ScreenWidth, ScreenHeight/20)];
//        
//        view.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:view];
        
        
        self.titImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenHeight/16-ScreenHeight/60, ScreenHeight/30-ScreenHeight/60, ScreenHeight/30, ScreenHeight/30)];
        [self.contentView addSubview:self.titImg];
        
        self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenHeight/8, 0, ScreenWidth/2, ScreenHeight/15)];
        
        self.titLab.font = [UIFont systemFontOfSize:14];
        
//        self.titLab.textColor = sysDGrayColor;
        self.titLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titLab];
        
        self.lineLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenHeight/9, ScreenHeight/15-1, ScreenWidth-ScreenHeight/8, 0.5)];
        
//        self.lineLab.font = [UIFont systemFontOfSize:14];
        self.lineLab.backgroundColor = COLOR_SYS;
        
        //        self.titLab.textColor = sysDGrayColor;
        self.lineLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.lineLab];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
