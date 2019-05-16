//
//  CustomWkWebView.m
//  WebViewDemo
//
//  Created by 刘峰 on 2019/4/4.
//  Copyright © 2019年 Liufeng. All rights reserved.
//

#import "CustomWkWebView.h"
#import "WKScriptMessageHandler.h"

@interface CustomWkWebView () <WKScriptMessageHandler>
@end

@implementation CustomWkWebView

/**
 初始化WKWebview
 @param whetherShowTabbar 是否展示底部工具栏
 */
- (instancetype)initWithFrame:(CGRect)frame andTabbarType:(ShowTabbarOrNot)whetherShowTabbar {
    if (self = [super initWithFrame:frame configuration:[self setConfiguration]]) {
        self.allowsBackForwardNavigationGestures = YES;
    }
    return self;
}


/**
 初始化WKWebview
 */
- (WKWebViewConfiguration *)setConfiguration {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = [self getPreferences];
    configuration.userContentController = [WKScriptMessageHandler addScriptMessageHandler:self];
    return configuration;
}

- (WKPreferences *)getPreferences {
    WKPreferences *preference = [[WKPreferences alloc] init];
    preference.javaScriptEnabled = YES;
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    return preference;
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [WKScriptMessageHandler didReceiveScriptMessage:message];
}

@end
