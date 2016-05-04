

#import <UIKit/UIKit.h>
#import "BaseTVC.h"
@interface MessageVC :UITableViewController
@property (nonatomic, assign) ConnectsType connectsType;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UINavigationController *navigationCurrent;
//@property(nonatomic ,assign)BOOL isShowBack;//add by xiaoxiao
- (void)obtainPersons;
@end
