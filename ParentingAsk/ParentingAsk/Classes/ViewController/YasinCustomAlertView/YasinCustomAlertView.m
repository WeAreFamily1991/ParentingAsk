//
//  YasinCustomAlertView.m
//  Allure
//
//  Created by 伍鑫 on 16/3/17.
//  Copyright © 2016年 伍鑫. All rights reserved.
//

#import "YasinCustomAlertView.h"
#import "YasinCustomLineView.h"

#define Bound_Width  [[UIScreen mainScreen] bounds].size.width
#define Bound_Height [[UIScreen mainScreen] bounds].size.height
#define Window_      [[UIApplication sharedApplication].delegate window]

@interface YasinCustomAlertView()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *determineButton;
@property (weak, nonatomic) IBOutlet UIButton *determineButton2;
@property (weak, nonatomic) IBOutlet YasinCustomLineView *topLine;
@property (weak, nonatomic) IBOutlet YasinCustomLineView *bottomLine;
@property (weak, nonatomic) IBOutlet YasinCustomLineView *bottomCenterLine;

@property (nonatomic, strong) UIView *backView;
@end

@implementation YasinCustomAlertView

+ (YasinCustomAlertView *)sharedCustomAlertView{
    static YasinCustomAlertView *customAlertView = nil;
    static dispatch_once_t alertView;
    dispatch_once(&alertView, ^{
        customAlertView = [[[NSBundle mainBundle] loadNibNamed:@"YasinCustomAlertView" owner:self options:nil] lastObject];
    });
    return customAlertView;
}

+ (void)showTitle:(NSString *)title Message
                 :(NSString *)message DetermineButtonTitle
                 :(NSString *)determineTitle CancelButtonTitle
                 :(NSString *)cancelTitle DetermineBlock
                 :(DetermineBlock)determine CancelBlock
                 :(CancelBlock)cancel{
    
    [[YasinCustomAlertView sharedCustomAlertView] showTitle:title Message:message DetermineButtonTitle:determineTitle CancelButtonTitle:cancelTitle DetermineBlock:determine CancelBlock:cancel];
}

+ (void)showTitle:(NSString *)title Message
                 :(NSString *)message DetermineButtonTitle
                 :(NSString *)determineTitle DetermineBlock
                 :(DetermineBlock)determine{
    
    [[YasinCustomAlertView sharedCustomAlertView] showTitle:title Message:message DetermineButtonTitle:determineTitle DetermineBlock:determine];
}

- (void)showTitle:(NSString *)title Message
                 :(NSString *)message DetermineButtonTitle
                 :(NSString *)determineTitle CancelButtonTitle
                 :(NSString *)cancelTitle DetermineBlock
                 :(DetermineBlock)determine CancelBlock
                 :(CancelBlock)cancel{
    
    [self loadUI];
    
    self.cancelButton.hidden     = NO;
    self.determineButton.hidden  = NO;
    self.determineButton2.hidden = YES;
    self.bottomCenterLine.hidden = NO;
    
    self.title.text   = title;
    self.message.text = message;
    
    [self.determineButton setTitle:determineTitle forState:UIControlStateNormal];
    [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    
    self.determineBlock = determine;
    self.cancelBlock = cancel;
    
    [self setViewHeight];
    
}

- (void)showTitle:(NSString *)title Message
                 :(NSString *)message DetermineButtonTitle
                 :(NSString *)determineTitle DetermineBlock
                 :(DetermineBlock)determine{
    
    [self loadUI];
    
    self.cancelButton.hidden     = YES;
    self.determineButton.hidden  = YES;
    self.determineButton2.hidden = NO;
    self.bottomCenterLine.hidden = YES;
    
    self.title.text   = title;
    self.message.text = message;
    
     [self.determineButton2 setTitle:determineTitle forState:UIControlStateNormal];
    
    self.determineBlock = determine;
    
    [self setViewHeight];
    
}

- (void)loadUI{
    [self.backView removeFromSuperview];
    [self removeFromSuperview];
    self.backView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Bound_Width, Bound_Height)];
    self.backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [Window_ addSubview:self.backView];

    self.frame               = CGRectMake(Bound_Width/2-250/2, -150, 250, 150);
    self.backgroundColor     = [UIColor colorWithRed:0.976f green:0.976f blue:0.976f alpha:0.95f];
    self.layer.cornerRadius  = 10.0;
    self.layer.borderWidth   = 0.6;
    self.layer.borderColor   = [UIColor colorWithRed:0.698f green:0.698f blue:0.698f alpha:1.00f].CGColor;
    [Window_ addSubview:self];
    
    self.message.numberOfLines   = 0;
    self.determineButton2.hidden = YES;
    
    //移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    [self addGestureRecognizer:panGestureRecognizer];

}

- (void)showView{
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.center = Window_.center;
    } completion:^(BOOL finished) {
    }];
}

- (void)setViewHeight{
    CGSize size = [self.message sizeThatFits:CGSizeMake(CGRectGetWidth(self.message.frame), MAXFLOAT)];
    
    if (size.height < 30) {
        size.height = 40;
    }
    
    CGRect frame = self.frame;
    frame.size.height = 80 + size.height + 20;
    self.frame = frame;
    
    [self showView];
}

- (void)handlePan:(UIPanGestureRecognizer *)pan{
    
    CGPoint translation = [pan translationInView:Window_];
    pan.view.center = CGPointMake(pan.view.center.x + translation.x,
                                  pan.view.center.y + translation.y);
    [pan setTranslation:CGPointZero inView:Window_];
    
    CGRect frame = pan.view.frame;
    if (pan.view.frame.origin.x < 0) {
        frame.origin.x = 0;
    }
    if (pan.view.frame.origin.x > Bound_Width - pan.view.frame.size.width) {
        frame.origin.x = Bound_Width - pan.view.frame.size.width;
    }
    if (pan.view.frame.origin.y < 20) {
        frame.origin.y = 20;
    }
    if (pan.view.frame.origin.y > Bound_Height - pan.view.frame.size.height) {
        frame.origin.y = Bound_Height - pan.view.frame.size.height;
    }
    pan.view.frame = frame;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self showView];
    }
}

- (IBAction)clickCancel:(id)sender {
    [self dismiss];
    if (self.cancelBlock != nil) {
        self.cancelBlock();
    }
}

- (IBAction)clickDetermineButton:(id)sender {
    [self dismiss];
    if (self.determineBlock != nil) {
        self.determineBlock();
    }
}

- (IBAction)clickDetermineButton2:(id)sender {
    [self dismiss];
    if (self.determineBlock != nil) {
        self.determineBlock();
    }
}

- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = Bound_Height;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
