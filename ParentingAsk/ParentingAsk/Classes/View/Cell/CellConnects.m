
#import "CellConnects.h"

@implementation CellConnects

+ (CellConnects *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identi = @"identiCellConnects";
    CellConnects *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CellConnects" owner:nil options:nil] lastObject];
    }
    [cell.imageIcon.layer setCornerRadius:22.0];
    [cell.imageIcon setClipsToBounds:YES];
    
    [cell.labCount.layer setCornerRadius:12.5];
    [cell.labCount setClipsToBounds:YES];
    
    return cell;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGRect labRect = CGRectMake(10, 10, 10, 10);
    UIGraphicsBeginImageContextWithOptions(labRect.size, YES, 0);
    
    
    [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1] set];
}



@end
