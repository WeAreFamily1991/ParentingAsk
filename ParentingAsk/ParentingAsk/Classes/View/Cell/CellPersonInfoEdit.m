

#import "CellPersonInfoEdit.h"

@implementation CellPersonInfoEdit

+ (CellPersonInfoEdit *)cellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    NSString *strIdenti = [NSString stringWithFormat:@"identiCellPersonInfoEdit%ld", (long)indexPath.row + 1];
    CellPersonInfoEdit *cell = [tableView dequeueReusableCellWithIdentifier:strIdenti forIndexPath:indexPath];
    
    if (indexPath.row==0)
    {
        cell.btnAvatar =[UIButton buttonWithType:UIButtonTypeCustom];
        cell.btnAvatar.frame = CGRectMake(85, 10, 30, 30);
        [cell.btnAvatar.layer setCornerRadius:15.0];
         [cell.btnAvatar setClipsToBounds:YES];
        [cell.contentView addSubview:cell.btnAvatar];
    }
    
   
    return cell;
}

@end
