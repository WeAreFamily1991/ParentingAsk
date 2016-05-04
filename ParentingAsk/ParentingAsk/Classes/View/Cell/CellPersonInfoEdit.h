

#import <UIKit/UIKit.h>

@interface CellPersonInfoEdit : UITableViewCell

@property (nonatomic, strong)UIButton *btnAvatar;

@property (nonatomic, weak) IBOutlet UITextField *textDesc;

@property (nonatomic, weak) IBOutlet UITextView *textViewDesc;

@property (nonatomic, weak) IBOutlet UIButton *btnChooseCity;

+ (CellPersonInfoEdit *)cellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;

@end
