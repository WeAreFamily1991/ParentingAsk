

#import <UIKit/UIKit.h>

@interface UIImage (ImageOperate)

/**
 * 360度旋转Image
 **/
+ (UIImage *)imageWithRotate:(UIImage *)image Radius:(float)radius;


//zou 图片压缩至指定大小
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;



@end
