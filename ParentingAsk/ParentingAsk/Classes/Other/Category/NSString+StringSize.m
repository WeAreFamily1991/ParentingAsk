
//  计算文字尺寸

#import "NSString+StringSize.h"

@implementation NSString (StringSize)

+ (CGSize)stringReturnSizeWithText:(NSString *)text Size:(CGSize)size FontSize:(CGFloat)font
{
    if (size.width == 0) {
        size.width = CGFLOAT_MAX;
    }
    if (size.height == 0) {
        size.height = CGFLOAT_MAX;
    }
    CGSize textSize = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil] context:nil].size;
    return textSize;
}

+ (CGSize)stringReturnSizeWithText:(NSString *)text Size:(CGSize)size Font:(UIFont *)font
{
    if (size.width == 0) {
        size.width = CGFLOAT_MAX;
    }
    if (size.height == 0) {
        size.height = CGFLOAT_MAX;
    }
    CGSize textSize = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil].size;
    return textSize;
}

+ (NSString *)stringReturnFromTime:(NSString *)timeInterval
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *dateTemp = [NSDate dateWithTimeIntervalSince1970:timeInterval.doubleValue/1000];
    NSString *strTemp = [[formatter stringFromDate:dateTemp] substringWithRange:NSMakeRange(5, 5)];
    
    NSDate *dateCurrent = [NSDate date];
    NSString *strCurrent = [[formatter stringFromDate:dateCurrent] substringWithRange:NSMakeRange(5, 5)];
    
    if ([strTemp isEqualToString:strCurrent]) {
        NSTimeInterval currentInteval = [dateTemp timeIntervalSinceNow];
        if (-currentInteval < 60) {
            return @"刚刚";
        }
        return [[formatter stringFromDate:dateTemp] substringFromIndex:11];
    }
    else {
        return [[formatter stringFromDate:dateTemp] substringFromIndex:5];
    }
}


@end
