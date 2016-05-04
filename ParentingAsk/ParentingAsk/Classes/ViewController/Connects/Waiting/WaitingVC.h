
//  订单列表页

#import "BaseTVC.h"
#import "ConnectsVC.h"
#import <UIKit/UIKit.h>
#import "Msg_Waiting.h"

@interface WaitingVC : BaseTVC
@property (nonatomic, strong) UINavigationController *navigationCurrent;
@property (nonatomic, assign) ConnectsType connectsType;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, copy) void (^WaitingVCBackBlock)();
@property (nonatomic, strong) Msg_Waiting *msg_waiting;
@property(nonatomic,assign)NSInteger waitingCount;
@end
