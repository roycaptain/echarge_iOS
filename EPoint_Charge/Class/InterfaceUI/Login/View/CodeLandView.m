//
//  CodeLandView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/21.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "CodeLandView.h"

@implementation CodeLandView

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
    [self identifyField];
}

#pragma mark -lazy load
-(LoginTextField *)accountField
{
    if (!_accountField) {
        CGFloat x = 30.0f;
        CGFloat y = 35.0f;
        CGFloat width = self.bounds.size.width - x * 2;
        CGFloat height = 25.0f;
        _accountField =  [[LoginTextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_accountField setTextFieldPlaceHolder:@"请输入手机号码"];
        [self addSubview:_accountField];
    }
    return _accountField;
}

-(TextFieldWithIdentifyItem *)identifyField
{
    if (!_identifyField) {
        CGFloat x = 30.0f;
        CGFloat y =  90.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 25.0f;

        _identifyField = [[TextFieldWithIdentifyItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_identifyField setTextFieldPlaceHolder:@"请输入验证码"];
        _identifyField.delegate = self;
        [self addSubview:_identifyField];
    }
    return _identifyField;
}

#pragma mark - TextFieldWithIdentifyItemDelegate
-(void)TextFieldWithIdentifyItemClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(codeLandViewIdentifyItemClick)]) {
        [self.delegate codeLandViewIdentifyItemClick];
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
