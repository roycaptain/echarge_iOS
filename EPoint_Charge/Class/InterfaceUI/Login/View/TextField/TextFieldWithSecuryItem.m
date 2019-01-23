//
//  TextFieldWithSecuryItem.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/21.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "TextFieldWithSecuryItem.h"

CGFloat const SecureItemWidth = 20.0f; // 按钮的宽度
CGFloat const SecureItemHeight = 10.0f; // 按钮的高度

@implementation TextFieldWithSecuryItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        
    }
    return self;
}

#pragma mark - private method
-(void)initUI
{
    [self textField];
    [self secureItem];
    [self underLine];
}

-(void)secureClick:(UIButton *)button
{
    NSString *imageName = (_textField.secureTextEntry == YES) ? @"login_pw_display" : @"login_pw_hide";
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    _textField.secureTextEntry = (_textField.secureTextEntry == YES) ? NO : YES;
}

-(void)setTextFieldPlaceHolder:(NSString *)placeholder
{
    _textField.placeholder = placeholder;
}

#pragma mark - lazy load
-(UITextField *)textField
{
    if (!_textField) {
        CGFloat x = 10.0f;
        CGFloat y = 0.0f;
        CGFloat width = self.bounds.size.width - SecureItemWidth - x;
        CGFloat height = 19.0f;
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _textField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        _textField.secureTextEntry = YES;
        [self addSubview:_textField];
    }
    return _textField;
}

-(UIButton *)secureItem
{
    if (!_secureItem) {
        CGFloat width = SecureItemWidth;
        CGFloat height = SecureItemHeight;
        CGFloat x = self.frame.size.width - 10.0f - width;
        CGFloat y = 0.0f;
        
        _secureItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _secureItem.frame = CGRectMake(x, y, width, height);
        [_secureItem setImage:[UIImage imageNamed:@"login_pw_hide"] forState:UIControlStateNormal];
        [_secureItem addTarget:self action:@selector(secureClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_secureItem];
    }
    return _secureItem;
}

-(UILabel *)underLine
{
    if (!_underLine) {
        CGFloat x = 0.0f;
        CGFloat y = _textField.bounds.size.height + 5.0f;
        CGFloat width = self.bounds.size.width;
        CGFloat height = 1.0f;
        _underLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _underLine.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
        [self addSubview:_underLine];
    }
    return _underLine;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
