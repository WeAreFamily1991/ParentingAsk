

#import <UIKit/UIKit.h>

@interface CellPersonInfoTemp : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *labTitle;
@property (nonatomic, weak) IBOutlet UITextField *textDesc;

+ (CellPersonInfoTemp *)cellWithTableView:(UITableView *)tableView;

@end
