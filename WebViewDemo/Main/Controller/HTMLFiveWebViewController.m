//
//  HTMLFiveWebViewController.m
//  WebViewDemo
//
//  Created by 刘峰 on 2019/4/4.
//  Copyright © 2019年 Liufeng. All rights reserved.
//

#import "HTMLFiveWebViewController.h"
#import "CustomWkWebView.h"

#define IPHONEXSeries           ([UIScreen mainScreen].bounds.size.height >= 810)
// 状态栏高度
#define STATUS_BAR_HEIGHT       (IPHONEXSeries ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT   (IPHONEXSeries ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT          (IPHONEXSeries ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT   (IPHONEXSeries ? 34.f : 0.f)

@interface HTMLFiveWebViewController () <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) CustomWkWebView *wkWebView;

@end

@implementation HTMLFiveWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"打印Cookies" style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"设置Cookies" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.wkWebView];
    [self loadURL:[NSURL URLWithString:self.htmlUrl]];
}

- (void)leftItemClick {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
        NSLog(@"cookies = %@", cookie);
    }
}

- (void)rightItemClick {
    //域名
    NSString *domain = [[NSURL URLWithString:self.htmlUrl] host];
    //sessionName
    NSString *sessionName = @"Hello Cookies";
    //sessionValue
    NSString *sessionValue = [NSString stringWithFormat:@"get Cookies + %@", self.tabName];
    //cookies路径 "/"
    NSString *cookiePath = @"/";
    //cookies版本 0
    NSString *cookieVersion = @"0";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSHTTPCookieDomain] = domain;
    dict[NSHTTPCookieName] = sessionName;
    dict[NSHTTPCookieValue] = sessionValue;
    dict[NSHTTPCookiePath] = cookiePath;
    dict[NSHTTPCookieVersion] = cookieVersion;
    dict[NSHTTPCookieExpires] = [NSDate dateWithTimeIntervalSince1970:([[NSDate date] timeIntervalSince1970]+365*24*3600)];
    
    //删除旧Cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *delCookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:delCookie];
    }
    
//    初始化新cookie
    NSHTTPCookie *newCookie = [NSHTTPCookie cookieWithProperties:dict];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:newCookie];
}

/*
 *Web show
 */
- (void)loadURL:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSDictionary *dict = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    request.allHTTPHeaderFields = dict;
    [self.wkWebView loadRequest:request];
}

#pragma mark - WKNavigationDelegate
/**
 根据url来判断webview是否跳转到外部链接
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url = navigationAction.request.URL;
    [self wkWebViewWillStart:url];
    //为了解决跨域问题，每次跳转url时把cookies拼接上
    NSMutableURLRequest *request = (NSMutableURLRequest *)navigationAction.request;
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSDictionary *dict = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    request.allHTTPHeaderFields = dict;
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

/**
 根据服务器返回的响应头判断是否可以跳转外链
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/**
 页面开始加载
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}

/**
 页面加载失败
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

/**
 当页面内容开始返回时调用
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

/**
 页面加载完成时调用
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        NSLog(@"title = %@", title);
        self.navigationItem.title = title;
    }];
//    [self loadURL:[NSURL URLWithString:self.htmlUrl]];
    NSLog(@"加载了一次");
}

/**
 webview即将开始加载网页

 @param url 网页的url
 */
- (void)wkWebViewWillStart:(NSURL *)url {
    if (![self isBlankString:url.absoluteString] && ![url.absoluteString isEqualToString:@"about:blank"]) {
    }
    if (!self.wkWebView.canGoBack) {//webview是否可以返回
    }
    else {
    }
}

#pragma mark - WKUIDelegate
// 创建一个新的WebView,这里应该没用
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        //这里创建新的webview
    }
    return nil;
}

#pragma mark - Getter
- (CustomWkWebView *)wkWebView {
    if (!_wkWebView) {
        CGRect frame = CGRectZero;
        frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-HOME_INDICATOR_HEIGHT);
        
        _wkWebView = [[CustomWkWebView alloc] initWithFrame:frame andTabbarType:_whetherShowTabbar];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
    }
    return _wkWebView;
}

#pragma mark - Tools
- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (NSString *)getURLString:(NSString *)string {
    
    NSError *error = nil;
    // URL regular expression
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(http|https)://((\\w)*|([-])*)+([\\.|/]((\\w)*|([-])*))+" options:0 error:&error];
    if ( error ) {
        return nil;
    }
    
    NSTextCheckingResult *res = [regex firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
    if (res != nil) {
        return string;
    }
    return nil;
}

- (BOOL)isMatchWithString:(NSString *)string andPattern:(NSString *)pattern {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error) {
        return NO;
    }
    NSTextCheckingResult *result = [regex firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
    return result ? YES : NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
