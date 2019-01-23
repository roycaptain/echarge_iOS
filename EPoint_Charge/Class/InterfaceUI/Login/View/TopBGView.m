//
//  TopBGView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/20.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "TopBGView.h"

@implementation TopBGView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"login_bg_top"]];
        
        [self logoImageView];
        [self welcomeLabel];
    }
    return self;
}

#pragma mark - lazy load
-(UIImageView *)logoImageView
{
    if (!_logoImageView) {
        CGFloat width = 50.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] / 2 -width / 2;
        CGFloat y = 46.0f;
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        [_logoImageView setImage:[UIImage imageNamed:@"login_logo"]];
        _logoImageView.layer.cornerRadius = width / 2;
        _logoImageView.layer.masksToBounds = YES;
        [self addSubview:_logoImageView];
    }
    return _logoImageView;
}

-(UILabel *)welcomeLabel
{
    if (!_welcomeLabel) {
        CGFloat width = 225.0f;
        CGFloat height = 26.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] / 2 - width / 2;
        CGFloat y = _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 25.0f;
        _welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _welcomeLabel.text = @"HI 欢迎来到瑞兴充电";
        _welcomeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:24];
        _welcomeLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _welcomeLabel.textAlignment = NSTextAlignmentCenter;
        _welcomeLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_welcomeLabel];
    }
    return _welcomeLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
