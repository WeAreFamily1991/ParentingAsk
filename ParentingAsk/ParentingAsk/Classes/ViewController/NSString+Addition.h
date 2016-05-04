//
//  NSString+Addition.h
//  RoySinaWeiboTest
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Addition)
- (NSString *)noWhiteSpaceString;
- (BOOL)isContainSubString:(NSString *)aSubstr;
- (NSString *)sinaWeiboCreatedAtString;
- (NSString *)sinaWeiboSourceString;
- (float)getTextHeightWithShowWidth:(float)width AndTextFont:(UIFont *)aFont AndInsets:(float)inset;
- (NSArray <NSTextCheckingResult *> *)myMatchWithPattern:(NSString *)aPattern;
@end




