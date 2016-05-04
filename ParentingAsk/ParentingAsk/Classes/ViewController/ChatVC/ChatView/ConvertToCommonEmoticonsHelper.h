/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import <Foundation/Foundation.h>

@interface ConvertToCommonEmoticonsHelper : NSObject
+ (NSString *)convertToCommonEmoticons:(NSString *)text;
+ (NSString *)convertToSystemEmoticons:(NSString *)text;
//zou 2015-12-10 环信表情转换为微信表情
+ (NSString *)convertToWebChatEmoticons:(NSString *)text;
//zou 2015-12-10 微信表情转换为环信表情
+ (NSString *)convertHuanXinEmoticons:(NSString *)text;
@end
