//
//  CellFrame.m
//  动态cell
//
//  Created by mac on 16/3/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CellFrame.h"
#import "ArrowItem.h"
#import "MapItem.h"
#import "TallyItem.h"
#import <UIKit/UIKit.h>

@implementation CellFrame


-(void)setItemData:(Item *)itemData
{
    _itemData = itemData;
    
    if ([itemData isKindOfClass:[MapItem class]])
    {
        _CellH = 100;
    }else if ([itemData isKindOfClass:[TallyItem class]])
    {
        _CellH = 100;
    }else
    {
        //预设宽高
        CGSize textSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT);
        //定义字体 必须和前面一致
        NSDictionary *attrDic = @{NSFontAttributeName :[UIFont systemFontOfSize:13]};
        //计算出实际的宽高
        CGSize size = [itemData.title boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDic context:nil].size ;
        _CellH = size.height +20;
    }
    

}


@end
