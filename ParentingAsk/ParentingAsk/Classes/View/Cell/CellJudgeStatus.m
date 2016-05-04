
#import "CellJudgeStatus.h"
#define kWidth  60.0

@implementation CellJudgeStatus
{
    UIView *_viewJudge;
    UIButton *_btnChoosed;
}
+ (CellJudgeStatus *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identi = @"identiCellJudgeStatus";
    CellJudgeStatus *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[CellJudgeStatus alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutCell];
    }
    return self;
}

- (void)layoutCell
{
    self.labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 80, 24)];
    [self.labTitle setFont:[UIFont systemFontOfSize:16.0]];
    [self.labTitle setTextAlignment:NSTextAlignmentLeft];
    [self.labTitle setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:self.labTitle];
    
    CGFloat titleW = self.labTitle.frame.size.width + self.labTitle.frame.origin.x;
    _viewJudge = [[UIView alloc] initWithFrame:CGRectMake(titleW, 10, 3 * kWidth, 28)];
    [_viewJudge.layer setCornerRadius:8.0f];
    [_viewJudge.layer setBorderWidth:0.8f];
    [_viewJudge.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    for (int k = 0; k < 3; k ++) {
        UIButton *btnJudge = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnJudge setFrame:CGRectMake(k * kWidth, 0, kWidth, 30)];
        [btnJudge setTag:(k + 1)];
        [btnJudge addTarget:self action:@selector(clickJudge:) forControlEvents:UIControlEventTouchUpInside];
        [btnJudge setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btnJudge.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_viewJudge addSubview:btnJudge];
        switch (k) {
            case 0:
            {
                [btnJudge setTitle:@"好评" forState:UIControlStateNormal];
                [btnJudge setBackgroundImage:[UIImage imageWithFile:@"icon-doctor-category.png"] forState:UIControlStateNormal];
                _btnChoosed = btnJudge;
            }
                break;
            case 1:
                [btnJudge setTitle:@"中评" forState:UIControlStateNormal];
                break;
            case 2:
                [btnJudge setTitle:@"差评" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
    [self.contentView addSubview:_viewJudge];
}

- (void)clickJudge:(UIButton *)sender
{
    if (sender != _btnChoosed) {
        [_btnChoosed setBackgroundImage:nil forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageWithFile:@"icon-doctor-category.png"] forState:UIControlStateNormal];
        _btnChoosed = sender;
        
        if (self.CellJudgeStatus) {
            self.CellJudgeStatus(sender.tag);
        }
    }
}

@end
