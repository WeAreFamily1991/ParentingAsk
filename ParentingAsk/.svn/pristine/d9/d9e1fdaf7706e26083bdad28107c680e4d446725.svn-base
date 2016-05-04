

#import "BaseVC.h"

@protocol PopUpVCDeleagte <NSObject>

/**
 * 0 邀请评价
 * 1 转接给其他医生
 * 2 退回
 * 3 隐藏view
 **/
- (void)popUpClickIndex:(NSInteger)index;

@end

@interface PopUpVC : BaseVC

@property (nonatomic, weak) id<PopUpVCDeleagte> delegate;

@end
