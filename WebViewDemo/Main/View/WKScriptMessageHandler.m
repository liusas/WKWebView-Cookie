//
//  WKScriptMessageHandler.m
//  WebViewDemo
//
//  Created by 刘峰 on 2019/4/4.
//  Copyright © 2019年 Liufeng. All rights reserved.
//

#import "WKScriptMessageHandler.h"
#import "UserDefaultManager.h"

@implementation WKScriptMessageHandler

+ (WKUserContentController *)addScriptMessageHandler:(id<WKScriptMessageHandler>)observer {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ScriptHandlerList" ofType:@"plist"];
    NSArray *scriptHandlerList = [NSArray arrayWithContentsOfFile:path];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    for (NSString *key in scriptHandlerList) {
        [userContentController addScriptMessageHandler:observer name:key];
    }
    //注入同步Cookies的JS，先注释掉，以免有人看不到影响测试
    [userContentController addUserScript:[[self alloc] injectCookieScript]];
    return userContentController;
}

+ (void)didReceiveScriptMessage:(WKScriptMessage *)message {
    //H5方面给的登录的回调内容,名字需要和H5方面约定,然后写到ScriptHandlerList中
    if ([message.name isEqualToString:@"LoginHandler"]) {
        if (message.body) {
            NSDictionary *dic = message.body;
            NSLog(@"message.body解析：%@",dic);
            [UserDefaultManager removeDefaultLoginModelData];
            [UserDefaultManager setDefaultLoginModelData:dic];//将信息存储到沙盒
        }
    }
}

//通过注入JS解决Cookies不同步的问题
- (WKUserScript *)injectCookieScript{
    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource:[self cookieString] injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    return cookieScript;
}

- (NSString *)cookieString
{
    NSMutableString *script = [NSMutableString string];
    [script appendString:@"var cookieNames = document.cookie.split('; ').map(function(cookie) { return cookie.split('=')[0] } );\n"];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        
        if ([cookie.value rangeOfString:@"'"].location != NSNotFound) {
            continue;
        }
        
        NSString *string = [NSString stringWithFormat:@"%@=%@;domain=%@;path=%@",
                            cookie.name,
                            cookie.value,
                            cookie.domain,
                            cookie.path ?: @"/"];
        
        [script appendFormat:@"if (cookieNames.indexOf('%@') == -1) { document.cookie='%@'; };\n", cookie.name, string];
    }
    return script;
}

@end
