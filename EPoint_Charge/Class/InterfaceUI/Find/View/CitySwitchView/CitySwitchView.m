//
//  CitySwitchView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/2.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "CitySwitchView.h"

@implementation CitySwitchView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        
        self.itemNum = 0;
    }
    return self;
}

#pragma mark - initUI
-(void)initUI
{
    [self titleView];
    [self titleLabel];
    [self itemView];
}

#pragma mark - lazy load
-(UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], 30.0f)];
        _titleView.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
        [self addSubview:_titleView];
    }
    return _titleView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 8.0f, 70.0f, 16.0f)];
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [_titleView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UIView *)itemView
{
    if (!_itemView) {
        _itemView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 30.0f, [GeneralSize getMainScreenWidth], 55.0f)];
        _itemView.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
        [self addSubview:_itemView];
    }
    return _itemView;
}

-(UIButton *)locationItem
{
    if (!_locationItem) {
        CGFloat width = 40.0f;
        CGFloat height = 35.0f;
        CGFloat x = self.frame.size.width - width - 40.0f;
        CGFloat y = 10.0f;
        
        _locationItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationItem.frame = CGRectMake(x, y, width, height);
        [_locationItem setTitle:@"定位" forState:UIControlStateNormal];
        [_locationItem setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateNormal];
        _locationItem.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        [_locationItem addTarget:self action:@selector(setLocationCity) forControlEvents:UIControlEventTouchUpInside];
        [self.itemView addSubview:_locationItem];
    }
    return _locationItem;
}

#pragma mark - private method
// 设置标题
-(void)setTitleLabelWithText:(NSString *)title
{
    self.titleLabel.text = title;
}

// 设置定位按钮
-(void)setLocationItem
{
    [self locationItem];
}

// 设置按钮
-(void)setCityItemWithItemArray:(NSArray *)items
{
    NSUInteger num = items.count;
    
    if (num == 0) {
        return;
    }
    
    CGFloat itemSpace = 10.0f;
    CGFloat itemWidth = ([GeneralSize getMainScreenWidth] - itemSpace * 4) / 3; // 每个按钮的宽度
    CGFloat itemHeight = 35.0f; // 每个按钮的高度
    
    for (NSUInteger i = 0; i < num; i++) {

        CGFloat x = itemSpace + (itemWidth + itemSpace) * i;
        CGFloat y = itemSpace;
        
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(x, y, itemWidth, itemHeight);
        [item setTitle:items[i] forState:UIControlStateNormal];
        [item setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [item setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        item.layer.cornerRadius = 4.0f;
        item.layer.masksToBounds = YES;
        item.layer.borderWidth = 1.0f;
        item.layer.borderColor = [UIColor colorWithHexString:@"#A6A6A6"].CGColor;
        [item addTarget:self action:@selector(cityClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemView addSubview:item];
    }
}

#pragma mark - click
// 定位按钮
-(void)setLocationCity
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(citySwitchLocationWithName)]) {
        [self.delegate citySwitchLocationWithName];
    }
}

-(void)cityClick:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cityItemClickWithCity:)]) {
        [self.delegate cityItemClickWithCity:button.titleLabel.text];
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
