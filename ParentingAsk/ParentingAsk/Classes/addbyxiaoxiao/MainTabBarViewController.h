//
//  MainTabBarViewController.h
//  ChinaPoetryNet
//
//  Created by User on 5/6/15.
//  Copyright (c) 2015 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "BPMKNumberBadgeView.h"
#import "ConnectsVC.h"

@interface MainTabBarViewController : UITabBarController
{
    int currentSelectedIndex;
}
@property(nonatomic,strong)UIView *tabbarView;
@property(nonatomic,strong)CustomButton *msgBtn;//消息
@property(nonatomic,strong)CustomButton *conBtn;//联系人
@property(nonatomic,strong)CustomButton *setBtn;//设置
@property(nonatomic,strong)CustomButton *GrabBtn;//抢单
@property(nonatomic,strong)CustomButton *MineBtn;//个人
@property (nonatomic,strong) BPMKNumberBadgeView *contactBadgeView;

@property (nonatomic,strong) BPMKNumberBadgeView *messageBadgeView;
@property (nonatomic,strong) BPMKNumberBadgeView *GraBadgeView;
@property(nonatomic,strong)ConnectsVC *connectCount;

- (void)hiddenTabbarView;
- (void)appearTabbarView;

//Travel
- (void)itemBtnClick:(CustomButton *)sender changeColorOnly:(BOOL)changeColorOnly;
@end
