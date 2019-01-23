//
//  CollectCell.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/24.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "CollectCell.h"
#import "CollectModel.h"

CGFloat const CollectCellXPoint = 15.0f; // x坐标
CGFloat const UpDownSapce = 10.0f; // 上下间隔

@implementation CollectCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(UILabel *)chargePoleLabel
{
    if (!_chargePoleLabel) {
        CGFloat x = CollectCellXPoint;
        CGFloat y = CollectCellXPoint;
        CGFloat width = 200.0f;
        CGFloat height = 17.0f;
        
        _chargePoleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _chargePoleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _chargePoleLabel.font = [UIFont fontWithName:@"PingFang-SC-Heavy" size:18.0f];
        _chargePoleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_chargePoleLabel];
    }
    return _chargePoleLabel;
}

-(UIImageView *)parkingImageView
{
    if (!_parkingImageView) {
        CGFloat x = CollectCellXPoint;
        CGFloat y = _chargePoleLabel.frame.origin.y + _chargePoleLabel.frame.size.height + UpDownSapce;
        CGFloat width = 14.0f;
        
        _parkingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        [_parkingImageView setImage:[UIImage imageNamed:@"parking_fee"]];
        [self.contentView addSubview:_parkingImageView];
    }
    return _parkingImageView;
}

-(UILabel *)parkingFeeLabel
{
    if (!_parkingFeeLabel) {
        CGFloat x = _parkingImageView.frame.origin.x + _parkingImageView.frame.size.width + 5.0f;
        CGFloat y = _parkingImageView.frame.origin.y;
        CGFloat width = 70.0f;
        CGFloat height = 14.0f;
        
        _parkingFeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _parkingFeeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _parkingFeeLabel.textAlignment = NSTextAlignmentLeft;
        _parkingFeeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        [self.contentView addSubview:_parkingFeeLabel];
    }
    return _parkingFeeLabel;
}

-(UIImageView *)distanceImageView
{
    if (!_distanceImageView) {
        CGFloat x = _parkingFeeLabel.frame.origin.x + _parkingFeeLabel.frame.size.width + 30.0f;
        CGFloat y = _parkingImageView.frame.origin.y;
        CGFloat width = 14.0f;
        
        _distanceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        [_distanceImageView setImage:[UIImage imageNamed:@"distance"]];
        [self.contentView addSubview:_distanceImageView];
    }
    return _distanceImageView;
}

-(UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        CGFloat x = _distanceImageView.frame.origin.x + _distanceImageView.frame.size.width + 5.0f;
        CGFloat y = _parkingImageView.frame.origin.y;
        CGFloat width = 65.0f;
        CGFloat height = 14.0f;
        
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _distanceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        _distanceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _distanceLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_distanceLabel];
    }
    return _distanceLabel;
}

-(UIImageView *)placeImageView
{
    if (!_placeImageView) {
        CGFloat x = CollectCellXPoint;
        CGFloat y = _parkingImageView.frame.origin.y + _parkingImageView.frame.size.height + UpDownSapce;
        CGFloat width = 12.0f;
        CGFloat height = 14.0f;
        
        _placeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_placeImageView setImage:[UIImage imageNamed:@"place"]];
        [self.contentView addSubview:_placeImageView];
    }
    return _placeImageView;
}

-(UILabel *)placeLabel
{
    if (!_placeLabel) {
        CGFloat x = _placeImageView.frame.origin.x + _placeImageView.frame.size.width + 5.0f;
        CGFloat y = _placeImageView.frame.origin.y;
        CGFloat width = 200.0f;
        CGFloat height = 14.0f;
        
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _placeLabel.textAlignment = NSTextAlignmentLeft;
        _placeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _placeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _placeLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_placeLabel];
    }
    return _placeLabel;
}

-(UIImageView *)directImageView
{
    if (!_directImageView) {
        CGFloat x = CollectCellXPoint;
        CGFloat y = _placeImageView.frame.origin.y + _placeImageView.frame.size.height + UpDownSapce;
        CGFloat width = 12.0f;
        CGFloat height = 14.0f;
        
        _directImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_directImageView setImage:[UIImage imageNamed:@"direct_electric"]];
        [self.contentView addSubview:_directImageView];
    }
    return _directImageView;
}

-(UILabel *)directLabel
{
    if (!_directLabel) {
        CGFloat x = _directImageView.frame.origin.x + _directImageView.frame.size.width + 5.0f;
        CGFloat y = _directImageView.frame.origin.y;
        CGFloat width = 125.0f;
        CGFloat height = 14.0f;
        
        _directLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _directLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_directLabel];
    }
    return _directLabel;
}

-(UIImageView *)exchangeImageView
{
    if (!_exchangeImageView) {
        CGFloat x = CollectCellXPoint;
        CGFloat y = _directImageView.frame.origin.y + _directImageView.frame.size.height + UpDownSapce;
        CGFloat width = 12.0f;
        CGFloat height = 14.0f;
        
        _exchangeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_exchangeImageView setImage:[UIImage imageNamed:@"exchange_electric"]];
        [self.contentView addSubview:_exchangeImageView];
    }
    return _exchangeImageView;
}

-(UILabel *)exchangeLabel
{
    if (!_exchangeLabel) {
        CGFloat x = _exchangeImageView.frame.origin.x + _exchangeImageView.frame.size.width + 5.0f;
        CGFloat y = _exchangeImageView.frame.origin.y;
        CGFloat width = 125.0f;
        CGFloat height = 14.0f;
        
        _exchangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _exchangeLabel.textAlignment = NSTextAlignmentLeft;
        _exchangeLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_exchangeLabel];
    }
    return _exchangeLabel;
}

-(CellNavItem *)navItem
{
    if (!_navItem) {
        CGFloat width = 80.0f;
        CGFloat height = 34.0f;
        CGFloat x  = [GeneralSize getMainScreenWidth] - width - 34.0f;
        CGFloat y = 56.0f;
        
        _navItem = [CellNavItem buttonWithType:UIButtonTypeCustom];
        _navItem.frame = CGRectMake(x, y, width, height);
        [_navItem setCellNavItemHeadTitle:@"导航"];
        [_navItem setCellNavItemImageWithImageNamed:@"nav_item"];
        _navItem.layer.cornerRadius = 17.0f;
        _navItem.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
        _navItem.layer.borderWidth = 1.0f;
        [self.contentView addSubview:_navItem];
    }
    return _navItem;
}

#pragma mark - initUI
-(void)initUI
{
    [self chargePoleLabel];
    
    [self parkingImageView];
    [self parkingFeeLabel];
    [self distanceImageView];
    [self distanceLabel];
    
    [self placeImageView];
    [self placeLabel];
    
    [self directImageView];
    [self directLabel];
    
//    [self exchangeImageView];
//    [self exchangeLabel];
    
    [self navItem];
}

-(void)setModel:(CollectModel *)model
{
    _model = model;
    _chargePoleLabel.text = model.chargePole; // 充电桩
    _parkingFeeLabel.text = model.parkingFee; //停车费
    _distanceLabel.text = model.distance; // 距离
    _placeLabel.text = model.place; // 地点
    _directLabel.attributedText = model.direct; // 直流
    _exchangeLabel.attributedText = model.exchange; // 交流
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
