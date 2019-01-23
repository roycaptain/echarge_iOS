//
//  CellNavItem.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/24.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "CellNavItem.h"

@implementation CellNavItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(UIImageView *)navImage
{
    if (!_navImage) {
        CGFloat x = 16.0f;
        CGFloat y = 10.0f;
        CGFloat width = 13.0f;
        CGFloat height = 14.0f;
        
        _navImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_navImage setImage:[UIImage imageNamed:@"nav_item"]];
        [self addSubview:_navImage];
    }
    return _navImage;
}

-(UILabel *)headLabel
{
    if (!_headLabel) {
        CGFloat width = 28.0f;
        CGFloat height = 13.0f;
        CGFloat x = _navImage.frame.origin.x + _navImage.frame.size.width + 7.0f;
        CGFloat y = _navImage.frame.origin.y;
        
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
        _headLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_headLabel];
    }
    return _headLabel;
}


#pragma mark - initUI
-(void)initUI
{
    [self navImage];
    [self headLabel];
}

#pragma mark - private method
-(void)setCellNavItemHeadTitle:(NSString *)title
{
    _headLabel.text = title;
}

-(void)setCellNavItemImageWithImageNamed:(NSString *)imageNamed
{
    _navImage.image = [UIImage imageNamed:imageNamed];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
