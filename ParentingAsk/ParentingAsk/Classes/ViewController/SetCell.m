//
//  SetCell.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/20.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "SetCell.h"

@implementation SetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, ScreenWidth, ScreenHeight/20)];
        //
        //        view.backgroundColor = [UIColor whiteColor];
        //    [self.contentView addSubview:view];
        self.lineLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenHeight/8, ScreenHeight/15, ScreenWidth-ScreenHeight/7, 1)];
        
        //        self.lineLab.font = [UIFont systemFontOfSize:14];
        self.lineLab.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.00];
        
        
        //        self.titLab.textColor = sysDGrayColor;
        self.lineLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.lineLab];

        
        self.titImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenHeight/16-ScreenHeight/60, ScreenHeight/30-ScreenHeight/60, ScreenHeight/30, ScreenHeight/30)];
        [self.contentView addSubview:self.titImg];
        
        self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenHeight/8, 0, ScreenWidth/2, ScreenHeight/15)];
        
        self.titLab.font = [UIFont systemFontOfSize:14];
        //        self.titLab.textColor = sysDGrayColor;
        self.titLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titLab];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
