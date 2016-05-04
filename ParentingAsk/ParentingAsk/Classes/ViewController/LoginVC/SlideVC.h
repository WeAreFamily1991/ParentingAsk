
// 页面左右切换

#import "BaseVC.h"
#import "MessageVC.h"
#import "ConnectsVC.h"
#import "WaitingVC.h"
#import "TipsTVC.h"
#import "PersonCenterViewController.h"
@protocol SlideVCDelegate <NSObject>

- (void)slideSwitch:(NSInteger)switchIndex;

@end

@interface SlideVC : UIViewController
@property(nonatomic,strong)WaitingVC *waithVC;
@property (nonatomic, strong) MessageVC *messageVC;
@property (nonatomic, strong) ConnectsVC *connectsVC;
@property(nonatomic,strong)TipsTVC *tipVC;
@property (nonatomic, strong) PersonCenterViewController *pesonVC;
@property (nonatomic, strong) UINavigationController *navigationCurrent;
@property (nonatomic, weak) id <SlideVCDelegate> delegate;

- (void)slideIndex:(NSInteger)index;

@end
