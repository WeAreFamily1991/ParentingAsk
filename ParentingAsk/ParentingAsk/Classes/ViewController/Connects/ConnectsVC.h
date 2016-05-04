

#import "BaseTVC.h"
#import <UIKit/UIKit.h>

@interface ConnectsVC : UITableViewController
@property (nonatomic, copy) void (^connectVCBackBlock)();
@property (nonatomic, strong) UINavigationController *navigationCurrent;
@property (nonatomic, assign) ConnectsType connectsType;
@property(nonatomic,assign) NSInteger waitingCount;
@end
