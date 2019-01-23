//
//  Const.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/15.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "Const.h"

NSUInteger const PerPageNum = 10; // 每页数据的条数
NSString *const CompanyCode = @"dddgong"; // 公司编码
//NSString *const CompanyCode = @"KY";
//NSString *const CompanyCode = @"bjgljd";
NSString *const MAMapKey = @"40edf77ff46a364043906d7c80d247cf"; // 高德地图key
NSString *const BuglyAppID = @"074bfd896a"; // 腾讯bugly appid

NSString *const SearchSiteHistory = @"siteistory.plist"; // 搜索地点历史
NSString *const CitySwitchHistory = @"cityswitchhistory.plist"; // 城市切换历史

// 友好提示用语
NSString *const NetworkingError = @"请检查您的网络"; // 请求错误提示语
NSString *const OperationFailure = @"操作失败"; // 操作失败
NSString *const OperationSuccess = @"操作成功"; // 操作成功

/*
 网络 接口
 */
//NSString *const BaseURLPrefix = @"http://47.107.68.94:8888"; // 正式
NSString *const BaseURLPrefix = @"http://120.79.23.111:8888/api/app/echarge"; //本地
//NSString *const BaseURLPrefix = @"http://120.78.79.129:8888/api/app/echarge";
NSString *const URLSuffixUserRegister = @"register"; // 用户注册
NSString *const URLSuffixUserLogin = @"login"; // 用户登陆
NSString *const URLSuffixModPWD = @"modPwd"; // 修改密码
NSString *const URLSuffixResetPWD = @"resetPwd"; // 重置密码
NSString *const URLSuffixNearbyCompany = @"company"; // 附近运营商列表
NSString *const URLSuffixAroundStation = @"station"; // 周边站点
NSString *const URLSuffixFeedback = @"feedback"; // 用户反馈
NSString *const URLSuffixUserInfo = @"user"; // 获取用户信息
NSString *const URLSuffixHistoryOrder = @"historyOrder"; // 用户历史订单
NSString *const URLSuffixCollectStation = @"collectStation"; // 用户收藏充电站列表
NSString *const URLSuffixMessage = @"message"; // 我的消息
NSString *const URLSuffixCompanyDesc = @"companyDesc"; // 公司简介
NSString *const URLSuffixSetCollectionStation = @"setCollectStation"; // 收藏添加或移除站点
NSString *const URLSuffixAppSmsCode = @"appSmsCode"; // 发送短信验证码
NSString *const URLSuffixSetMessageStatus = @"setMessageStatus"; // 设置消息为已读
NSString *const URLSuffixChildDeviceSerial = @"getChildDeviceSerialNumByDeviceSerialNum"; // 获取充电枪列表
NSString *const URLSuffixStartCharge = @"startCharge"; // 开始充电
NSString *const URLSuffixStopCharge = @"stopCharge"; // 结束充电
NSString *const URLSufixxCharge = @"charge"; // 充电进度
NSString *const URLSuffixVersion = @"appVersion"; // 获取版本信息
NSString *const URLSuffixAlipayPay = @"alipay/pay"; // 创建支付宝订单
NSString *const URLSuffixAlipayRefund = @"alipay/refundBalance"; // 支付宝退款
NSString *const URLSuffixWechatPay = @"wechatpay/pay"; // 创建微信订单
NSString *const URLSuffixWechatRefund = @"wechatpay/refundBalance"; // 微信退款
NSString *const URLSuffixHandleQrcodeScan = @"handleQrcodeScan"; // 扫描二维码后的相关处理
NSString *const URLSuffixDeviceList = @"getDeviceList"; // 获取设备列表、
NSString *const URLSuffixStartAppointment = @"startAppointment"; // 启动预约
NSString *const URLSuffixAppointmentInfo = @"getAppointmentInfo"; // 预约信息
NSString *const URLSuffixRenewalAppoint = @"renewalAppointment"; // 续约
NSString *const URLSuffixCancelAppoint = @"cancelAppointment"; // 取消预约
NSString *const URLSuffixDeviceBatteryTest = @"kyDeviceBatteryTest"; // 电压测试
NSString *const URLSuffixDeviceTemplate = @"kyDeviceTemplate"; // 计费模版

@implementation Const

@end
