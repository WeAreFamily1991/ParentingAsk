//
//  NSObject+PA.m
//  ParentingAsk
//
//  Created by Travel Chu on 15/9/25.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "NSObject+PA.h"
#import "Config.h"
#import "AppDelegate.h"

@implementation NSObject (PA)
-(void)requestMessagesDone:(void (^)(id obj))done withMessageType:(ConnectsType)connectsType{
    NSString *method;
    NSDictionary *dicParame;
    switch (connectsType) {
        case ConnectsWaiting:
        {
            method = @"/order/unserver";
            dicParame = @{};
        }
            break;
        case ConnectsAcceptOrder:
        {
            method = @"/cus/servering";
            dicParame = @{};
        }
            break;
        case ConnectsTransfer:
        {
            method = @"/cus/forwarding";
            dicParame = @{};
        }
            break;
        default:
            break;
    }

    MBShow
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [HTTPRequest httpWithPost:method Param:dicParame Success:^(id obj) {
            if (SUCCESS) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (done) {
                        done(obj);
                    }
                    MBHide
                });
            }
        } Fail:^(NSString *errorMsg) {
            dispatch_async(dispatch_get_main_queue(), ^{
                MBHide
                MBE_Sys

            });
        }];

    });
}

-(void)saveUnreadMessage:(NSString*)msg{
    NSArray *array=[msg componentsSeparatedByString:@":"];
    if (![AppDelegate shareAppDelegate].unreadDict) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey]) {
            [AppDelegate shareAppDelegate].unreadDict=[[[NSUserDefaults standardUserDefaults] objectForKey:kUnReadDictKey] mutableCopy];
        }else{
            [AppDelegate shareAppDelegate].unreadDict=[NSMutableDictionary dictionary];
        }
    }
    if (array.count>=2) {
        NSString *key=array[0];
        if ([AppDelegate shareAppDelegate].contactNames.count)
        {
            if ([[AppDelegate shareAppDelegate].contactNames containsObject:key])
            {
                [AppDelegate shareAppDelegate].unreadDict[key]=@([[AppDelegate shareAppDelegate].unreadDict[key] integerValue]+1);
            }
            else
            {
                if ([AppDelegate shareAppDelegate].unreadDict[key]) {
                    [[AppDelegate shareAppDelegate].unreadDict removeObjectForKey:key];
                }
            }
        }
    }
    
    NSString *key=array[0];
    if ([AppDelegate shareAppDelegate].messageNames.count)
    {
        if ([[AppDelegate shareAppDelegate].messageNames containsObject:key]) {
            [AppDelegate shareAppDelegate].unreadDict[key]=@([[AppDelegate shareAppDelegate].unreadDict[key] integerValue]+1);
        }else{
            if ([AppDelegate shareAppDelegate].unreadDict[key]) {
                [[AppDelegate shareAppDelegate].unreadDict removeObjectForKey:key];
            }
        }
    }

    if (array.count>=2)
    {
           }

    if (array.count>=2) {
        NSString *key=array[0];
        if ([AppDelegate shareAppDelegate].GrabNames.count) {
            if ([[AppDelegate shareAppDelegate].GrabNames containsObject:key]) {
                [AppDelegate shareAppDelegate].unreadDict[key]=@([[AppDelegate shareAppDelegate].unreadDict[key] integerValue]+1);
            }else{
                if ([AppDelegate shareAppDelegate].unreadDict[key]) {
                    [[AppDelegate shareAppDelegate].unreadDict removeObjectForKey:key];
                }
            }
        }
    }
    [self saveUnreadMessageToSandBox];
}
-(void)saveUnreadMessageToSandBox{
    if (![AppDelegate shareAppDelegate].unreadDict) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[AppDelegate shareAppDelegate].unreadDict forKey:kUnReadDictKey];
    NSLog(@"[AppDelegate shareAppDelegate].unreadDict=%@",[AppDelegate shareAppDelegate].unreadDict);
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end