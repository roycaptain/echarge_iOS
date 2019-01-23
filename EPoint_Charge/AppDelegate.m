//
//  AppDelegate.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/15.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "LoginController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import <Bugly/Bugly.h>

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self applicationInitMethod]; // app 启动时要初始化一些类实例
    [self loadControllers]; // 加载控制器

    
    return YES;
}

/*
 app 启动时要初始化一些类实例
 */
-(void)applicationInitMethod
{
    //监控网络状态 初始化网络工具层
    [self monitorNetworkingStatus];
    // 用户管理单例
    [UserInfoManager shareInstance];
    if ([[UserInfoManager shareInstance] getUserChargeStatus] == NULL) {
        [[UserInfoManager shareInstance] saveUserStartChargeStatus:NO];
    }
    
    // 高德地图 设置
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = MAMapKey;
    // 向微信终端注册id
    [WXApi registerApp:@"wxdacb23a492fcf701"];
    // 腾讯bugly crash 上报
    [Bugly startWithAppId:BuglyAppID];
}

/*
 网络监控
 */
-(void)monitorNetworkingStatus
{
    [DDNetworkRequest shareInstance];
    [[DDNetworkRequest shareInstance] monitorNetworkingStatus];
}


// 加载控制器
-(void)loadControllers
{    
    NSString *userInfoPhoneNum = [[UserInfoManager shareInstance] achieveUserInfoPhoneNum];
    NSString *userInfoAccessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    if (!userInfoPhoneNum || !userInfoAccessToken) {
        UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
        LoginController *loginVC = [loginSB instantiateViewControllerWithIdentifier:@"LoginController"];
        self.window.rootViewController = loginVC;
    } else {
        // 初始化 TabBarController
        MainTabBarController *mainTabBarController = [[MainTabBarController alloc] init];
        self.window.rootViewController = mainTabBarController;
    }
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    // 支付宝支付返回结果
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSString *resultStatus = resultDic[@"resultStatus"];
//            NSString *result = resultDic[@"result"];
//            NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
//            NSDictionary *info = data[@"alipay_trade_app_pay_response"];
//            NSString *msg = info[@"msg"];
            
            if ([resultStatus integerValue] == RequestNetworkAlipayPaySuccess) {
                [CustomAlertView showWithSuccessMessage:@"支付成功"];
            } else {
                [CustomAlertView showWithFailureMessage:@"支付失败"];
            }
        }];
    }
    // 微信支付返回结果
    if ([url.host isEqualToString:@"pay"]) {
        [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - WXApiDelegate
-(void) onResp:(BaseResp*)resp
{
    switch (resp.errCode) {
        case 0:
            [CustomAlertView showWithSuccessMessage:@"支付成功"];
            break;
        case -1:
            [CustomAlertView showWithFailureMessage:@"支付失败"];
            break;
        case -2:
            [CustomAlertView showWithWarnMessage:@"用户退出支付"];
            break;
        default:
            [CustomAlertView showWithWarnMessage:resp.errStr];
            break;
    }
}


@end
