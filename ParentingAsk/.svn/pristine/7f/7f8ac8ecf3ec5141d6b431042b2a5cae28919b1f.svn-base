

#import "CellPopUp.h"

@implementation CellPopUp

+ (CellPopUp *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identi = @"identiCellPopUp";
    CellPopUp *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CellPopUp" owner:nil options:nil] lastObject];
    }
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

@end
