//
//  PaymentView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "PaymentView.h"

@implementation PaymentView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(PaymentItem *)alipayItem
{
    if (!_alipayItem) {
        _alipayItem = [PaymentItem buttonWithType:UIButtonTypeCustom];
        [_alipayItem setPaymentItemPayIconWithImageNamed:@"alipay_icon"];
        [_alipayItem setPaymentItemPayTitleWithText:@"支付宝"];
        [_alipayItem setPaymentItemSelectIconWithImageNamed:@"payment_select"];
        _selectItem = _alipayItem;
        [_alipayItem addTarget:self action:@selector(paymentClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_alipayItem];
    }
    return _alipayItem;
}

-(UILabel *)underLine
{
    if (!_underLine) {
        _underLine = [[UILabel alloc] init];
        _underLine.backgroundColor = [UIColor colorWithHexString:@"#D2D2D2"];
        [self addSubview:_underLine];
    }
    return _underLine;
}

-(PaymentItem *)wechatItem
{
    if (!_wechatItem) {
        _wechatItem = [PaymentItem buttonWithType:UIButtonTypeCustom];
        [_wechatItem setPaymentItemPayIconWithImageNamed:@"wechat_icon"];
        [_wechatItem setPaymentItemPayTitleWithText:@"微信"];
        [_wechatItem setPaymentItemSelectIconWithImageNamed:@"payment_unselect"];
        [_wechatItem addTarget:self action:@selector(paymentClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_wechatItem];
    }
    return _wechatItem;
}

#pragma mark - initUI
-(void)initUI
{
    [self alipayItem];
    [self underLine];
    [self wechatItem];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // _alipayItem
    CGFloat alipayX = 0.0f;
    CGFloat alipayY = 0.0f;
    CGFloat alipayWidth = self.frame.size.width;
    CGFloat alipayHeight = 45.0f;
    _alipayItem.frame = CGRectMake(alipayX, alipayY, alipayWidth, alipayHeight);
    
    // _underLine
    CGFloat lineX = 0.0f;
    CGFloat lineY = _alipayItem.frame.origin.y + _alipayItem.frame.size.height;
    CGFloat lineWidth = self.frame.size.width;
    CGFloat lineHeight = 1.0f;
    _underLine.frame = CGRectMake(lineX, lineY, lineWidth, lineHeight);
    
    // _wechatItem
    CGFloat wechatX = 0.0f;
    CGFloat wechatY = _underLine.frame.origin.y + _underLine.frame.size.height;
    CGFloat wechatWidth = self.frame.size.width;
    CGFloat wechatHeight = 45.0f;
    _wechatItem.frame = CGRectMake(wechatX, wechatY, wechatWidth, wechatHeight);
}

#pragma mark - click
-(void)paymentClick:(PaymentItem *)item
{
    if (_selectItem != item) {
        [_selectItem setPaymentItemSelectIconWithImageNamed:@"payment_unselect"];
        [item setPaymentItemSelectIconWithImageNamed:@"payment_select"];
        _selectItem = item;
    } else {
        _selectItem = item;
    }
    
    // 支付方式
    PaymentType payType = [item.payLabel.text isEqualToString:@"支付宝"] ? PaymentAlipay : PaymentWeChat;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithPaymentItem:)]) {
        [self.delegate clickWithPaymentItem:payType];
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
