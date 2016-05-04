

#import "ProtocolVC.h"

@interface ProtocolVC ()<UIWebViewDelegate>

@end

@implementation ProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"服务协议"];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *strPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"demo.html"];
    NSString *strHtml = [[NSString alloc] initWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:strHtml baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    [webView setScalesPageToFit:YES];
    [webView setDelegate:self];
    [self.view addSubview:webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    MBShow
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    MBHide
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    MBHide
    MBE_Sys
}

@end
