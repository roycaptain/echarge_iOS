//
//  Const.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/15.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 此类用于定义一些常量
*/
extern NSUInteger const PerPageNum; // 每页数据的条数

extern NSString *const MAMapKey; // 高德地图key
extern NSString *const BuglyAppID; // 腾讯bugly appid

extern NSString *const SearchSiteHistory; // 搜索地点历史
extern NSString *const CitySwitchHistory; // 城市切换历史

// 密码登陆类型
typedef NS_ENUM(NSUInteger,LoginType) {
    PassWordLogin = 0, // 密码登陆
    IdentifyLogin = 1, // 验证码登陆
};

// 失败成功类型
typedef NS_ENUM(NSUInteger,ResultStatusType) {
    ResultStatusFailed = 0, // 修改失败
    ResultStatusSuccessed = 1 // 修改成功
};

// 支付方式类型
typedef NS_ENUM(NSUInteger,PaymentType) {
    PaymentAlipay = 1, //支付宝
    PaymentWeChat = 2, // 微信
};

// 周边站点类型
typedef NS_ENUM(NSUInteger,AroundStationType) {
    AroundStationTypeDistance = 1, // 距离优先
    AroundStationTypeIdel = 2, // 空闲优先
};

// 友好提示用语
extern NSString *const NetworkingError; // 请求错误
extern NSString *const OperationFailure; // 操作失败
extern NSString *const OperationSuccess; // 操作成功

// 公司编码
extern NSString *const CompanyCode;

/*
 网络 接口
 */
typedef NS_ENUM(NSInteger,RequestNetworkStatus) {
    RequestNetworkSuccess = 0, // 请求成功
    RequestNetworkAlipayPaySuccess = 9000, // 支付宝支付成功
    RequestNetworkTokenLose = 400000 // access_token 失效
};

extern NSString *const BaseURLPrefix; // 接口前缀
extern NSString *const URLSuffixUserRegister; // 用户注册
extern NSString *const URLSuffixUserLogin; // 用户登陆
extern NSString *const URLSuffixModPWD; // 修改密码
extern NSString *const URLSuffixResetPWD; // 重置密码
extern NSString *const URLSuffixNearbyCompany; // 附近运营商列表
extern NSString *const URLSuffixAroundStation; // 周边站点
extern NSString *const URLSuffixFeedback; // 用户反馈
extern NSString *const URLSuffixUserInfo; // 获取用户信息
extern NSString *const URLSuffixHistoryOrder; // 历史订单
extern NSString *const URLSuffixCollectStation; // 用户收藏充电站列表
extern NSString *const URLSuffixMessage; // 我的消息
extern NSString *const URLSuffixCompanyDesc; // 公司简介
extern NSString *const URLSuffixSetCollectionStation; // 收藏添加或移除站点
extern NSString *const URLSuffixAppSmsCode; // 发送短信验证码
extern NSString *const URLSuffixSetMessageStatus; // 设置消息为已读
extern NSString *const URLSuffixChildDeviceSerial; // 获取充电枪列表
extern NSString *const URLSuffixStartCharge; // 开始充电
extern NSString *const URLSuffixStopCharge; // 结束充电
extern NSString *const URLSufixxCharge; // 充电进度
extern NSString *const URLSuffixVersion; // 获取版本信息
extern NSString *const URLSuffixAlipayPay; // 创建支付宝订单
extern NSString *const URLSuffixAlipayRefund; // 支付宝退款
extern NSString *const URLSuffixWechatPay; // 创建微信订单
extern NSString *const URLSuffixWechatRefund; // 微信退款
extern NSString *const URLSuffixHandleQrcodeScan; // 扫描二维码后的相关处理
extern NSString *const URLSuffixDeviceList; // 获取设备列表
extern NSString *const URLSuffixStartAppointment; // 启动预约
extern NSString *const URLSuffixAppointmentInfo; // 预约信息
extern NSString *const URLSuffixRenewalAppoint; // 续约
extern NSString *const URLSuffixCancelAppoint; // 取消预约
extern NSString *const URLSuffixDeviceBatteryTest; // 电压测试
extern NSString *const URLSuffixDeviceTemplate; // 计费模版

@interface Const : NSObject

@end
