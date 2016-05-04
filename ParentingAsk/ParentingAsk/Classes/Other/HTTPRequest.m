
//
//  网络请求

#import "HTTPRequest.h"
#import <AFNetworking/AFNetworking.h>
#import <EaseMob.h>

@interface HTTPRequest ()<EMChatManagerDelegate>

@end

@implementation HTTPRequest

+ (HTTPRequest *)shareRequest
{
    static HTTPRequest *request;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        request = [[HTTPRequest alloc] init];
    });
    return request;
}

+ (AFHTTPRequestOperationManager *)shareManager
{
    static AFHTTPRequestOperationManager *requestManager;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        requestManager = [AFHTTPRequestOperationManager manager];
    });
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", @"text/html", @"text/plain", @"application/json", nil];
    
    //测试响应
//    [requestManager.requestSerializer setValue:@"123456" forHTTPHeaderField:@"token"];
    NSLog(@"加入的token=%@",[HTTPRequest shareRequest].sessionID);
    [requestManager.requestSerializer setValue:[HTTPRequest shareRequest].sessionID forHTTPHeaderField:@"token"];
    
    return requestManager;
}

+ (void)httpWithGet:(NSString *)method
              Param:(NSDictionary *)param
            Success:(RequestSuccessBlock)success
               Fail:(RequestFailBlock)fail
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", HostAddress, method];
//    NSLog(@"接口地址: %@", urlStr);
//    NSLog(@"参数: %@", param);
    [[self shareManager] GET:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        NSDictionary *dicSuc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        success(dicSuc);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail)
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前无网络,请检查网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
                   }

//        NSInteger statusCode = operation.response.statusCode;
//        if (statusCode == 403) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotiNeedReLogin" object:nil];
//        }
//        else {
//            fail([error.userInfo valueForKey:@"NSLocalizedDescription"]);
//        }
        
    }];
}

- (void)httpWithPost:(NSString *)method
               Param:(NSDictionary *)param
             Success:(RequestSuccessBlock)success
                Fail:(RequestFailBlock)fail
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", HostAddress, method];
//    NSLog(@"接口地址: %@", urlStr);
    
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithDictionary:param];
    
    [[HTTPRequest shareManager] POST:urlStr parameters:mutDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        NSDictionary *dicSuc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        success(dicSuc);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前无网络,请检查网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];            NSLog(@"HTTPTool.failure == %@",error);
        }

//        NSInteger statusCode = operation.response.statusCode;
//        if (statusCode == 403) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotiNeedReLogin" object:nil];
//        }
//        else {
//            fail(error.description);
//        }
    }];
}

+ (void)httpWithPost:(NSString *)method
               Param:(NSDictionary *)param
             Success:(RequestSuccessBlock)success
                Fail:(RequestFailBlock)fail
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", HostAddress, method];
//    NSLog(@"接口地址: %@", urlStr);
//    NSLog(@"参数: %@", param);
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithDictionary:param];
    
    
    [[HTTPRequest shareManager] POST:urlStr parameters:mutDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        NSDictionary *dicSuc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        
//        NSLog(@"dicSuch----%@",dicSuc);
        
        if (![HTTPRequest shareRequest].sessionID) {
            if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                [HTTPRequest shareRequest].sessionID = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
            }
        }
        
        success(dicSuc);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前无网络,请检查网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];        }

//        NSInteger statusCode = operation.response.statusCode;
//        
//         NSDictionary *dicFail = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"failStr-----%@",[[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
//        
//        NSLog(@"dicFail-----%@",dicFail);
//        if (statusCode == 403) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotiNeedReLogin" object:nil];
//            fail(error.description);
//        }
//        else {
//            fail(error.description);
//        }
    }];
}

+ (void)httpWithUploadPhoto:(NSData *)imageData Success:(RequestSuccessBlock)success Fail:(RequestFailBlock)fail
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", HostAddress, @"/pic/upload"];
//    NSLog(@"接口地址: %@", urlStr);
    
    [[self shareManager] POST:urlStr parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"photo" mimeType:@"image/jpeg"];
        [formData appendPartWithFormData:[@"submit" dataUsingEncoding:NSUTF8StringEncoding] name:@"submit"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        NSDictionary *dicSuc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        success(dicSuc);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        fail(error.description);
        
        if (fail)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前无网络,请检查网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }];
}

//zou 上传多媒体文件至服务器
+ (void)httpWithUploadMedia:(id)mediaData Param:(NSDictionary *) param Type:(MessageBodyType)type Success:(RequestSuccessBlock)success Fail:(RequestFailBlock)fail
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", HostAddress, @"/order/chatMedia"];
//    NSLog(@"接口地址: %@", urlStr);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
    
    /**
     *  上传时候调用的方法
     *
     *  params   post的参数，字典
     *  formData formData是post上去的数据
     *  name     服务器接受文件的名字
     *  fileName 文件的名字
     */
    [[HTTPRequest shareManager] POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (type == eMessageBodyType_Image) {
            NSData *data = UIImageJPEGRepresentation((UIImage *)mediaData, 1.0);
            
            while (data.length > 2000000) {
              data = [UIImage compressImage:(UIImage*)mediaData toMaxFileSize:2000000];
            }
            
            [formData appendPartWithFileData:data name:@"file" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        }else if (type == eMessageBodyType_Voice){
            [formData appendPartWithFileData:(NSData *)mediaData name:@"file" fileName:@"vioce.amr" mimeType:@"audio/amr"];
            
        }else if (type == eMessageBodyType_Video)
        {
            [formData appendPartWithFileData:(NSData *)mediaData name:@"file" fileName:@"video.mp4" mimeType:@"video/mp4"];
        }
       
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"上传成功了");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (fail)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前无网络,请检查网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }

//        NSLog(@"error:%@",error);
//        NSLog(@"上传失败了");
    }];
    
}

@end
