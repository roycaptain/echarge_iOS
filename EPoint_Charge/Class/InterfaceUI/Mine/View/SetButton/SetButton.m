//
//  SetButton.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "SetButton.h"

@implementation SetButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - lzay load
-(UILabel *)headLabel
{
    if (!_headLabel) {
        CGFloat x = 16.0f;
        CGFloat y = 19.0f;
        CGFloat width = 71.0f;
        CGFloat height = 17.0f;
        
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _headLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _headLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_headLabel];
    }
    return _headLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        CGFloat width = 52.0f;
        CGFloat height = 14.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] - width - 16.0f;
        CGFloat y = 19.0f;
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _detailLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _detailLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_detailLabel];
    }
    return _detailLabel;
}

-(UIImageView *)accessoryImage
{
    if (!_accessoryImage) {
        CGFloat width = 9.0f;
        CGFloat height = 18.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] - width - 15.0f;
        CGFloat y = 19.0f;
        
        _accessoryImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _accessoryImage.hidden = YES;
        [_accessoryImage setImage:[UIImage imageNamed:@"cell_accessory"]];
        [self addSubview:_accessoryImage];
    }
    return _accessoryImage;
}

#pragma mark - private method
-(void)initUI
{
    [self setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    
    [self headLabel];
    [self detailLabel];
    [self accessoryImage];
}

- (void)setSetButtonHeadTitle:(NSString *)title
{
    _headLabel.text = title;
}

- (void)setSetButtonDetailTitle:(NSString *)detailLabel
{
    _detailLabel.text = detailLabel;
}

-(void)setSetButtonAccessoryImageView
{
    _accessoryImage.hidden = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
