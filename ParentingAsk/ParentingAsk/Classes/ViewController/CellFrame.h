//
//  CellFrame.h
//  动态cell
//
//  Created by mac on 16/3/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Item.h"

@interface CellFrame : NSObject

@property (nonatomic, strong) Item *itemData;

@property (nonatomic, assign,readonly) CGFloat CellH;
@end
