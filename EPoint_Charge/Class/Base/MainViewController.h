//
//  MainViewController.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/16.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

/*
 设置 NavigationBar 的标题
 */
-(void)setNavigationTitle:(NSString *)title;

/*
 设置 NavigationBar 标题的颜色
 */
-(void)setNavigationBarTitleFontSize:(CGFloat)fontSize andFontColor:(NSString *)color;

/*
 隐藏 NavigationBar 返回按钮
 */
-(void)setHideNavigationBarBackItem;

/*
 自定义NavigationBar 返回按钮
 */
-(void)setNavigationBarBackItem;

/*
 自定义NavigationBar 返回按钮的返回事件
 */
-(void)setNavigationBarBackItemWithTarget:(id)target action:(SEL)buttonAction;

/*
 设置 NavigationBar 为透明样式
 */
-(void)setNavigationBarClearStyle;

/*
 NavigationBar 由透明样式切换到不透明样式
 */
-(void)setNavigationBarOpaqueStyle;

/*
 设置找桩界面 leftBarButtonItem 样式
 */
-(void)setFindVCLeftBarButtonItemWithTitle:(NSString *)title withImageNamed:(NSString *)imageNamed withTarget:(id)target action:(SEL)buttonAction;

/*
 设置找桩界面 leftBarButtonItem 名称
 */
-(void)setFindVCLeftBarButtonItemWithTitle:(NSString *)title;

/*
 设置 NavigationBar rightBarButtonItem 的文字
 */
-(void)setNavigationRightButtonItemWithTitle:(NSString *)title withTarget:(id)target withAction:(SEL)buttonAction;

/*
 如果 accessToken 无效跳转至登录界面
 */
-(void)presentLoginController;

@end
