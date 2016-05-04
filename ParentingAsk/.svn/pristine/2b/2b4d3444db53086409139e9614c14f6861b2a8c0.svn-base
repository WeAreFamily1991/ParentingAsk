
//
//  网络请求

#import <Foundation/Foundation.h>
#import "User.h"
//zou
#import "EMChatManagerDefs.h"

typedef void (^RequestSuccessBlock)(id obj);
typedef void (^RequestFailBlock)(NSString *errorMsg);

@protocol HTTPRequestDelegate <NSObject>

- (void)httpImageDelegateWithImage:(UIImage *)imageChoosed Path:(NSString *)imagePath;

@end

@interface HTTPRequest : NSObject

@property (nonatomic, copy) NSString *sessionID;
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, copy) NSString *currentBaseVC;

+ (HTTPRequest *)shareRequest;

+ (void)httpWithGet:(NSString *)method
              Param:(NSDictionary *)param
            Success:(RequestSuccessBlock)success
               Fail:(RequestFailBlock)fail;

- (void)httpWithPost:(NSString *)method
               Param:(NSDictionary *)param
             Success:(RequestSuccessBlock)success
                Fail:(RequestFailBlock)fail;

+ (void)httpWithPost:(NSString *)method
               Param:(NSDictionary *)param
             Success:(RequestSuccessBlock)success
                Fail:(RequestFailBlock)fail;

+ (void)httpWithUploadPhoto:(NSData *)imageData Success:(RequestSuccessBlock)success Fail:(RequestFailBlock)fail;

//zou 上传多媒体文件至服务器
+ (void)httpWithUploadMedia:(id)mediaData Param:(NSDictionary *) param Type:(MessageBodyType)type Success:(RequestSuccessBlock)success Fail:(RequestFailBlock)fail;


@end
