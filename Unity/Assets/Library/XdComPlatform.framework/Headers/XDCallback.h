//
//  XDCallback.h
//  XdComPlatform
//
//  Created by 杜凯强 on 2017/6/13.
//  Copyright © 2017年 dyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XDCallback <NSObject>

@required

/**
 初始化成功
 */
- (void)onInitSucceed;

/**
 初始化失败

 @param error_msg 错误信息
 */
- (void)onInitFailed:(nullable NSString*)error_msg;


/**
 登录成功

 @param access_token Token
 */
- (void)onLoginSucceed:(nonnull NSString*)access_token;



/**
 登录失败

 @param error_msg 错误信息
 */
- (void)onLoginFailed:(nullable NSString*)error_msg;



/**
 登录取消
 */
- (void)onLoginCanceled;


/**
 游客账号升级成功
 */
- (void)onGuestBindSucceed:(nonnull NSString*)access_token;


/**
 登出成功
 */
- (void)onLogoutSucceed;


/**
 支付完成
 */
- (void)onPayCompleted;


/**
 支付失败

 @param error_msg 错误信息
 */
- (void)onPayFailed:(nullable NSString*)error_msg;


/**
 支付取消
 */
- (void)onPayCanceled;

@end
