
#import "CellDoctorList.h"

@implementation CellDoctorList

+ (CellDoctorList *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identi = @"identiCellDoctorList";
    CellDoctorList *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CellDoctorList" owner:nil options:nil] lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

@end
