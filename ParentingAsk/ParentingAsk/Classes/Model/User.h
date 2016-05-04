

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *chatid;
@property (nonatomic, copy) NSString *chatpd;
@property (nonatomic, assign) long User_id;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *ceurl;
@property (nonatomic, copy) NSString *idurl;
@property (nonatomic, copy) NSString *oturl;

@property (nonatomic, assign) long long lastAskTime;
@property (nonatomic, copy) NSString *childname;
@property (nonatomic, copy) NSString *headurl;
@property (nonatomic, assign) long long childbirth;
@property (nonatomic, assign) int childsex;

@property (nonatomic, copy) NSString *locationName;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, copy) NSString *department;
@property (nonatomic, assign) int integral;
@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString *card_account;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *card_name;
@property (nonatomic, copy) NSString *card_no;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) int service_times;
@property (nonatomic, assign) int week_service_times;
@property (nonatomic, assign) int month_service_times;
@property (nonatomic, assign) int level;

@property (nonatomic, copy) NSString *viewName;
@property (nonatomic, assign) long isOnline;

//添加是否完成认证
@property (nonatomic, copy) NSString *ischecked;


@end
