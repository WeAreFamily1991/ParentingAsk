
#import <UIKit/UIKit.h>

@interface CellEditPassword : UITableViewCell

@property (nonatomic, weak) IBOutlet UITextField *textDesc;

+ (CellEditPassword *)cellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;

@end
