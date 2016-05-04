

#import <UIKit/UIKit.h>

#import "MainTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

+ (AppDelegate *)shareAppDelegate;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigation;
@property (nonatomic, strong) NSMutableDictionary *unreadDict;
@property (nonatomic, strong) MainTabBarViewController *tabVC;
@property (nonatomic, strong) NSMutableArray *contactNames;
@property(nonatomic, strong) NSMutableArray *messageNames;
@property(nonatomic, strong) NSMutableArray *GrabNames;
@end 

