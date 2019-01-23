//
//  TextFieldWithIdentifyItem.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/21.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "TextFieldWithIdentifyItem.h"

CGFloat const IdentifyItemWidth = 90.0f; // 按钮宽度
CGFloat const IdentifyItemHeight = 17.0f; // 按钮高度

@implementation TextFieldWithIdentifyItem

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
    [self identifyItem];
    [self underLine];
}

-(void)setTextFieldPlaceHolder:(NSString *)placeholder
{
    _textField.placeholder = placeholder;
}

-(void)identifyClick
{
    // 通过代理 将点击事件传送到 LoginController
    if (self.delegate && [self.delegate respondsToSelector:@selector(TextFieldWithIdentifyItemClick)]) {
        [self.delegate TextFieldWithIdentifyItemClick];
    }
}

#pragma mark - lazy load
-(UITextField *)textField
{
    if (!_textField) {
        CGFloat x = 10.0f;
        CGFloat y = 0.0f;
        CGFloat width = self.bounds.size.width - x - IdentifyItemWidth;
        CGFloat height = 19.0f;
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self addSubview:_textField];
    }
    return _textField;
}

-(UIButton *)identifyItem
{
    if (!_identifyItem) {
        CGFloat x = self.bounds.size.width - 10.0f * 2 - IdentifyItemWidth;
        CGFloat y = 0.0f;
        CGFloat width = IdentifyItemWidth;
        CGFloat height = IdentifyItemHeight;
        
        _identifyItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _identifyItem.frame = CGRectMake(x, y, width, height);
        _identifyItem.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        [_identifyItem setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_identifyItem setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateNormal];
        [_identifyItem addTarget:self action:@selector(identifyClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_identifyItem];
    }
    return _identifyItem;
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
