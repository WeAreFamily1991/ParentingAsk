//
//  YasinCustomLineView.m
//  Allure
//
//  Created by 伍鑫 on 16/3/17.
//  Copyright © 2016年 伍鑫. All rights reserved.
//

#import "YasinCustomLineView.h"

@implementation YasinCustomLineView

- (void)awakeFromNib {
    NSArray *constraints = self.constraints;
    __block NSLayoutConstraint *w;
    __block NSLayoutConstraint *h;
    
    [constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if (constraint.firstItem == self) {
            if (constraint.firstAttribute == NSLayoutAttributeWidth) {
                w = constraint;
            }else if (constraint.firstAttribute == NSLayoutAttributeHeight){
                h = constraint;
            }
        }
    }];
    
    if (w.constant == 1) {
        w.constant = 0.7;
    }
    if (h.constant == 1) {
        h.constant = 0.7;
    }
    
    self.backgroundColor = [UIColor colorWithRed:0.698f green:0.698f blue:0.698f alpha:1.00f];
}

@end
