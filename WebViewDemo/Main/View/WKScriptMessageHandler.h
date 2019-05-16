//
//  WKScriptMessageHandler.h
//  WebViewDemo
//
//  Created by 刘峰 on 2019/4/4.
//  Copyright © 2019年 Liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKScriptMessageHandler : NSObject

+ (WKUserContentController *)addScriptMessageHandler:(id<WKScriptMessageHandler>)observer;

+ (void)didReceiveScriptMessage:(WKScriptMessage *)message;

@end

NS_ASSUME_NONNULL_END
