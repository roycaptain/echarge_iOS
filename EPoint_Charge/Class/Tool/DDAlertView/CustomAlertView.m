//
//  CustomAlertView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/30.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "CustomAlertView.h"
#import "SVProgressHUD.h"

@implementation CustomAlertView

/*
 只有菊花旋转
 */
+(void)show
{
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:@"#02B1CD"]];
    [SVProgressHUD show];
}

/*
 带转动的圈和文字
 */
+(void)showWithMessage:(NSString *)message
{
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:@"#02B1CD"]];
    [SVProgressHUD showWithStatus:message];
}

/*
 隐藏
 */
+(void)hide
{
    [SVProgressHUD dismiss];
}

/*
 带感叹号的现实信息
 */
+(void)showWithWarnMessage:(NSString *)text
{
    [SVProgressHUD showInfoWithStatus:text];
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:@"#02B1CD"]];
    [SVProgressHUD dismissWithDelay:1.0f];
}

/*
 成功
 */
+(void)showWithSuccessMessage:(NSString *)text
{
    [SVProgressHUD showSuccessWithStatus:text];
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:@"#02B1CD"]];
    [SVProgressHUD dismissWithDelay:1.0f];
}

/*
 失败
 */
+(void)showWithFailureMessage:(NSString *)text
{
    [SVProgressHUD showErrorWithStatus:text];
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:@"#02B1CD"]];
    [SVProgressHUD dismissWithDelay:1.0f];
}

@end
