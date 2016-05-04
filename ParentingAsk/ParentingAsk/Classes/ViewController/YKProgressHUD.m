/**
 *  YKProgressHUD.m
 *  Version 0.4
 *
 *  视图控制器基类
 *
 *  Created by Matej Bukovinski on 2.4.09.
 */

#import "YKProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

@implementation YKProgressHUD
@synthesize m_activityIndicator;
@synthesize m_textLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
	{
		self.backgroundColor = [UIColor clearColor];
		
		UIView* bgvi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100.f, 100.f)];
        bgvi.layer.cornerRadius = 10.0f;
        bgvi.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.8f];
		[self addSubview:bgvi];
		bgvi.userInteractionEnabled = NO;
		bgvi.center = self.center;
		
        m_textLabel = [[UILabel alloc] initWithFrame:CGRectMake( 15.f, 62.f, 70.f, 20.f)];
        m_textLabel.backgroundColor = [UIColor clearColor];
        m_textLabel.textColor       = [UIColor whiteColor];
        m_textLabel.textAlignment   =  NSTextAlignmentCenter;
        [bgvi addSubview:m_textLabel];
		m_textLabel.userInteractionEnabled = NO;
		
        m_activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        m_activityIndicator.frame = CGRectMake( 25.f, 12.f, 50.f, 50.f);
        [bgvi addSubview:m_activityIndicator];
		
		m_activityIndicator.userInteractionEnabled = NO;
    }
    return self;
}

- (void)show{
    [m_activityIndicator startAnimating];
}

- (void)hide{
    [self removeFromSuperview];
}

+ (YKProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withText:(NSString*)message
{
	return [self showHUDAddedTo:view animated:animated withText:message interactionEnable:YES];
}

+ (YKProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withText:(NSString*)message HUDCenter:(CGPoint)aCenter
{
   return [self showHUDAddedTo:view animated:animated withText:message interactionEnable:YES HUDCenter:aCenter];
}

+ (YKProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withText:(NSString*)message interactionEnable:(BOOL)model
{
    return [self showHUDAddedTo:view animated:animated withText:message interactionEnable:model HUDCenter:view.center];
}

+ (YKProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withText:(NSString*)message interactionEnable:(BOOL)model HUDCenter:(CGPoint)aCenter
{
	if( view == nil ){
		return nil;
	}
	
	for (UIView *v in [view subviews]) {
		if ([v isKindOfClass:[YKProgressHUD class]]) {
			[v removeFromSuperview];
		}
	}
	
	YKProgressHUD *hud = [[self alloc] initWithFrame:view.bounds];
	hud.center = aCenter;
    
	hud.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
	hud.m_textLabel.font = [UIFont systemFontOfSize:14];
	hud.m_textLabel.text = message;
	[view addSubview:hud];
	[hud show];
	
	hud.userInteractionEnabled = !model;
	return hud;
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated 
{
	UIView *viewToRemove = nil;
	for (UIView *v in [view subviews]) {
		if ([v isKindOfClass:self]) {
			viewToRemove = v;
		}
	}
	if (viewToRemove != nil) {
		YKProgressHUD *HUD = (YKProgressHUD *)viewToRemove;
		[HUD hide];
		return YES;
	}
    else {
		return NO;
	}
}

@end