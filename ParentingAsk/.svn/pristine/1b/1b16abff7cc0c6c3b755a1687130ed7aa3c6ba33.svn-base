
#import "CellChatMore.h"

@implementation CellChatMore

+ (CellChatMore *)cellWithTableView:(UITableView *)tableView
{
    static NSString *strIdenti = @"identiCellChatMore";
    CellChatMore *cell = [tableView dequeueReusableCellWithIdentifier:strIdenti];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CellChatMore" owner:nil options:nil] lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

@end
