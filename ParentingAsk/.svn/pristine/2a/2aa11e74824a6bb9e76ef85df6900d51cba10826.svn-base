/**
 *  Created by Moses on 2014-6-10.
 *  Copyright (c) 2014年 YekuMob.com. All rights reserved.
 */

#import "BaseVC.h"

@interface TMWebViewController : BaseVC<UIWebViewDelegate>
{
    IBOutlet UIWebView *mWebview;
}
@property (nonatomic, copy) NSString         *mUrlString;    // 网页地址
@property (nonatomic, copy) NSString         *mTitle;        // 网页标题
@property (nonatomic, assign) BOOL            mNavBarHidden; // 以藏
/**
 *  初始化Web视图
 *
 *  @param nibNameOrNil   xib名称
 *  @param nibBundleOrNil nig bundle
 *  @param urlStr         链接地址
 *  @param aTitle         页面标题
 *
 *  @return Web页面视图
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withUrl:(NSString *)urlStr andTitle:(NSString *)aTitle;

/**
 *  设置分享参数字典
 *
 *  @param aDict 参数字典（分享内容、地址、图片地址）
 */
- (void)setShareDictionery:(NSDictionary *)aDict;

@end
