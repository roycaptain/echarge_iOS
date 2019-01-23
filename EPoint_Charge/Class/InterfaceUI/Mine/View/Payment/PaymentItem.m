//
//  PaymentItem.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "PaymentItem.h"

@implementation PaymentItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(UIImageView *)payIcon
{
    if (!_payIcon) {
        _payIcon = [[UIImageView alloc] init];
        [self addSubview:_payIcon];
    }
    return _payIcon;
}

-(UILabel *)payLabel
{
    if (!_payLabel) {
        _payLabel = [[UILabel alloc] init];
        _payLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _payLabel.textAlignment = NSTextAlignmentLeft;
        _payLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        _payLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_payLabel];
    }
    return _payLabel;
}

-(UIImageView *)selectIcon
{
    if (!_selectIcon) {
        _selectIcon = [[UIImageView alloc] init];
        [self addSubview:_selectIcon];
    }
    return _selectIcon;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // payIcon
    CGFloat widthIcon = 30.0f;
    CGFloat iconX = 15.0f;
    CGFloat iconY = (self.frame.size.height - widthIcon) / 2;
    _payIcon.frame = CGRectMake(iconX, iconY, widthIcon, widthIcon);
    
    // payLabel
    CGFloat labelWidth = 52.0f;
    CGFloat labelHeight = 17.0f;
    CGFloat labelX = _payIcon.frame.origin.x + _payIcon.frame.size.width + 23.0f;
    CGFloat labelY = (self.frame.size.height - labelHeight) / 2;
    _payLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
    
    // _selectIcon
    CGFloat selectWidth = 12.0f;
    CGFloat selectX = self.frame.size.width - selectWidth - 15.0f;
    CGFloat selectY = (self.frame.size.height - selectWidth) / 2;
    _selectIcon.frame = CGRectMake(selectX, selectY, selectWidth, selectWidth);
}

#pragma mark - initUI
-(void)initUI
{
    [self payIcon];
    [self payLabel];
    [self selectIcon];
}

#pragma mark - private method
-(void)setPaymentItemPayTitleWithText:(NSString *)title
{
    _payLabel.text = title;
}

- (void)setPaymentItemPayIconWithImageNamed:(NSString *)imageNamed
{
    _payIcon.image = [UIImage imageNamed:imageNamed];
}

- (void)setPaymentItemSelectIconWithImageNamed:(NSString *)imageNamed
{
    _selectIcon.image = [UIImage imageNamed:imageNamed];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
