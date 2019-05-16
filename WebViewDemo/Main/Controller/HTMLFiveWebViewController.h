//
//  HTMLFiveWebViewController.h
//  WebViewDemo
//
//  Created by 刘峰 on 2019/4/4.
//  Copyright © 2019年 Liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnumHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTMLFiveWebViewController : UIViewController

@property (nonatomic, assign) ShowTabbarOrNot whetherShowTabbar;/**< 是否显示底部工具栏*/

@property (nonatomic, copy) NSString *htmlUrl;
@property (nonatomic, copy) NSString *tabName;

@end

NS_ASSUME_NONNULL_END
