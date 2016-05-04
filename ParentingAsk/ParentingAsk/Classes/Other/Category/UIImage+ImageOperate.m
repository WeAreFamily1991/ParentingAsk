

#import "UIImage+ImageOperate.h"

@implementation UIImage (ImageOperate)

+ (UIImage *)imageWithRotate:(UIImage *)image Radius:(float)radius
{
    float newSide = MAX(image.size.width, image.size.height);
    CGSize size = CGSizeMake(newSide, newSide);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, newSide/2, newSide/2);
    CGContextRotateCTM(ctx, radius);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(-image.size.width / 2, -image.size.height / 2, size.width, size.height), image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


//zou 图片压缩至指定大小
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
//    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return imageData;
}

@end
