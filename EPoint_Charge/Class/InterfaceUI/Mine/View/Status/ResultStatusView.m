//
//  ResultStatusView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ResultStatusView.h"

@implementation ResultStatusView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        
    }
    return self;
}

#pragma mark - lazy load
-(UIImageView *)statusImage
{
    if (!_statusImage) {
        CGFloat width = 100.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] / 2 - width / 2;
        CGFloat y = 0.0f;

        _statusImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        [self addSubview:_statusImage];
    }
    return _statusImage;
}

-(UILabel *)title
{
    if (!_title) {
        CGFloat x = 0.0f;
        CGFloat y = _statusImage.frame.origin.y + _statusImage.frame.size.height + 20.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 17.0f;
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _title.textColor = [UIColor colorWithHexString:@"#333333"];
        _title.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_title];
    }
    return _title;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _title.frame.origin.y + _title.frame.size.height + 10.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 13.0f;
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _detailLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _detailLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_detailLabel];
    }
    return _detailLabel;
}

#pragma mark - initUI
-(void)initUI
{
    [self statusImage];
    [self title];
    [self detailLabel];
}

#pragma mark - private method
-(void)setStatusImageViewWithImageName:(NSString *)imageName
{
    _statusImage.image = [UIImage imageNamed:imageName];
}

-(void)setStatusTitle:(NSString *)title
{
    _title.text = title;
}

-(void)setStatusDetailTitle:(NSString *)detailTitle
{
    _detailLabel.text = detailTitle;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
