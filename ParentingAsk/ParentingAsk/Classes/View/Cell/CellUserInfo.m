

#import "CellUserInfo.h"

@implementation CellUserInfo

+ (CellUserInfo *)cellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    NSString *identi = [NSString stringWithFormat:@"identiUserInfo%zd", indexPath.row + 1];
    CellUserInfo *cell = [tableView dequeueReusableCellWithIdentifier:identi forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell.imageAvatar.layer setCornerRadius:45.0 / 2];
    [cell.imageAvatar setClipsToBounds:YES];
    
    return cell;
}

@end
