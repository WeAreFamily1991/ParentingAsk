//
//  connectCell.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/20.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "connectCell.h"

@implementation connectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, ScreenWidth, ScreenHeight/20)];
        //
        //        view.backgroundColor = [UIColor whiteColor];
        //    [self.contentView addSubview:view];
        
        
        self.numLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenHeight/16-ScreenHeight/60, ScreenHeight/30-ScreenHeight/60, ScreenHeight/10, ScreenHeight/30)];
        self.numLab.textColor = SystemGrayColor;
         self.numLab.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.numLab];
        
        self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenHeight/8, 0, ScreenWidth/2, ScreenHeight/15)];
        self.titLab.textColor = SystemGrayColor;
        self.titLab.font = [UIFont systemFontOfSize:17];
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
