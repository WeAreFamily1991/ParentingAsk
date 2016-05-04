

#import <UIKit/UIKit.h>
@class Msg_Waiting;

@interface CellWaiting : UITableViewCell

@property (strong, nonatomic) UIImageView *GrabIMG;
@property (nonatomic, strong) IBOutlet UIImageView *imageAvatar;
@property (nonatomic, strong) IBOutlet UILabel *labName;
@property (nonatomic, strong) IBOutlet UILabel *labDesc;
@property (nonatomic, strong) IBOutlet UILabel *labTime;
@property (nonatomic, strong) IBOutlet UILabel *labUnRead;


@property (nonatomic, strong) Msg_Waiting *msg_Waiting;
+ (CellWaiting *)cellWithTableView:(UITableView *)tableView;

@end
