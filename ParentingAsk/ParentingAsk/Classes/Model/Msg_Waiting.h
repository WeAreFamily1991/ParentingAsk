

#import <Foundation/Foundation.h>

@interface Msg_Waiting : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *headurl;

@property (nonatomic, copy) NSString *Msg_Waiting_id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *server_status;

@property (nonatomic, copy) NSString *evaluation;

@property (nonatomic, copy) NSString *evaluation_id;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *customer_id;

@property (nonatomic, copy) NSString *consulter_id;

@property (nonatomic, copy) NSDictionary *sender;

@property (nonatomic, copy) NSDictionary *receiver;

@property (nonatomic, copy) NSArray *message;

@property (nonatomic, copy) NSString *chatlabel;

@end
