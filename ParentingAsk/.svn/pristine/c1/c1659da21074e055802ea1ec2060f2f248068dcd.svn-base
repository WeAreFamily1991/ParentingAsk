

#import "NSString+GetUUID.h"

@implementation NSString (GetUUID)

+ (NSString *)getUUID
{
    CFUUIDRef uuObj = CFUUIDCreate(nil);
    NSString *uuidStr =  (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuObj);
    CFRelease(uuObj);
    return uuidStr;
}

@end
