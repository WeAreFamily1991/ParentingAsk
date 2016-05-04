

#import <UIKit/UIKit.h>

@interface CellRegist : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;

@property (nonatomic, weak) IBOutlet UIButton *btnCamera;
@property (nonatomic, weak) IBOutlet UIButton *btnGetCode;
@property (nonatomic, weak) IBOutlet UIButton *btnIsAgree;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@property (nonatomic, weak) IBOutlet UITextField *textDesc;
@property (nonatomic, weak) IBOutlet UIImageView *imageIsAgree;
//育儿条款
@property (nonatomic, weak) IBOutlet UIButton *btnRegulation;
//协议说明
@property (nonatomic, weak) IBOutlet UILabel *labProtocolTemp;

@property (weak, nonatomic) IBOutlet UIButton *showPswBtn;
+ (CellRegist *)cellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;

@end
