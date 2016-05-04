/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);
CGRect CGRectMakeWithScreenRate(float left,float top,float widthRate,float heightRate);
CGRect CGRectMakeWithParentRate(float left,float top,float widthRate,float heightRate,CGRect parentRect);

CGPoint CGMyPointMake(float x,float y);

//常量
//int SCREENHEIGHT;
//int SCREENWIDTH;
//
//int STATUSBARHEIGHT;
//int NAVIGATIONBAR_HEIGHT;
//int TABBAR_HEIGHT;

@interface UIView (ViewFrameGeometry)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;
@end