

#import <UIKit/UIKit.h>

@interface CellJudgeStatus : UITableViewCell

@property (nonatomic, strong) UILabel *labTitle;
/**
 评价状态
 * @param 1 好评
 * @param 2 中评
 * @param 3 差评
 **/
@property (nonatomic, copy) void (^CellJudgeStatus)(NSInteger judgeStatus);

+ (CellJudgeStatus *)cellWithTableView:(UITableView *)tableView;

@end
