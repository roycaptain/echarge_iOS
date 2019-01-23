//
//  ElectricDetailCell.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/13.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ElectricDetailCell.h"
#import "ElectricDetailModel.h"

#define ContentWidth [GeneralSize getMainScreenWidth] / 5
#define ContentHeight self.contentView.frame.size.height

@implementation ElectricDetailCell

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
    [self timeLabel];
    [self unitLabel];
    [self serviceLabel];
    [self actualLabel];
}

#pragma mark - lazy load
// 时间段
-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ContentWidth * 2, ContentHeight)];
        _timeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

// 单价
-(UILabel *)unitLabel
{
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(ContentWidth * 2, 0.0f, ContentWidth, ContentHeight)];
        _unitLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _unitLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _unitLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_unitLabel];
    }
    return _unitLabel;
}

// 服务费
-(UILabel *)serviceLabel
{
    if (!_serviceLabel) {
        _serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ContentWidth * 3, 0.0f, ContentWidth, ContentHeight)];
        _serviceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _serviceLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _serviceLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_serviceLabel];
    }
    return _serviceLabel;
}

// 实际费用
-(UILabel *)actualLabel
{
    if (!_actualLabel) {
        _actualLabel = [[UILabel alloc] initWithFrame:CGRectMake(ContentWidth * 4, 0.0f, ContentWidth, ContentHeight)];
        _actualLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _actualLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _actualLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_actualLabel];
    }
    return _actualLabel;
}

-(void)setModel:(ElectricDetailModel *)model
{
    _model = model;
    _timeLabel.text = model.times;
    _unitLabel.text = model.unitPrice;
    _serviceLabel.text = model.service;
    _actualLabel.text = model.actualFee;
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
