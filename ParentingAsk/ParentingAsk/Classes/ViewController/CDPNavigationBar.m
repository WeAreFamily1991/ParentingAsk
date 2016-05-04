//
//  CDPNavigationBar.m
//  iMeeting
//
//  Created by cui on 15/9/23.
//  Copyright © 2015年 张忠瑞. All rights reserved.
//

#import "CDPNavigationBar.h"


@implementation CDPNavigationBar

- (instancetype)initWithBG:(NSString *)BGimgName andleftName:(NSString *)leftBtnBG_Name andrightName:(NSString *)rightBtnBG_Name andtitleText:(NSString *)titleText
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    if (self) {
        //判断是否存在背景图片
        if (BGimgName != nil) {
            self.BGImg = [[UIImageView alloc]initWithFrame:self.bounds];
            self.BGImg.image = [UIImage imageNamed:BGimgName];
            [self addSubview:self.BGImg];
        }
        else{
            self.backgroundColor =[UIColor colorWithRed:208.0/255.0 green:121.0/255.0 blue:0.0/255.0 alpha:1.00];
        }
        
        //标题RGBA_COLOR(208, 121, 0 ,1);
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 120, 30)];
        self.titleLabel.text = titleText;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor whiteColor];
        
        //标题图片
        self.titleIMG = [[UIImageView alloc]initWithFrame:CGRectMake(120, 12, 20, 10)];
        
        
        //标题按钮
        self.titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-75, 28, 150, 30)];
        [self.titleBtn addSubview:self.titleLabel];
        [self.titleBtn addSubview:self.titleIMG];
        
        //左边按钮
        self.leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 14, 50, 50)];
        self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        if (leftBtnBG_Name != nil) {
            UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 12, 24)];
            leftImg.image = [UIImage imageNamed:leftBtnBG_Name];
            
            [self.leftBtn addSubview:leftImg];
        }else{
//            [self.leftBtn setTitle:@"未设置" forState:UIControlStateNormal];
//            [self.leftBtn setBackgroundColor:[UIColor grayColor]];
        }
        


        //右边按钮
        self.rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50, 14, 50, 50)];
        self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        self.rightTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 14, 40 , 30)];
        self.rightTitleLabel.font = [UIFont systemFontOfSize:15];
        self.rightTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.rightTitleLabel.textColor = [UIColor whiteColor];
        [self.rightBtn addSubview:self.rightTitleLabel];
        
        
        if (rightBtnBG_Name != nil) {
            UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 18, 20, 20)];
            rightImg.image = [UIImage imageNamed:rightBtnBG_Name];
            [self.rightBtn addSubview:rightImg];
        }else{
//            [self.rightBtn setTitle:@"未设置" forState:UIControlStateNormal];
//            [self.rightBtn setBackgroundColor:[UIColor grayColor]];
        }
        
        [self addSubview:self.titleBtn];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
    }
    return self;
}


@end
