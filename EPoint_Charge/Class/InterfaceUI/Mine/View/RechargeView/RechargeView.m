//
//  RechargeView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "RechargeView.h"

NSUInteger const ColCount = 3; //每行的个数
CGFloat const ItemHeight = 40.0f; // 按钮的高度
CGFloat const BetweenSpace = 11.0f; // 间距
NSString *const NormalColor = @"#D2D2D2"; // 正常颜色
NSString *const SelectColor = @"#32CFC1"; // 选中颜色
#define ItemWidth ([GeneralSize getMainScreenWidth] - BetweenSpace * 4) / 3 // 按钮的宽度

@implementation RechargeView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createButtons];
    }
    return self;
}

#pragma mark - initUI
-(void)createButtons
{
    NSArray *titleArray = @[@"10",@"20",@"50",@"100",@"200",@"500"];
    for (NSUInteger i = 0; i < titleArray.count ; i++) {
        // 按钮所在的行
        NSUInteger row = i / ColCount;
        // 按钮所在的列
        NSUInteger col = i % ColCount;
        // 按钮的坐标
        CGFloat itemX = BetweenSpace + (ItemWidth + BetweenSpace) * col;
        CGFloat itemY = BetweenSpace + (ItemHeight + BetweenSpace) * row;
        // 按钮的名字
        NSString *title = [NSString stringWithFormat:@"%@元",titleArray[i]];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(itemX, itemY, ItemWidth, ItemHeight);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:NormalColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:SelectColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        button.layer.cornerRadius = 5.0f;
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [UIColor colorWithHexString:NormalColor].CGColor;
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
            _selectItem = button;
        }
        
        [self addSubview:button];
    }
}

#pragma mark - click
-(void)itemClick:(UIButton *)button
{
    if (_selectItem != button) {
        _selectItem.selected = NO;
        _selectItem.layer.borderColor = [UIColor colorWithHexString:NormalColor].CGColor;
        
        button.selected = YES;
        button.layer.borderColor = [UIColor colorWithHexString:SelectColor].CGColor;
        _selectItem = button;
    } else {
        _selectItem.selected = YES;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(rechargeItemClickWithTitle:)]) {
        [self.delegate rechargeItemClickWithTitle:button.titleLabel.text];
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
