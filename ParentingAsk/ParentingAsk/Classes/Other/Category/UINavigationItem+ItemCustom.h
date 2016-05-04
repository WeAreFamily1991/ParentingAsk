

#import <UIKit/UIKit.h>

@interface UINavigationItem (ItemCustom)

//自定义左侧item
- (void)navigationLeftWithTitle:(NSString *)title Img:(UIImage *)img Delegate:(id)delegate Action:(SEL)action;

//自定义返回item
- (void)navigationBackWithDelegate:(id)delegate Action:(SEL)action;

//自定义右侧item
- (void)navigationRightWithTitle:(NSString *)title Img:(UIImage *)img Delegate:(id)delegate Action:(SEL)action IsHeader:(BOOL)isHeader;

@end
