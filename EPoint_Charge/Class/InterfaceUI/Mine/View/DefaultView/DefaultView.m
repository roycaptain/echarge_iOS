
//
//  DefaultView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/24.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "DefaultView.h"

@implementation DefaultView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(UIImageView *)promptImageView
{
    if (!_promptImageView) {
        CGFloat width = 174.0f;
        CGFloat height = 167.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] / 2 -width / 2;
        CGFloat y = 138.0f;
        
        _promptImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self addSubview:_promptImageView];
    }
    return _promptImageView;
}

-(UILabel *)promptLabel
{
    if (!_promptLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _promptImageView.frame.origin.y + _promptImageView.frame.size.height + 34.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 11.0f;
        
        _promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _promptLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _promptLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:10.0f];
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_promptLabel];
    }
    return _promptLabel;
}

#pragma mark - initUI
-(void)initUI
{
    [self promptImageView];
    [self promptLabel];
}

#pragma mark - private method
+ (DefaultView *)shareInstance
{
    static DefaultView *defaultView = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight];
        
        defaultView = [[self alloc] initWithFrame:CGRectMake(x, y, width, height)];
    });
    return defaultView;
}

-(void)setSuperView:(UIView *)superView withDefaultImageNamed:(NSString *)imageNamed withTitle:(NSString *)title
{
    _promptLabel.text = title;
    _promptImageView.image = [UIImage imageNamed:imageNamed];
    [superView addSubview:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
