

#import "CellPersonInfoTemp.h"

@implementation CellPersonInfoTemp

+ (CellPersonInfoTemp *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identi = @"identiCellPersonInfoTemp";
    CellPersonInfoTemp *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CellPersonInfoTemp" owner:nil options:nil] lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

@end
