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

#import "BaseVC.h"
#import "EMChatManagerDefs.h"

@class User;

@protocol ChatViewControllerDelegate <NSObject>

- (NSString *)avatarWithChatter:(NSString *)chatter;
- (NSString *)nickNameWithChatter:(NSString *)chatter;

@end

@interface ChatViewController : BaseVC

@property (strong, nonatomic, readonly) NSString *chatter;
@property (nonatomic) BOOL isInvisible;
@property (nonatomic, assign) id <ChatViewControllerDelegate> delelgate;
@property (nonatomic, copy) NSString *strDesc;
@property (nonatomic, copy) NSString *strTopTitle;
@property (nonatomic, copy) void (^ChatVCBackBlock)();
@property (nonatomic, strong) User *userDisease;

- (instancetype)initWithChatter:(NSString *)chatter isGroup:(BOOL)isGroup;
- (instancetype)initWithChatter:(NSString *)chatter conversationType:(EMConversationType)type;


- (void)reloadData;

- (void)hideImagePicker;

@end
