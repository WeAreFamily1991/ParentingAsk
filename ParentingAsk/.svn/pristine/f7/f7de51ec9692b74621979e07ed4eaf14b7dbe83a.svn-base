

#import "UIImage+LoadFile.h"

@implementation UIImage (LoadFile)

+ (UIImage *)imageWithFile:(NSString *)filename
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    UIImage *img = [UIImage imageWithContentsOfFile:strPath];
    return img;
}

@end
