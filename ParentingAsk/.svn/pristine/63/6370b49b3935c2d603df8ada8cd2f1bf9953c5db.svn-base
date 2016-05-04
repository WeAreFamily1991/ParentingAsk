

#import <UIKit/UIKit.h>

@interface CellStar : UITableViewCell

@property (nonatomic, strong) UILabel *labTitle;

/**
 * 标注星星的view，根据不同位置点击获取选中星星个数
 **/
@property (nonatomic, strong) UIView *viewStar;

+ (CellStar *)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) void (^CellStarClickBlock)(NSInteger starCount);

@end
