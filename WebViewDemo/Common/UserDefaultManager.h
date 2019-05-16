//
//  UserDefaultManager.h
//  WebViewDemo
//
//  Created by 刘峰 on 2019/4/4.
//  Copyright © 2019年 Liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaultManager : NSObject

/**
 H5登录成功后传递过来的数据,存储到UserDefault中
 */
+ (void)setDefaultLoginModelData:(NSDictionary *)data;

/**
 获取登录成功保存在UserDefault中的数据
 */
+ (NSDictionary *)getDefaultLoginModelData;

/**
 移除登录成功后保存在UserDefault中的数据
 */
+ (void)removeDefaultLoginModelData;

@end

NS_ASSUME_NONNULL_END
