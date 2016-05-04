

#import "CellPersonal.h"

@implementation CellPersonal

+ (CellPersonal *)cellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    NSString *identi = [NSString stringWithFormat:@"identiPersonal%zd", indexPath.row + 1];
    CellPersonal *cell = [tableView dequeueReusableCellWithIdentifier:identi forIndexPath:indexPath];
    [cell setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.05]];
    
    [cell.btnSave.layer setCornerRadius:8.0f];
    [cell.btnSave setClipsToBounds:YES];
    [cell.imageBg setBackgroundColor:[UIColor whiteColor]];
    
    return cell;
}

@end
