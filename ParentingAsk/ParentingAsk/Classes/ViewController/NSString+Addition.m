//
//  NSString+Addition.m
//  RoySinaWeiboTest
//
//  Created by 智游集团 on 16/1/5.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)
//获取一个没有空格的字符串
- (NSString *)noWhiteSpaceString
{
    NSString *resultStr = @"";
    
    NSArray *tempArr =  [self componentsSeparatedByString:@" "];
    
    for (NSString *tempStr in tempArr)
    {
        resultStr = [resultStr stringByAppendingString:tempStr];
    }
    
    return resultStr;
}

//判断一个字符串是否包含另一个字符串
- (BOOL)isContainSubString:(NSString *)aSubstr
{
    NSRange range =  [self rangeOfString:aSubstr];
    
    //[self containsString:<#(nonnull NSString *)#>]
    /*
    if (range.length <= 0)
    {
        return NO;
    }
     */
    
    if (range.location == NSNotFound)
    {
        return NO;
    }
    
    return YES;
}
#pragma mark  - 把新浪微博的时间转化为刚刚、3分钟前。。等格式
- (NSString *)sinaWeiboCreatedAtString
{
    NSString *weiboDateStr = @"";
    
    //创建时间格式器，并设置时间格式
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    
    NSString *formaterStr = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    formater.dateFormat = formaterStr;
    
    //用时间格式器把指定的时间字符串 转化为相应格式的时间
    NSDate *weiboDate = [formater dateFromString:self];
    
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //根据日历判断 微博时间是否是在今天
    if ([calendar isDateInToday:weiboDate])
    {
        //返回今天什么时候发布的，比如3分钟前
        
        NSDate *currentDate = [NSDate date];
        
        //判断微博时间和当前时间的时间差,单位是秒
        double tempTimeInterval = [currentDate timeIntervalSinceDate:weiboDate];
        
        if(tempTimeInterval < 60)
        {
            weiboDateStr = @"刚刚";
        }
        else if ((tempTimeInterval/60.0 > 1) && (tempTimeInterval / 60.0 / 60.0 < 1))
        {
            weiboDateStr = [NSString stringWithFormat:@"%d分钟前",(int)tempTimeInterval/60];
        }
        else
        {
             weiboDateStr = [NSString stringWithFormat:@"%d小时前",(int)tempTimeInterval/60/60];
        }
            
    }
    else
    {
        //返回 年月日发布的
        formater.dateFormat = @"yyyy-MM-dd";
        
       weiboDateStr = [formater stringFromDate:weiboDate];
    }
    
    return weiboDateStr;
}

#pragma mark 解析微博来源
- (NSString *)sinaWeiboSourceString
{
    //<a href=\"http://app.weibo.com/t/feed/4fuyNj\" rel=\"nofollow\">\U5373\U523b\U7b14\U8bb0</a>
    
     NSString *resultStr = @"";
    
    //以字符“>”为节点，获取">"之前的字符串的范围
    NSRange aRange = [self rangeOfString:@">"];
    
    if (aRange.location != NSNotFound)
    {
        //NSMaxRange(aRange)获取某一个范围的大小
        
        //根据获取的范围大小，作为下一截字符串的起点，截取字符串
        NSRange range = NSMakeRange(NSMaxRange(aRange), self.length - NSMaxRange(aRange) - 4);
        
        //截取字符串
       resultStr = [self substringWithRange:range];
    }
    
    
    
    return resultStr;
}
/*获取文本的宽度*/
- (float)getTextHeightWithShowWidth:(float)width AndTextFont:(UIFont *)aFont AndInsets:(float)inset
{
    return ceil([self boundingRectWithSize:CGSizeMake(width - inset * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : aFont} context:nil].size.height) + inset * 2;
}

/**使用指定的正则表达式过滤字符串**/
- (NSArray <NSTextCheckingResult *> *)myMatchWithPattern:(NSString *)aPattern
{
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:aPattern options:0 error:nil];
    
    if (regularExpression)
    {
        NSArray <NSTextCheckingResult *> *resultArray = [regularExpression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
        
        return resultArray;
    }
    
    return nil;
}
@end






