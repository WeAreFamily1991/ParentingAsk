//
//  TipsInfo.h
//  ParentingAsk
//
//  Created by zouzeng on 15/12/29.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TipsInfo : NSObject

@property(nonatomic,strong) NSArray *list;
@property(nonatomic,assign) int lastPage;
@property(nonatomic,assign) int pageSize;
@property(nonatomic,assign) int pageNumber;
@property(nonatomic,assign) int firstPage;
@property(nonatomic,assign) int totalRow;
@property(nonatomic,assign) int totalPage;

@end

@interface TipsInfoDetail : NSObject

@property(nonatomic,assign) long idNum;
@property(nonatomic,assign) long time;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *desc;
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong)NSString *imgage;
@property(nonatomic,assign) long stats;
@end