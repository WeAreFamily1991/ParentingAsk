//
//  NSObject+PA.h
//  ParentingAsk
//
//  Created by Travel Chu on 15/9/25.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ConnectsWaiting,
    ConnectsAcceptOrder,
    ConnectsTransfer,
} ConnectsType;
@interface NSObject (PA)
-(void)requestMessagesDone:(void (^)(id obj))done withMessageType:(ConnectsType)connectsType;
-(void)saveUnreadMessage:(NSString*)msg;
-(void)saveUnreadMessageToSandBox;
@end
