

#import "UINavigationItem+ItemCustom.h"

@implementation UINavigationItem (ItemCustom)

- (void)navigationBackWithDelegate:(id)delegate Action:(SEL)action
{
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 12, 20, 20)];
    [btnBack setImage:[UIImage imageWithFile:@"back@2x.png"] forState:UIControlStateNormal];
    [btnBack addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
}

//- (void)navigationLeftWithTitle:(NSString *)title Img:(UISegmentedControl *)img Delegate:(id)delegate Action:(SEL)action
//{
//    
//    
//    UISegmentedControl *segmentedControl = [ [ UISegmentedControl alloc ]
//                                            initWithItems: nil ];
//    segmentedControl.segmentedControlStyle =
//    UISegmentedControlStyleBar;
//    [ segmentedControl insertSegmentWithTitle:
//     @"All" atIndex: 0 animated: NO ];
//    [ segmentedControl insertSegmentWithTitle:
//     @"Missed" atIndex: 1 animated: NO ];
//
////    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
////    [btnRight setBackgroundImage:img forState:UIControlStateNormal];
////    [btnRight setTitle:title forState:UIControlStateNormal];
////    [btnRight addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
////    [btnRight.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
////    
////    if (title.length > 0) {
////        CGFloat titleW = [NSString stringReturnSizeWithText:title Size:CGSizeMake(0, 30) FontSize:15.0].width;
////        [btnRight setFrame:CGRectMake(0, 0, titleW, 30.0)];
////    }
//    
//    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
//}

- (void)navigationRightWithTitle:(NSString *)title Img:(UIImage *)img Delegate:(id)delegate Action:(SEL)action IsHeader:(BOOL)isHeader
{
    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btnRight setTitleColor:SystemGrayColor forState:UIControlStateNormal];
    [btnRight setBackgroundImage:img forState:UIControlStateNormal];
    [btnRight setTitle:title forState:UIControlStateNormal];
    [btnRight addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    [btnRight.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    
    if (isHeader) {
        [btnRight setFrame:CGRectMake(0, 0, 40, 40)];
        [btnRight.layer setCornerRadius:20];
        [btnRight setClipsToBounds:YES];
        
        NSURL *imgUrl = [NSURL URLWithString:[HTTPRequest shareRequest].currentUser.headurl];
        [btnRight sd_setImageWithURL:imgUrl forState:UIControlStateNormal placeholderImage:img];
    }
    
    if (title.length > 0) {
        CGFloat titleW = [NSString stringReturnSizeWithText:title Size:CGSizeMake(0, 40) FontSize:15.0].width;
        [btnRight setFrame:CGRectMake(0, 0, titleW, 40.0)];
    }
    
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
}

@end
