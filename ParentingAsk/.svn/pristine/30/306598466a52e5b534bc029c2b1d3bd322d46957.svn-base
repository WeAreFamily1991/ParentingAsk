

#import "CellStar.h"

#define kDistance  10.0

@implementation CellStar

+ (CellStar *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identi = @"identiCellStar";
    CellStar *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[CellStar alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
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
    self.viewStar = [[UIView alloc] initWithFrame:CGRectMake(titleW, 5, (ScreenWidth - titleW), 34)];
    for (int k = 0; k < 5; k ++) {
        UIImageView *imageStar = [[UIImageView alloc] init];
        titleW = k * 30;
        if (k > 0) {
            titleW += kDistance * k;
        }
        [imageStar setFrame:CGRectMake(titleW, 8, 25, 25)];
        [imageStar setImage:[UIImage imageWithFile:@"icon-doctor-step.png"]];
        [imageStar setUserInteractionEnabled:NO];
        [self.viewStar addSubview:imageStar];
    }
    
    [self.viewStar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickStar:)]];
    [self.viewStar addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(clickStar:)]];
    [self.contentView addSubview:self.viewStar];
}

- (void)clickStar:(UIGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:sender.view];
    if (point.x > 0) {
        NSInteger count = point.x /(30 + kDistance);
        count += 1;
        if (count > 5) {
            count = 5;
        }
        if (self.CellStarClickBlock) {
            self.CellStarClickBlock(count);
        }
        NSLog(@"return data: pointX: %f, count: %zd", point.x, count);
    }
}

@end
