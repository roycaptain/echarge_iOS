//
//  RefundView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "RefundView.h"

@implementation RefundView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(UILabel *)refundTip
{
    if (!_refundTip) {
        CGFloat x = 14.0f;
        CGFloat y = 13.0f;
        CGFloat width = 63.0f;
        CGFloat height = 16.0f;
        
        _refundTip = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _refundTip.text = @"退款金额";
        _refundTip.textColor = [UIColor colorWithHexString:@"#000000"];
        _refundTip.font = [UIFont fontWithName:@"PingFang-SC-Heavy" size:16.0f];
        _refundTip.textAlignment = NSTextAlignmentLeft;
        _refundTip.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_refundTip];
    }
    return _refundTip;
}

-(UILabel *)rmbLabel
{
    if (!_rmbLabel) {
        CGFloat x = 61.0f;
        CGFloat y = _refundTip.frame.origin.y + _refundTip.frame.size.height + 30.0f;
        CGFloat width = 30.0f;
        CGFloat height = 30.0f;
        
        _rmbLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _rmbLabel.text = @"￥";
        _rmbLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _rmbLabel.textAlignment = NSTextAlignmentLeft;
        _rmbLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:30.0f];
        [self addSubview:_rmbLabel];
    }
    return _rmbLabel;
}

-(UITextField *)textField
{
    if (!_textField) {
        CGFloat x = _rmbLabel.frame.origin.x + _rmbLabel.frame.size.width;
        CGFloat y = _rmbLabel.frame.origin.y;
        CGFloat width = 200.0f;
        CGFloat height = 30.0f;
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _textField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:30.0f];
        [self addSubview:_textField];
    }
    return _textField;
}

-(UILabel *)underLine
{
    if (!_underLine) {
        CGFloat x = 14.0f;
        CGFloat y = _rmbLabel.frame.origin.y + _rmbLabel.frame.size.height + 15.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 1.0f;
        
        _underLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _underLine.backgroundColor = [UIColor colorWithHexString:@"#D2D2D2"];
        [self addSubview:_underLine];
    }
    return _underLine;
}

-(UILabel *)balanceLabel
{
    if (!_balanceLabel) {
        CGFloat x = 14.0f;
        CGFloat y = _underLine.frame.origin.y + 10.0f;
        CGFloat width = 100.0f;
        CGFloat height = 12.0f;
        
        _balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _balanceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _balanceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _balanceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_balanceLabel];
    }
    return _balanceLabel;
}

#pragma mark - initUI
-(void)initUI
{
    [self refundTip];
    [self rmbLabel];
    [self textField];
    [self underLine];
    [self balanceLabel];
}

// 设置余额
-(void)setAccountBalance:(NSString *)balance
{
    self.balanceLabel.text = [NSString stringWithFormat:@"账户余额%@",[balance copy]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
