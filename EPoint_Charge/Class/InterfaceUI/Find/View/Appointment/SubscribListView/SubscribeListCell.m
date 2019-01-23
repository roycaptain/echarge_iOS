//
//  SubscribeListCell.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/6.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import "SubscribeListCell.h"
#import "SubscribModel.h"

@interface SubscribeListCell ()

@property(nonatomic,strong)UILabel *siteLabel; // 充电桩名称
// 停车费
@property(nonatomic,strong)UIImageView *parkIcon;
@property(nonatomic,strong)UILabel *parkFeeLabel;
// 距离
@property(nonatomic,strong)UIImageView *distanceIcon;
@property(nonatomic,strong)UILabel *distanceLabel;
// 地点
@property(nonatomic,strong)UIImageView *locationIcon;
@property(nonatomic,strong)UILabel *locationLabel;
// 直流
//@property(nonatomic,strong)UIImageView *directIcon;
//@property(nonatomic,strong)UILabel *directLabel;
// 交流
//@property(nonatomic,strong)UIImageView *exchangeIcon;
//@property(nonatomic,strong)UILabel *exchangeLabel;

@end

@implementation SubscribeListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - createUI
-(void)createUI
{
    [self siteLabel];
    [self parkIcon];
    [self parkFeeLabel];
    [self distanceIcon];
    [self distanceLabel];
    [self locationIcon];
    [self locationLabel];
//    [self directIcon];
//    [self directLabel];
//    [self exchangeIcon];
//    [self exchangeLabel];
    
    [self navItem];
    [self subscribeItem];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_model.isSupportOrder) {
        self.subscribeItem.hidden = NO;
    }
}

#pragma mark - private method
-(void)setModel:(SubscribModel *)model
{
    _model = model;
    _siteLabel.text = model.deviceName;
    _parkFeeLabel.text = model.parkFee;
    _distanceLabel.text = model.distance;
    _locationLabel.text = model.place;
}

#pragma mark - lazy load
-(UILabel *)siteLabel
{
    if (!_siteLabel) {
        CGFloat x = 15.0f;
        CGFloat y = 15.0f;
        CGFloat width = 180.0f;
        CGFloat height = 17.0f;
        _siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _siteLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _siteLabel.textAlignment = NSTextAlignmentLeft;
        _siteLabel.font = [UIFont systemFontOfSize:17.0f];
        [self.contentView addSubview:_siteLabel];
    }
    return _siteLabel;
}

-(UIImageView *)parkIcon
{
    if (!_parkIcon) {
        CGFloat x = 15.0f;
        CGFloat y = _siteLabel.frame.origin.y + _siteLabel.frame.size.height + 10.0f;
        CGFloat width = 14.0f;
        _parkIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _parkIcon.image = [UIImage imageNamed:@"parking_fee"];
        _parkIcon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_parkIcon];
    }
    return _parkIcon;
}

-(UILabel *)parkFeeLabel
{
    if (!_parkFeeLabel) {
        CGFloat x = _parkIcon.frame.origin.x + _parkIcon.frame.size.width + 5.0f;
        CGFloat y = _parkIcon.frame.origin.y;
        CGFloat width = 80.0f;
        CGFloat height = 14.0f;
        _parkFeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _parkFeeLabel.textAlignment = NSTextAlignmentLeft;
        _parkFeeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _parkFeeLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:_parkFeeLabel];
    }
    return _parkFeeLabel;
}

-(UIImageView *)distanceIcon
{
    if (!_distanceIcon) {
        CGFloat x = _parkFeeLabel.frame.origin.x + _parkFeeLabel.frame.size.width + 10.0f;
        CGFloat y = _parkIcon.frame.origin.y;
        CGFloat width = 14.0f;
        _distanceIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _distanceIcon.image = [UIImage imageNamed:@"distance"];
        _distanceIcon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_distanceIcon];
    }
    return _distanceIcon;
}

-(UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        CGFloat x = _distanceIcon.frame.origin.x + _distanceIcon.frame.size.width + 5.0f;
        CGFloat y = _parkIcon.frame.origin.y;
        CGFloat width = 100.0f;
        CGFloat height = 14.0f;
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        _distanceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _distanceLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:_distanceLabel];
    }
    return _distanceLabel;
}

