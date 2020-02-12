//
//  XDCallback.h
//  XdComPlatform
//
//  Created by 杜凯强 on 2017/6/13.
//  Copyright © 2017年 dyy. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 3.0 以上版本 心动SDK回调事件
 */
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
 游客账号升级失败
 */
- (void)onGuestBindFailed:(nonnull NSString*)errorMsg;


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

- (void)onRealNameSucceed;

- (void)onRealNameFailed:(nullable NSString*)error_msg;

@optional

/// 有未完成的订单回调，比如：礼包码.注意：多个未完成订单会回调多次。（只会在登录状态下回调）
/// @param paymentInfo 订单信息。
/// 包含：     transactionIdentifier ：订单标识 ，恢复购买时需要回传
///        productIdentifier ：商品ID，
///        quantity：商品数量
- (void)restoredPayment:(nonnull NSDictionary *)paymentInfo;

@end
