//
//  AroundCell.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/29.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "AroundCell.h"
#import "AroundModel.h"

CGFloat const AroundCellXPoint = 15.0f; // x 坐标
CGFloat const AroundCellIconWidth = 14.0f;

@implementation AroundCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - initUI
-(void)initUI
{
    [self stationLabel];
    [self parkImageView];
    [self parkFeeLabel];
    [self distanceImageView];
    [self distanceLabel];
    [self locationIcon];
    [self locationLabel];
//    [self startScore];
//    [self directImageView];
//    [self directLabel];
//    [self exchangeImageView];
//    [self exchnageLabel];
    [self navItem];
}

#pragma mark - lazy load
-(UILabel *)stationLabel
{
    if (!_stationLabel) {
        CGFloat x = AroundCellXPoint;
        CGFloat y = 15.0f;
        CGFloat width = 200.0f;
        CGFloat height = 16.0f;
        
        _stationLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _stationLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _stationLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        _stationLabel.textAlignment = NSTextAlignmentLeft;
        _stationLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_stationLabel];
    }
    return _stationLabel;
}

-(UIImageView *)parkImageView
{
    if (!_parkImageView) {
        CGFloat x = AroundCellXPoint;
        CGFloat y = _stationLabel.frame.origin.y + _stationLabel.frame.size.height + 20.0f;
        CGFloat width = AroundCellIconWidth;
        
        _parkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _parkImageView.image = [UIImage imageNamed:@"parking_fee"];
        [self.contentView addSubview:_parkImageView];
    }
    return _parkImageView;
}

-(UILabel *)parkFeeLabel
{
    if (!_parkFeeLabel) {
        CGFloat x = _parkImageView.frame.origin.x + _parkImageView.frame.size.width + 5.0f;
        CGFloat y = _parkImageView.frame.origin.y;
        CGFloat width = 67.0f;
        CGFloat height = 12.0f;
        
        _parkFeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _parkFeeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _parkFeeLabel.textAlignment = NSTextAlignmentLeft;
        _parkFeeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _parkFeeLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_parkFeeLabel];
    }
    return _parkFeeLabel;
}

-(UIImageView *)distanceImageView
{
    if (!_distanceImageView) {
        CGFloat x = _parkFeeLabel.frame.origin.x + _parkFeeLabel.frame.size.width + 20.0f;
        CGFloat y = _parkImageView.frame.origin.y;
        CGFloat width = AroundCellIconWidth;
        
        _distanceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _distanceImageView.image = [UIImage imageNamed:@"distance"];
        [self.contentView addSubview:_distanceImageView];
    }
    return _distanceImageView;
}

-(UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        CGFloat x = _distanceImageView.frame.origin.x + _distanceImageView.frame.size.width + 5.0f;
        CGFloat y = _parkImageView.frame.origin.y;
        CGFloat width = 100.0f;
        CGFloat height = 12.0f;
        
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _distanceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        _distanceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _distanceLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_distanceLabel];
    }
    return _distanceLabel;
}

-(UIImageView *)locationIcon
{
    if (!_locationIcon) {
        CGFloat x = 15.0f;
        CGFloat y = _distanceImageView.frame.origin.y + _distanceImageView.frame.size.height + 10.0f;
        CGFloat width = 14.0f;
        _locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _locationIcon.image = [UIImage imageNamed:@"place"];
        _locationIcon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_locationIcon];
    }
    return _locationIcon;
}

-(UILabel *)locationLabel
{
    if (!_locationLabel) {
        CGFloat x = _locationIcon.frame.origin.x + _locationIcon.frame.size.width + 5.0f;
        CGFloat y = _locationIcon.frame.origin.y;
        CGFloat width = [GeneralSize getMainScreenWidth] - x - 100;
        CGFloat height = 14.0f;
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _locationLabel.textAlignment = NSTextAlignmentLeft;
        _locationLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _locationLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:_locationLabel];
    }
    return _locationLabel;
}

