//
//  CustomWkWebView.h
//  WebViewDemo
//
//  Created by 刘峰 on 2019/4/4.
//  Copyright © 2019年 Liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "EnumHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomWkWebView : WKWebView

/**
 初始化WKWebview
 @param whetherShowTabbar 是否展示底部工具栏
 */
- (instancetype)initWithFrame:(CGRect)frame andTabbarType:(ShowTabbarOrNot)whetherShowTabbar;

@end

NS_ASSUME_NONNULL_END
