/**
 *  YKProgressHUD.h
 *  Version 0.4
 *
 *  视图控制器基类
 *
 *  Created by Matej Bukovinski on 2.4.09.
 */

#import <UIKit/UIKit.h>

@interface YKProgressHUD : UIView { 
}
@property (nonatomic, retain) UIActivityIndicatorView   *m_activityIndicator;   // Loading指示器
@property (nonatomic, retain) UILabel                   *m_textLabel;           // 提示文字标签


/**
 *  在视图中显示HUD（中心位置默认为view的中心）
 *
 *  @param view     HUD所在父视图
 *  @param animated 是否动画显示
 *  @param message  显示信息
 *
 *  @return HUD
 */
+ (YKProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withText:(NSString*)message;

/**
 *  在视图中显示HUD（中心位置默认为view的中心）
 *
 *  @param view     HUD所在父视图
 *  @param animated 是否动画显示
 *  @param message  显示信息
 *  @param aCenter  HUD的中心位置
 *
 *  @return HUD
 */
+ (YKProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withText:(NSString*)message HUDCenter:(CGPoint)aCenter;

/**
 *  在视图中显示HUD（中心位置默认为view的中心）
 *
 *  @param view     HUD所在父视图
 *  @param animated 是否动画显示
 *  @param message  显示信息
 *  @param model    转圈过程中界面是否可响应触屏，YES为可以
 *
 *  @return HUD
 */
+ (YKProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withText:(NSString*)message interactionEnable:(BOOL)model;

/**
 *  在视图中显示HUD
 *
 *  @param view     HUD所在父视图
 *  @param animated 是否动画显示
 *  @param message  显示信息
 *  @param model    转圈过程中界面是否可响应触屏，YES为可以
 *  @param aCenter  HUD的中心位置
 *
 *  @return HUD
 */
+ (YKProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withText:(NSString*)message interactionEnable:(BOOL)model HUDCenter:(CGPoint)aCenter;

/**
 *  隐藏HUD
 *
 *  @param view     HUD所在视图
 *  @param animated 是否动画显示
 *
 *  @return 隐藏是否成功
 */
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;

@end
