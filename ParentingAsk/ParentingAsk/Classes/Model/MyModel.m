//
//  MyModel.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/22.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "MyModel.h"

@implementation MyModel
- (id)initWithDic:(NSDictionary *)aDic
{


    self.nameInfo = aDic[@"message"][@"nickname"];
    self.timeInfo =aDic[@"time"];
    self.titleInfo = aDic[@"desc"];
    self.headUrlInfo = aDic[@"headurl"];
    

return self;
}

+ (id)userInfoWithDic:(NSDictionary *)aDic

{
    
    return [[self alloc] initWithDic:aDic] ;
  
}
@end
