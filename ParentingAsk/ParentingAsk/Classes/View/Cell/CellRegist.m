

#import "CellRegist.h"

@implementation CellRegist

+ (CellRegist *)cellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    NSString *strIdenti = [NSString stringWithFormat:@"identiCellRegist%zd", (indexPath.row + 1)];
    CellRegist *cell = [tableView dequeueReusableCellWithIdentifier:strIdenti forIndexPath:indexPath];
    if (cell==nil)
    {
        cell = [[CellRegist alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strIdenti];
    }
    [cell.textDesc.layer setCornerRadius:4.0];
    [cell.textDesc.layer setBorderWidth:0.5f];
    [cell.textDesc.layer setBorderColor:[UIColor whiteColor].CGColor];
   
    [cell.btnSubmit.layer setCornerRadius:4.0];
    [cell.btnGetCode.layer setCornerRadius:4.0];
    [cell.btnCamera.layer setCornerRadius:(85.0 * 0.5)];
    [cell.btnCamera setClipsToBounds:YES];
    
    [cell.btnGetCode setBackgroundColor:SystemGreenColor];
    [cell.btnSubmit setBackgroundColor:SystemGreenColor];
    
    UIView *viewRight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIButton *btton = [UIButton buttonWithType:UIButtonTypeCustom];
    btton.backgroundColor = [UIColor redColor];
    btton.frame = CGRectMake(10, 10, 20, 23);
    
    [btton setTitle:@"111" forState:UIControlStateNormal];
   
    [btton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [viewRight addSubview:btton];
    [cell.textDesc setLeftView:viewRight];
    
    UILabel *labTemp = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, 44)];
    [cell.textDesc setLeftView:labTemp];
    [cell.textDesc setLeftViewMode:UITextFieldViewModeAlways];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(void)btnClick
{
    self.textDesc.secureTextEntry = NO;
}


@end
