
//
//  CellTips.m
//  ParentingAsk
//
//  Created by zouzeng on 15/12/29.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "CellTips.h"

@implementation CellTips

+ (CellTips *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identi = @"identiCellCellTips";
    CellTips *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CellTips" owner:nil options:nil] lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void) loadCellWithData:(TipsInfoDetail*) detailData
{
    
    NSLog(@"detailData==%@",detailData);
    self.title_label.text = detailData.title;
    self.time_label.text  = [ NSString stringReturnFromTime:[NSString stringWithFormat:@"%ld",detailData.time]];
    self.content_label.text = detailData.desc;
    NSString *headStr = detailData.imgage;
//    self.tip_Img.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:detailData.url]];
      NSLog(@" headStr===%@", headStr);
    
     self.labUnRead = [[UILabel alloc]initWithFrame:CGRectMake(55, 10, 10, 10)];
    if (detailData.stats==1)
    {
//[self.tip_Img sd_setImageWithURL:[NSURL URLWithString:headStr] placeholderImage:nil];
        
       self.labUnRead.backgroundColor =[UIColor clearColor];
        self.tip_Img.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:headStr]]];
    }
    else
    {
      
       
        self.labUnRead.textColor = [UIColor whiteColor];
        self.labUnRead.backgroundColor =[UIColor redColor];
        self.labUnRead.layer.masksToBounds =5;
        self.labUnRead.textAlignment = NSTextAlignmentCenter;
        self.labUnRead.layer.cornerRadius = 5;
        [self.contentView addSubview:self.labUnRead];

        self.tip_Img.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:headStr]]];
    }
   
}

@end
