
// 注册页面

#import "BaseTVC.h"

@interface RegistVC : UITableViewController
@property (nonatomic, copy) void(^ChooseCityBlock)(NSString *strSelect, NSString *code);
@property (strong,nonatomic)UIImageView *imageLeft,*imageLeft2,*imageLeft3,*imageLeft4,*imageLeft5,*imageLeft6,*imageLeft7;
@property(strong,nonatomic)NSMutableArray *proArr,*cityarr,*areaArr;
@end
