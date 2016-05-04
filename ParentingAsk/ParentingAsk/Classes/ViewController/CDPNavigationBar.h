//
//  CDPNavigationBar.h
//  iMeeting
//
//  Created by cui on 15/9/23.
//  Copyright © 2015年 张忠瑞. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CDPNavigationBar : UIView

//标题
@property(strong , nonatomic)UILabel *titleLabel;

//左边按钮
@property(strong , nonatomic)UIButton *leftBtn;


//右边按钮
@property(strong , nonatomic)UIButton *rightBtn;
@property(strong , nonatomic)UILabel  *rightTitleLabel;

//背景
@property(strong , nonatomic)UIImageView *BGImg;

//标题按钮
@property(strong , nonatomic)UIButton *titleBtn;

//标题图片
@property(strong , nonatomic)UIImageView *titleIMG;


- (instancetype)initWithBG:(NSString *)BGimgName andleftName:(NSString *)leftBtnBG_Name andrightName:(NSString *)rightBtnBG_Name andtitleText:(NSString *)titleText;
@end
