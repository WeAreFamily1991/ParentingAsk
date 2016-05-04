

#import "SlideVC.h"
#import "SlideSwitchView.h"

@interface SlideVC ()<SlideSwitchViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation SlideVC
{
    SlideSwitchView *_slideSwitchView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _slideSwitchView = [[SlideSwitchView alloc] initWithFrame:CGRectMake(0, -44, ScreenWidth, (ScreenHeight - 20))];
    [_slideSwitchView setSlideSwitchViewDelegate:self];
    [self.view addSubview:_slideSwitchView];
    //抢单界面
//    
//    _waithVC = [[WaitingVC alloc]init];
//    [_waithVC setNavigationCurrent:self.navigationCurrent];
    //联系人页面
    _messageVC = [[MessageVC alloc] init];
    [_messageVC setNavigationCurrent:self.navigationCurrent];
    //消息页面
    _connectsVC = [[ConnectsVC alloc] init];
    [_connectsVC setNavigationCurrent:self.navigationCurrent];
    
    [_slideSwitchView buildUI];
}

- (NSUInteger)numberOfTab:(SlideSwitchView *)view
{
    return 2;
}
#pragma mark 控制消息和联系人界面之间的跳转
- (UIViewController *)slideSwitchView:(SlideSwitchView *)view ViewOfTab:(NSUInteger)number
{
    if (number == 0)
    {
        return _connectsVC;
    }
    return _messageVC;
}

- (void)slideSwitchDirection:(NSInteger)direction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideSwitch:)]) {
        [self.delegate slideSwitch:direction];
    }
    
    if (direction == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SlideSwitchLeft" object:nil];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SlideSwitchRight" object:nil];
    }
}

- (void)slideIndex:(NSInteger)index
{
    if (index == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SlideSwitchLeft" object:nil];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SlideSwitchRight" object:nil];
    }
    
    [_slideSwitchView.rootScrollView setContentOffset:CGPointMake((index * ScreenWidth), 0) animated:YES];
}

@end
