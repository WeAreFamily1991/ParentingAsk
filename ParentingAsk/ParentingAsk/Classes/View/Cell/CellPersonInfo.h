

#import <UIKit/UIKit.h>

@interface CellPersonInfo : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageAvatar;

@property (nonatomic, weak) IBOutlet UILabel *labNickName;

@property (nonatomic, weak) IBOutlet UILabel *labUserName;

@property (nonatomic, weak) IBOutlet UILabel *labLevel;

@property (nonatomic, weak) IBOutlet UIButton *btnEdit;

@property (nonatomic, weak) IBOutlet UITextField *textDesc;

@property (nonatomic, strong) UITextView *textViewDesc;
@property (weak, nonatomic) IBOutlet UILabel *authLab;

@property (nonatomic, strong) UIButton *btnExit;
@property (nonatomic, strong) UILabel  *labTitle;

+ (CellPersonInfo *)cellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;
+ (CellPersonInfo *)cellWithTableView:(UITableView *)tableView Index:(NSInteger)index;

@end