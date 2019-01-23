//
//  DDTextField.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/16.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "DDTextField.h"

@implementation DDTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 11)];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];
        
        _underLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        _underLine.backgroundColor = [UIColor grayColor];
        [self addSubview:_underLine];
    }
    return self;
}

/*
 @param NSString *placeHolder 默认值
 @param CGFloat value 字体大小
 @param UIColor *placeHolderColor 默认值字体颜色
 */
- (void)setPlaceHolder:(NSString *)placeHolder andHolderFontOfSize:(CGFloat)value andPlaceHolderColor:(UIColor *)placeHolderColor
{
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:placeHolder];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:placeHolderColor
                        range:NSMakeRange(0, placeHolder.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:value]
                        range:NSMakeRange(0, placeHolder.length)];
    _textField.attributedPlaceholder = placeholder;
}

/*
 @param UIColor *underLineDefaultColor // 默认下划线的颜色
 @param UIColor *underLineSelectedColor // 选中下划线的颜色
 */
-(void)setUnderLineDefaultColor:(UIColor *)underLineDefaultColor andunderLineSelectedColor:(UIColor *)underLineSelectedColor
{
    _underLine.backgroundColor = underLineDefaultColor;
    _underLineDefaultColor = underLineDefaultColor;
    _underLineSelectedColor = underLineSelectedColor;
}

#pragma TextField private method
-(void)textFieldDidChange:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ddTextfieldDidChange:)]) {
        [self.delegate ddTextfieldDidChange:textField.text];
    }
}


#pragma UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _underLine.backgroundColor = _underLineSelectedColor;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _underLine.backgroundColor = _underLineDefaultColor;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 四位加一个空格
    if ([string isEqualToString:@""]) { // 删除字符
        if ((textField.text.length - 2) % 5 == 0) {
            textField.text = [textField.text substringToIndex:textField.text.length - 1];
        }
    } else {
        if (textField.text.length % 5 == 0) {
            textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
        }
    }
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
