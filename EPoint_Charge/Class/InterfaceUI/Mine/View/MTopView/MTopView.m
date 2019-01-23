//
//  MTopView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/22.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "MTopView.h"

@implementation MTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(UIImageView *)headImageView
{
    if (!_headImageView) {
        CGFloat x = 42.0f;
        CGFloat y = 60.0f;
        CGFloat width = 66.0f;
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_headImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:_headImageView.bounds.size];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        //设置大小
        maskLayer.frame = _headImageView.bounds;
        //设置图形样子
        maskLayer.path = maskPath.CGPath;
        _headImageView.layer.mask = maskLayer;
        _headImageView.image = [UIImage imageNamed:@"login_logo"];
        [self addSubview:_headImageView];
    }
    return _headImageView;
}

-(UIButton *)userName
{
    if (!_userName) {
        NSString *title = @"登陆 | 注册";
        CGFloat fontSize = 12.0f;
        
        CGFloat height = 12.0f;
        CGFloat width = [GeneralSize calculateStringWidth:title withFontSize:fontSize withStringHeight:height];
        CGFloat x = _headImageView.frame.origin.x + _headImageView.frame.size.width + 6.0f;
        CGFloat y = 86.0f;
        
        _userName = [UIButton buttonWithType:UIButtonTypeCustom];
        _userName.frame = CGRectMake(x, y, width, height);
        _userName.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        [_userName setTitle:title forState:UIControlStateNormal];
        [_userName setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_userName addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_userName];
    }
    return _userName;
}

#pragma mark - private method
-(void)initUI
{
    [self setUserInteractionEnabled:YES]; // 使添加其上面的按钮有点击事件
    [self setImage:[UIImage imageNamed:@"login_bg_top"]];
    
    [self headImageView];
//    [self userName];
}

-(void)loginClick
{
    NSLog(@"登陆/注册");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
