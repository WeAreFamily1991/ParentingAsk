//
//  UIScrollView+UITouch.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/4/28.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "UIScrollView+UITouch.h"

@implementation UIScrollView (UITouch)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

@end
