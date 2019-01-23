//
//  PWLandView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/21.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "PWLandView.h"

@implementation PWLandView

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
    [self accountField];
    [self passWordField];
}

#pragma mark - lazy load
-(LoginTextField *)accountField
{
    if (!_accountField) {
        CGFloat x = 30.0f;
        CGFloat y = 35.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 25.0f;
        
        _accountField = [[LoginTextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_accountField setTextFieldPlaceHolder:@"请输入手机号码"];
        [self addSubview:_accountField];
    }
    return _accountField;
}

-(TextFieldWithSecuryItem *)passWordField
{
    if (!_passWordField) {
        CGFloat x = 30.0f;
        CGFloat y = _accountField.frame.origin.y + _accountField.frame.size.height + 30.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 25.0f;
        
        _passWordField = [[TextFieldWithSecuryItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_passWordField setTextFieldPlaceHolder:@"请输入密码"];
        [self addSubview:_passWordField];
    }
    return _passWordField;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
