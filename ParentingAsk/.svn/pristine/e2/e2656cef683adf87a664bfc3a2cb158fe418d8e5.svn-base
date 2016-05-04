

#import <UIKit/UIKit.h>

@interface UIViewController (VCPopUp)

@property (nonatomic, readwrite) UIViewController *popupViewController;
@property (nonatomic, readwrite) BOOL useBlurForPopup;

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
- (void)dismissPopupViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;


- (void)presentPopupTopViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
- (void)dismissPopupTopViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;

- (void)setUseBlurForPopup:(BOOL)useBlurForPopup;
- (BOOL)useBlurForPopup;
- (void)blurDismiss;

@end
