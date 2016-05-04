//
//  MyModel.h
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/22.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject
@property (nonatomic,strong)NSString *nameInfo,*titleInfo,*timeInfo,*headUrlInfo;
+ (id)userInfoWithDic:(NSDictionary *)aDic;
@end
