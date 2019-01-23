//
//  SearchBarView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/27.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "SearchBarView.h"

@implementation SearchBarView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 17.0f;
        self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(UIImageView *)searchIcon
{
    if (!_searchIcon) {
        CGFloat width = 18.0f;
        CGFloat x = 10.0f;
        CGFloat y = 9.0f;
        
        _searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        [_searchIcon setImage:[UIImage imageNamed:@"search_magnifier"]];
        [self addSubview:_searchIcon];
    }
    return _searchIcon;
}

-(UITextField *)searchTextField
{
    if (!_searchTextField) {
        CGFloat x = _searchIcon.frame.origin.x + _searchIcon.frame.size.width + 9.0f;
        CGFloat y = 0.0f;
        CGFloat width = self.frame.size.width - x;
        CGFloat height = self.frame.size.height;
        
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _searchTextField.delegate = self;
        _searchTextField.placeholder = @"请输入要查找的地名";
        _searchTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
        [self addSubview:_searchTextField];
    }
    return _searchTextField;
}

#pragma mark - initUI
-(void)initUI
{
    [self searchIcon];
    [self searchTextField];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldBeginEditing)]) {
        [self.delegate textFieldBeginEditing];
    }
    [textField resignFirstResponder];
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
