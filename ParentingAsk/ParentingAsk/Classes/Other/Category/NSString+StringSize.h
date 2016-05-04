
//  计算文字尺寸

#import <Foundation/Foundation.h>

@interface NSString (StringSize)

/**
 返回系统文字尺寸
 **/
+ (CGSize)stringReturnSizeWithText:(NSString *)text Size:(CGSize)size FontSize:(CGFloat)font;


/**
 返回自定义font尺寸
 **/
+ (CGSize)stringReturnSizeWithText:(NSString *)text Size:(CGSize)size Font:(UIFont *)font;


/**
 返回格式化后的时间
 **/
+ (NSString *)stringReturnFromTime:(NSString *)timeInterval;


@end
