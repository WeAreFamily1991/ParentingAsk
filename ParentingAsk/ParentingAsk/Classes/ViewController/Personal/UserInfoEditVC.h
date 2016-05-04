
// 病人资料编辑

#import "BaseVC.h"
@class User;

@interface UserInfoEditVC : BaseVC

@property (nonatomic, strong) User *user;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) void (^UserInfoEditBlock)();

@end
