//
//  UserDefaultManager.m
//  WebViewDemo
//
//  Created by 刘峰 on 2019/4/4.
//  Copyright © 2019年 Liufeng. All rights reserved.
//

#import "UserDefaultManager.h"

@implementation UserDefaultManager

/**
 H5登录成功后传递过来的数据,存储到UserDefault中
 */
+ (void)setDefaultLoginModelData:(NSDictionary *)data {
    
}

/**
 获取登录成功保存在UserDefault中的数据
 */
+ (NSDictionary *)getDefaultLoginModelData {
    return nil;
}

/**
 移除登录成功后保存在UserDefault中的数据
 */
+ (void)removeDefaultLoginModelData {
    
}

@end