//-(StartScoreView *)startScore
//{
//    if (!_startScore) {
//        CGFloat x = AroundCellXPoint;
//        CGFloat y = _parkImageView.frame.origin.y + _parkImageView.frame.size.height + 10.0f;
//        CGFloat width = 94.0f;
//        CGFloat height = AroundCellIconWidth;
//
//        _startScore = [[StartScoreView alloc] initWithFrame:CGRectMake(x, y, width, height)];
//        [self.contentView addSubview:_startScore];
//    }
//    return _startScore;
//}

// 直流
//-(UIImageView *)directImageView
//{
//    if (!_directImageView) {
//        CGFloat x = AroundCellXPoint;
//        CGFloat y = _distanceLabel.frame.origin.y + _distanceLabel.frame.size.height + 20.0f;
//        CGFloat width = AroundCellIconWidth;
//
//        _directImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
//        _directImageView.image = [UIImage imageNamed:@"direct_electric"];
//        [self.contentView addSubview:_directImageView];
//    }
//    return _directImageView;
//}

//-(UILabel *)directLabel
//{
//    if (!_directLabel) {
//        CGFloat x = _directImageView.frame.origin.x + _directImageView.frame.size.width + 5.0f;
//        CGFloat y = _directImageView.frame.origin.y;
//        CGFloat width = 123.0f;
//        CGFloat height = 12.0f;
//
//        _directLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
//        _directLabel.textColor = [UIColor colorWithHexString:@"#999999"];
//        _directLabel.textAlignment = NSTextAlignmentLeft;
//        _directLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
//        _directLabel.adjustsFontSizeToFitWidth = YES;
//        [self.contentView addSubview:_directLabel];
//    }
//    return _directLabel;
//}

// 交流
//-(UIImageView *)exchangeImageView
//{
//    if (!_exchangeImageView) {
//        CGFloat x = AroundCellXPoint;
//        CGFloat y = _directImageView.frame.origin.y + _directImageView.frame.size.height + 10.0f;
//        CGFloat width = AroundCellIconWidth;
//
//        _exchangeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
//        _exchangeImageView.image = [UIImage imageNamed:@"exchange_electric"];
//        [self.contentView addSubview:_exchangeImageView];
//    }
//    return _exchangeImageView;
//}
//
//-(UILabel *)exchnageLabel
//{
//    if (!_exchnageLabel) {
//        CGFloat x = _exchangeImageView.frame.origin.x + _exchangeImageView.frame.size.width + 5.0f;
//        CGFloat y = _exchangeImageView.frame.origin.y;
//        CGFloat width = 130.0f;
//        CGFloat height = 12.0f;
//
//        _exchnageLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
//        _exchnageLabel.textColor = [UIColor colorWithHexString:@"#999999"];
//        _exchnageLabel.textAlignment = NSTextAlignmentLeft;
//        _exchnageLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
//        _exchnageLabel.adjustsFontSizeToFitWidth = YES;
//        [self.contentView addSubview:_exchnageLabel];
//    }
//    return _exchnageLabel;
//}

// 导航按钮
-(UIButton *)navItem
{
    if (!_navItem) {
        CGFloat width = 50.0f;
        CGFloat height = 20.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] - 13.0f - width;
        CGFloat y = 13.0f;
        
        _navItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _navItem.frame = CGRectMake(x, y, width, height);
        _navItem.layer.cornerRadius = 3.0f;
        _navItem.layer.masksToBounds = YES;
        _navItem.layer.borderWidth = 1.0f;
        _navItem.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _navItem.layer.borderColor = [UIColor colorWithHexString:@"#333333"].CGColor;
        [_navItem setTitle:@"导航" forState:UIControlStateNormal];
        [_navItem setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [self.contentView addSubview:_navItem];
    }
    return _navItem;
}

#pragma mark -
-(void)setModel:(AroundModel *)model
{
    // 站点名称
    _stationLabel.text = model.stationName;
    // 停车费
    _parkFeeLabel.text = model.parkFee;
    // 距离
    _distanceLabel.text = model.distance;
    // 地点
    _locationLabel.text = model.place;
    // 五星个数
//    [_startScore setScroeWithStartNumber:model.startCount];
    // 直流
//    _directLabel.attributedText = model.direct;
    // 交流
//    _exchnageLabel.text = model.exchange;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
