

#import <UIKit/UIKit.h>

@interface CellComment : UITableViewCell

@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, copy) void (^CellCommentBlock)(NSString *comment);

+ (CellComment *)cellWithTableView:(UITableView *)tableView;

@end
