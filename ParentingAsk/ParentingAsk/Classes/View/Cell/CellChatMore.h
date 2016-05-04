

#import <UIKit/UIKit.h>

@interface CellChatMore : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *labTitle;
@property (nonatomic, weak) IBOutlet UIImageView *imageCheck;

+ (CellChatMore *)cellWithTableView:(UITableView *)tableView;

@end
