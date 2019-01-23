//
//  AroundSlideView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/29.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "AroundSlideView.h"

CGFloat const AroundItemContainerHeight = 44.0f; // 按钮容器的高度
CGFloat const AroundItemHeight = 43.0f; // 按钮高度

@implementation AroundSlideView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(UIView *)itemContainerView
{
    if (!_itemContainerView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = AroundItemContainerHeight;
        
        _itemContainerView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self addSubview:_itemContainerView];
    }
    return _itemContainerView;
}

-(UIButton *)disatnceItem
{
    if (!_disatnceItem) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] / 2;
        CGFloat height = AroundItemHeight;
        
        _disatnceItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _disatnceItem.frame = CGRectMake(x, y, width, height);
        [_disatnceItem setTitle:@"距离最近" forState:UIControlStateNormal];
        _disatnceItem.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_disatnceItem setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_disatnceItem setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateSelected];
        [_disatnceItem addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        _disatnceItem.tag = 0;
        _disatnceItem.selected = YES;
        [_itemContainerView addSubview:_disatnceItem];
    }
    return _disatnceItem;
}

-(UIButton *)idleItem
{
    if (!_idleItem) {
        CGFloat x = [GeneralSize getMainScreenWidth] / 2;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] / 2;
        CGFloat height = AroundItemHeight;
        
        _idleItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _idleItem.frame = CGRectMake(x, y, width, height);
        [_idleItem setTitle:@"空闲优先" forState:UIControlStateNormal];
        _idleItem.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_idleItem setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_idleItem setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateSelected];
        [_idleItem addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        _idleItem.tag = 1;
        _idleItem.selected = NO;
        [_itemContainerView addSubview:_idleItem];
    }
    return _idleItem;
}

-(UILabel *)slideLabel
{
    if (!_slideLabel) {
        CGFloat x = 0.0f;
        CGFloat y = AroundItemHeight;
        CGFloat width = [GeneralSize getMainScreenWidth] / 2;
        CGFloat height = 1.0f;
        
        _slideLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _slideLabel.backgroundColor = [UIColor colorWithHexString:@"#02B1CD"];
        [_itemContainerView addSubview:_slideLabel];
    }
    return _slideLabel;
}

#pragma mark - initUI
-(void)initUI
{
    self.selectIndex = 0;
    [self itemContainerView];
    [self disatnceItem];
    [self idleItem];
    [self slideLabel];
}

#pragma mark - private method
// 按钮点击事件
-(void)selectClick:(UIButton *)button
{
    self.selectIndex = button.tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(getAroundSlideSelectedIndex:)]) {
        [self.delegate getAroundSlideSelectedIndex:button.tag];
    }
    [self slideAnimationWithTag:button.tag];
}

// 滑动条滑动
-(void)slideAnimationWithTag:(NSInteger)tag
{
    _disatnceItem.selected = NO;
    _idleItem.selected = NO;
    
    UIButton *button = [self buttonSelectedStatusWithTag:tag];
    button.selected = YES;
    __weak AroundSlideView *weakView = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakView.slideLabel.center = CGPointMake(button.center.x, AroundItemHeight);
    }];
}

// 根据选中的值来返回对应的按钮
-(UIButton *)buttonSelectedStatusWithTag:(NSInteger)tag
{
    if (tag == 0) {
        return _disatnceItem;
    } else if (tag == 1) {
        return _idleItem;
    } else {
        return nil;
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
