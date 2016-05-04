
// 登录后的主页

#import "BaseVC.h"

@interface MainVC : BaseVC
//消息记录
@property(strong,nonatomic) UIButton *btnMessages;
//联系人
@property(strong,nonatomic) UIButton *btnConnects;


//在线
@property(strong,nonatomic) UIButton *btnOnline;
//离线
@property(strong,nonatomic) UIButton *btnOffLine;
#pragma mark 选择消息或联系人
- (void)clickChoose:(UIButton *)sender;
@end
