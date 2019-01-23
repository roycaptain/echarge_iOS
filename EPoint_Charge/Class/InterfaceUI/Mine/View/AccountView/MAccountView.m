//
//  MAccountView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/22.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "MAccountView.h"

@implementation MAccountView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(UILabel *)accountLabel
{
    if (!_accountLabel) {
        CGFloat width = 57.0f;
        CGFloat height = 13.0f;
        CGFloat x = 20.0f;
        CGFloat y = self.frame.size.height / 2 - height / 2;
        
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _accountLabel.text = @"账户余额:";
        _accountLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f];
        _accountLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _accountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_accountLabel];
    }
    return _accountLabel;
}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        CGFloat width = 112.0f;
        CGFloat height = 23.0f;
        CGFloat x = _accountLabel.frame.origin.x + _accountLabel.frame.size.width + 18.0f;
        CGFloat y = self.frame.size.height / 2 - height / 2;
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _moneyLabel.font = [UIFont fontWithName:@"PingFang-SC-Heavy" size:30.0f];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:_moneyLabel];
    }
    return _moneyLabel;
}

-(UIButton *)recharge
{
    if (!_recharge) {
        CGFloat width = 48.0f;
        CGFloat height = 20.0f;
        CGFloat x = self.frame.size.width - width - 31.0f;
        CGFloat y = 25.0f;
        
        _recharge = [UIButton buttonWithType:UIButtonTypeCustom];
        _recharge.frame = CGRectMake(x, y, width, height);
        _recharge.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f];
        [_recharge setTitle:@"充值" forState:UIControlStateNormal];
        [_recharge setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateNormal];
        _recharge.layer.cornerRadius = 10.0f;
        _recharge.layer.borderColor = [UIColor colorWithHexString:@"#02B1CD"].CGColor;
        _recharge.layer.borderWidth = 1.0f;
        [_recharge addTarget:self action:@selector(chargeClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_recharge];
    }
    return _recharge;
}

-(UIButton *)refund
{
    if (!_refund) {
        CGFloat width = 48.0f;
        CGFloat height = 20.0f;
        CGFloat x = self.frame.size.width - width - 31.0f;
        CGFloat y = self.frame.size.height - height - 25.0f;
        
        _refund = [UIButton buttonWithType:UIButtonTypeCustom];
        _refund.frame = CGRectMake(x, y, width, height);
        _refund.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f];
        [_refund setTitle:@"退款" forState:UIControlStateNormal];
        [_refund setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateNormal];
        _refund.layer.cornerRadius = 10.0f;
        _refund.layer.borderColor = [UIColor colorWithHexString:@"#02B1CD"].CGColor;
        _refund.layer.borderWidth = 1.0f;
        [_refund addTarget:self action:@selector(refundClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_refund];
    }
    return _refund;
}

#pragma mark - initUI
-(void)initUI
{
    self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    
    [self accountLabel];
    [self moneyLabel];
    [self recharge];
    [self refund];
}

#pragma mark - click
-(void)chargeClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(accountRecharge)]) {
        [self.delegate accountRecharge];
    }
}

-(void)refundClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(accountReFund)]) {
        [self.delegate accountReFund];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