-(UIImageView *)locationIcon
{
    if (!_locationIcon) {
        CGFloat x = 15.0f;
        CGFloat y = _parkIcon.frame.origin.y + _parkIcon.frame.size.height + 10.0f;
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

//-(UIImageView *)directIcon
//{
//    if (!_directIcon) {
//        CGFloat x = 15.0f;
//        CGFloat y = _locationIcon.frame.origin.y + _locationIcon.frame.size.height + 10.0f;
//        CGFloat width = 14.0f;
//        _directIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
//        _directIcon.image = [UIImage imageNamed:@"direct_electric"];
//        _directIcon.contentMode = UIViewContentModeScaleAspectFill;
//        [self.contentView addSubview:_directIcon];
//    }
//    return _directIcon;
//}
//
//-(UILabel *)directLabel
//{
//    if (!_directLabel) {
//        CGFloat x = _directIcon.frame.origin.x + _directIcon.frame.size.width + 5.0f;
//        CGFloat y = _directIcon.frame.origin.y;
//        CGFloat width = 250.0f;
//        CGFloat height = 14.0f;
//        _directLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
//        _directLabel.textAlignment = NSTextAlignmentLeft;
//        _directLabel.textColor = [UIColor colorWithHexString:@"#999999"];
//        _directLabel.font = [UIFont systemFontOfSize:12.0f];
//        _directLabel.text = @"直流：空闲 8 /总数 18";
//        [self.contentView addSubview:_directLabel];
//    }
//    return _directLabel;
//}
//
//-(UIImageView *)exchangeIcon
//{
//    if (!_exchangeIcon) {
//        CGFloat x = 15.0f;
//        CGFloat y = _directIcon.frame.origin.y + _directIcon.frame.size.height + 10.0f;
//        CGFloat width = 14.0f;
//        _exchangeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
//        _exchangeIcon.image = [UIImage imageNamed:@"exchange_electric"];
//        _exchangeIcon.contentMode = UIViewContentModeScaleAspectFill;
//        [self.contentView addSubview:_exchangeIcon];
//    }
//    return _exchangeIcon;
//}
//
//-(UILabel *)exchangeLabel
//{
//    if (!_exchangeLabel) {
//        CGFloat x = _exchangeIcon.frame.origin.x + _exchangeIcon.frame.size.width + 5.0f;
//        CGFloat y = _exchangeIcon.frame.origin.y;
//        CGFloat width = 250.0f;
//        CGFloat height = 14.0f;
//        _exchangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
//        _exchangeLabel.textAlignment = NSTextAlignmentLeft;
//        _exchangeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
//        _exchangeLabel.font = [UIFont systemFontOfSize:12.0f];
//        _exchangeLabel.text = @"交流：空闲 1 /总数 9";
//        [self.contentView addSubview:_exchangeLabel];
//    }
//    return _exchangeLabel;
//}

-(CellNavItem *)navItem
{
    if (!_navItem) {
        CGFloat width = 80.0f;
        CGFloat height = 34.0f;
        CGFloat x  = [GeneralSize getMainScreenWidth] - width - 15.0f;
        CGFloat y = 15.0f;
        
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

-(CellNavItem *)subscribeItem
{
    if (!_subscribeItem) {
        CGFloat width = 80.0f;
        CGFloat height = 34.0f;
        CGFloat x  = [GeneralSize getMainScreenWidth] - width - 15.0f;
        CGFloat y = _navItem.frame.origin.y + _navItem.frame.size.height + 10.0f;
        
        _subscribeItem = [CellNavItem buttonWithType:UIButtonTypeCustom];
        _subscribeItem.frame = CGRectMake(x, y, width, height);
        [_subscribeItem setCellNavItemHeadTitle:@"预约"];
        [_subscribeItem setCellNavItemImageWithImageNamed:@"icon_subscribe_item"];
        _subscribeItem.layer.cornerRadius = 17.0f;
        _subscribeItem.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
        _subscribeItem.layer.borderWidth = 1.0f;
        _subscribeItem.hidden = YES;
        [self.contentView addSubview:_subscribeItem];
    }
    return _subscribeItem;
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
