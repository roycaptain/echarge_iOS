//
//  ScanAnimationView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/16.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanAnimationView : UIImageView

/*
 扫码充电动画
 @param NSString *imageName 图片名称
 @param NSString *text 提示文本
 */
-(void)setScanImage:(NSString *)imageName andScanLabelText:(NSString *)text;

-(void)setScanLabelText:(NSString *)text;

@end
