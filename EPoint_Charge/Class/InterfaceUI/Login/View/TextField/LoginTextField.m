//
//  LoginTextField.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/21.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self textField];
        [self underLine];
    }
    return self;
}

#pragma mark - lazy load
-(UITextField *)textField
{
    if (!_textField) {
        CGFloat x = 10.0f;
        CGFloat y = 0.0f;
        CGFloat width = self.frame.size.width - x * 2;
        CGFloat height = 19.0f;
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _textField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_textField];
    }
    return _textField;
}

-(UILabel *)underLine
{
    if (!_underLine) {
        CGFloat x = 0.0f;
        CGFloat y = _textField.frame.origin.y + _textField.frame.size.height + 5.0f;
        CGFloat width = self.frame.size.width;
        CGFloat height = 1.0f;
        _underLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _underLine.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
        [self addSubview:_underLine];
    }
    return _underLine;
}

#pragma mark - private method
-(void)setTextFieldPlaceHolder:(NSString *)placeholder
{
    _textField.placeholder = placeholder;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
