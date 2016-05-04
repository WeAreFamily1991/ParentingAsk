//
//  YasinCustomAlertView.h
//  Allure
//
//  Created by 伍鑫 on 16/3/17.
//  Copyright © 2016年 伍鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DetermineBlock)();
typedef void(^CancelBlock)();

@interface YasinCustomAlertView : UIView
@property (nonatomic, strong) DetermineBlock determineBlock;
@property (nonatomic, strong) CancelBlock    cancelBlock;

+ (void)showTitle:(NSString *)title Message
                 :(NSString *)message DetermineButtonTitle
                 :(NSString *)determineTitle DetermineBlock
                 :(DetermineBlock)determine;

+ (void)showTitle:(NSString *)title Message
                 :(NSString *)message DetermineButtonTitle
                 :(NSString *)determineTitle CancelButtonTitle
                 :(NSString *)cancelTitle DetermineBlock
                 :(DetermineBlock)determine CancelBlock
                 :(CancelBlock)cancel;

@end
