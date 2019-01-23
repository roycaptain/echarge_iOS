//
//  LoginSlideView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/20.
//  Copyright © 2018年 dddgong. All rights reserved.
//

/*
 此模块是 密码登陆 和验证码登陆 滑动模块
 */
#import <UIKit/UIKit.h>
#import "PWLandView.h"
#import "CodeLandView.h"

extern CGFloat const NavBarHeight; // 滑动视图的高度
extern CGFloat const SlideItemWidth; // 滑动按钮的宽度
extern CGFloat const SlideItemHeight; // 滑动按钮的高度
extern CGFloat const SlideSuffixWidth; // 滑动下标的宽度
extern CGFloat const SlideSuffixHeight; // 滑动下标的高度
extern NSString *const FontName; // 字体类型

@protocol LoginSlideViewDelegate<NSObject>

// 点击滑动按钮
-(void)loginTypeClick:(LoginType)loginType;

// 点击获取验证码按钮
-(void)loginSlideViewIdentifyClick;

@end


@interface LoginSlideView : UIView<CodeLandViewDelegate>

@property(nonatomic,strong)UIView *navBar; // 按钮和下标的视图
@property(nonatomic,strong)UIButton *pwLand; // 密码登陆
@property(nonatomic,strong)UIButton *codeLand; // 验证码登陆
@property(nonatomic,strong)UILabel *slide; // 滑动下标
@property(nonatomic,strong)UIScrollView *mainScrollView; // 滑动内容
@property(nonatomic,strong)PWLandView *pwLandView; // 密码登陆
@property(nonatomic,strong)CodeLandView *codeLandView; // 验证码登陆

@property(nonatomic,assign)NSUInteger selectedIndex; // 选中索引
@property(nonatomic,assign)LoginType loginType;

@property(nonatomic,strong)NSString *account;

@property(nonatomic,weak)id<LoginSlideViewDelegate> delegate;

@end
