//
//  ChangeCell.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/4/13.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "ChangeCell.h"

@implementation ChangeCell

+ (ChangeCell *)cellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    NSString *strIdenti = [NSString stringWithFormat:@"identiCellEditPassword%ld", (long)indexPath.row + 1];
    ChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdenti forIndexPath:indexPath];
    
    return cell;
}

@end
