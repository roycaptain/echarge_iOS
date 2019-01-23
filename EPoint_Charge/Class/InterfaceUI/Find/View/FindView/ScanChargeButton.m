//
//  ScanChargeButton.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/27.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ScanChargeButton.h"

@implementation ScanChargeButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(UIImageView *)imageIcon
{
    if (!_imageIcon) {
        _imageIcon = [[UIImageView alloc] init];
        _imageIcon.image = [UIImage imageNamed:@"scan_charge_icon"];
        [self addSubview:_imageIcon];
    }
    return _imageIcon;
}

-(UILabel *)headLabel
{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc] init];
        _headLabel.text = @"扫码充电";
        _headLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.font = [UIFont systemFontOfSize:18.0f];
        _headLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_headLabel];
    }
    return _headLabel;
}

#pragma mark - initUI
-(void)initUI
{
    [self imageIcon];
    [self headLabel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // imageIcon
    CGFloat iconWidth = 22.0f;
    CGFloat iconX = self.frame.size.width / 2 - iconWidth - 10.0f;
    CGFloat iconY = 11.0f;
    _imageIcon.frame = CGRectMake(iconX, iconY, iconWidth, iconWidth);
    
    // headLabel
    CGFloat width = 71.0f;
    CGFloat height = 17.0f;
    CGFloat x = _imageIcon.frame.origin.x + _imageIcon.frame.size.width + 10.0f;
    CGFloat y = 13.0f;
    _headLabel.frame = CGRectMake(x, y, width, height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
