//
//  LoginSlideView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/20.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "LoginSlideView.h"

CGFloat const NavBarHeight = 28.0f; // 滑动视图的高度
CGFloat const SlideItemWidth = 85.0f; // 滑动按钮的宽度
CGFloat const SlideItemHeight = 20.0f; // 滑动按钮的高度
CGFloat const SlideSuffixWidth = 20.0f; // 滑动下标的宽度
CGFloat const SlideSuffixHeight = 2.0f; // 滑动下标的高度

@implementation LoginSlideView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(UIView *)navBar
{
    if (!_navBar) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = NavBarHeight;
        _navBar = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _navBar.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [self addSubview:_navBar];
    }
    return _navBar;
}

// 密码登陆
-(UIButton *)pwLand
{
    if (!_pwLand) {
        _pwLand = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = 40.0f;
        CGFloat y = 0.0f;
        CGFloat width = SlideItemWidth;
        CGFloat height = SlideItemHeight;
        _pwLand.frame = CGRectMake(x, y, width, height);
        _pwLand.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; //字体居左
        _pwLand.tag = 1;
        _pwLand.selected = YES;
        _pwLand.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
        [_pwLand setTitle:@"密码登录" forState:UIControlStateNormal];
        [_pwLand setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [_pwLand setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateSelected];
        [_pwLand addTarget:self action:@selector(slideItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navBar addSubview:_pwLand];
    }
    return _pwLand;
}

// 验证码登陆按钮
-(UIButton *)codeLand
{
    if (!_codeLand) {
        _codeLand = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = _pwLand.frame.origin.x + _pwLand.frame.size.width;
        CGFloat y = 0.0f;
        CGFloat width = SlideItemWidth;
        CGFloat height = SlideItemHeight;
        _codeLand.frame = CGRectMake(x, y, width, height);
        _codeLand.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _codeLand.tag = 2;
        _codeLand.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
        [_codeLand setTitle:@"验证码登录" forState:UIControlStateNormal];
        [_codeLand setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [_codeLand setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateSelected];
        [_codeLand addTarget:self action:@selector(slideItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navBar addSubview:_codeLand];
    }
    return _codeLand;
}

// 滑动下标
-(UILabel *)slide
{
    if (!_slide) {
        CGFloat x = 40.0f;
        CGFloat y = 26.0f;
        CGFloat width = SlideSuffixWidth;
        CGFloat height = SlideSuffixHeight;
        _slide = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _slide.backgroundColor = [UIColor colorWithHexString:@"#02B1CD"];
        [_navBar addSubview:_slide];
    }
    return _slide;
}

// 滑动视图
-(UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        CGFloat x = 0.0f;
        CGFloat y = _navBar.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = self.frame.size.height - _navBar.frame.size.height;
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.contentSize = CGSizeMake([GeneralSize getMainScreenWidth] * 2, 0);
        _mainScrollView.scrollEnabled = NO;
        [self addSubview:_mainScrollView];
    }
    return _mainScrollView;
}

-(PWLandView *)pwLandView
{
    if (!_pwLandView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = _mainScrollView.frame.size.height;
        _pwLandView = [[PWLandView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_mainScrollView addSubview:_pwLandView];
    }
    return _pwLandView;
}

-(CodeLandView *)codeLandView
{
    if (!_codeLandView) {
        CGFloat x = [GeneralSize getMainScreenWidth];
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = _mainScrollView.frame.size.height;
        _codeLandView = [[CodeLandView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _codeLandView.delegate = self;
        [_mainScrollView addSubview:_codeLandView];
    }
    return _codeLandView;
}

#pragma mark - initUI
// 界面排版
-(void)initUI
{
    [self navBar];
    [self pwLand];
    [self codeLand];
    [self slide];
    [self mainScrollView];
    [self pwLandView];
    [self codeLandView];
    
    [self selectedIndexWithTag:1];
    _loginType = PassWordLogin; // 初始化登陆类型
}

#pragma mark - private method

// 滑动按钮点击事件
-(void)slideItemClick:(UIButton *)button
{
    NSInteger tag = button.tag;
    
    if (_selectedIndex == tag) {
        return;
    }
    if (tag == 1) { // 切换时保证手机号输入框内容一致
        _pwLandView.accountField.textField.text = _codeLandView.accountField.textField.text;
    } else {
        _codeLandView.accountField.textField.text = _pwLandView.accountField.textField.text;
    }
    
    [self sliderAnimationWithTag:tag];
    __weak LoginSlideView *weakSlideView = self;
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat x = [GeneralSize getMainScreenWidth] * (tag - 1);
        weakSlideView.mainScrollView.contentOffset = CGPointMake(x, 0);
    } completion:^(BOOL finished) {
        
    }];
    
    // 设置登陆类型
    _loginType = (tag == 1) ? PassWordLogin : IdentifyLogin;
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginTypeClick:)]) {
        [self.delegate loginTypeClick:_loginType];
    }
}

// 下标滑动动画
-(void)sliderAnimationWithTag:(NSInteger)tag
{
    _selectedIndex = tag;
    _pwLand.selected = NO;
    _codeLand.selected = NO;
    UIButton *button = [self buttonSelectedStatusWithTag:tag];
    button.enabled = YES;
    // 动画
    __weak LoginSlideView *weakSlideView = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSlideView.slide.frame = CGRectMake(button.frame.origin.x, 26.0f, SlideSuffixWidth, SlideSuffixHeight);
    } completion:^(BOOL finished) {
        weakSlideView.pwLand.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        weakSlideView.codeLand.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [weakSlideView.pwLand setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [weakSlideView.codeLand setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [button setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateNormal];
    }];
}

// 根据选中的值来返回对应的按钮
-(UIButton *)buttonSelectedStatusWithTag:(NSInteger)tag
{
    if (tag == 1) {
        return _pwLand;
    } else if (tag == 2) {
        return _codeLand;
    } else {
        return nil;
    }
}

// 选中索引值的设置
-(void)selectedIndexWithTag:(NSUInteger)tag
{
    _selectedIndex = tag;
    _pwLand.selected = NO;
    _codeLand.selected = NO;
    UIButton *button = [self buttonSelectedStatusWithTag:tag];
    button.selected = YES;
    //  动画
    _slide.frame = CGRectMake(button.frame.origin.x, _slide.frame.origin.y, _slide.frame.size.width, _slide.frame.size.height);
}

#pragma mark - CodeLandViewDelegate
-(void)codeLandViewIdentifyItemClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginSlideViewIdentifyClick)]) {
        [self.delegate loginSlideViewIdentifyClick];
    }
}

#pragma mark - UIScrollViewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat contentOffSetX = scrollView.contentOffset.x;
//    CGFloat X = contentOffSetX / [GeneralSize getMainScreenWidth] * SlideItemWidth;
//    CGRect frame = _slide.frame;
//    frame.origin.x = X + 40.0f;
//    _slide.frame = frame;
//}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGFloat contentOffSetX = scrollView.contentOffset.x;
//    NSInteger index = contentOffSetX / [GeneralSize getMainScreenWidth];
//    NSInteger tag = index + 1;
//    [self selectedIndexWithTag:tag];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
