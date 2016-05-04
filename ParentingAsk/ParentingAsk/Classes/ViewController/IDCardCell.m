//
//  IDCardCell.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/20.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "IDCardCell.h"

@implementation IDCardCell

+ (IDCardCell *)cellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    NSString *strIdenti = [NSString stringWithFormat:@"identiCellEditPassword%ld", (long)indexPath.row + 1];
    IDCardCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdenti forIndexPath:indexPath];
    
    return cell;
}

@end
