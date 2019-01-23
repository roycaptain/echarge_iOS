//
//  HistoryOrderCell.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "HistoryOrderCell.h"
#import "HistoryOrder.h"

CGFloat const HistoryOrderCellXPoint = 28.0f; // x 坐标
#define ConstLabelWidth [GeneralSize getMainScreenWidth] - HistoryOrderCellXPoint - 20;

@implementation HistoryOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - lazy load
-(UIView *)bjView
{
    if (!_bjView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 90.0f;
        
        _bjView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _bjView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [self.contentView addSubview:_bjView];
    }
    return _bjView;
}

-(UIView *)point
{
    if (!_point) {
        CGFloat x = 13.0f;
        CGFloat y = 18.0f;
        CGFloat width = 7.0f;
        
        _point = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _point.backgroundColor = [UIColor colorWithHexString:@"#999999"];
        _point.layer.cornerRadius = width / 2;
        [_bjView addSubview:_point];
    }
    return _point;
}

-(UILabel *)orderNum
{
    if (!_orderNum) {
        CGFloat x = HistoryOrderCellXPoint;
        CGFloat y = 13.0f;
        CGFloat width = ConstLabelWidth;
        CGFloat height = 17.0f;
        
        _orderNum = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _orderNum.textColor = [UIColor colorWithHexString:@"#333333"];
        _orderNum.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:18.0f];
        _orderNum.textAlignment = NSTextAlignmentLeft;
        _orderNum.adjustsFontSizeToFitWidth = YES;
        [_bjView addSubview:_orderNum];
    }
    return _orderNum;
}

-(UILabel *)orderInfo
{
    if (!_orderInfo) {
        CGFloat x = HistoryOrderCellXPoint;
        CGFloat y = _orderNum.frame.origin.y + _orderNum.frame.size.height + 6.0f;
        CGFloat width = ConstLabelWidth;
        CGFloat height = 12.0f;
        
        _orderInfo = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _orderInfo.font = [UIFont fontWithName:@"PingFang SC" size:12.0f];
        _orderInfo.textAlignment = NSTextAlignmentLeft;
        _orderInfo.adjustsFontSizeToFitWidth = YES;
        [_bjView addSubview:_orderInfo];
    }
    return _orderInfo;
}

-(UILabel *)chargeStation
{
    if (!_chargeStation) {
        CGFloat x = HistoryOrderCellXPoint;
        CGFloat y = _orderInfo.frame.origin.y + _orderInfo.frame.size.height + 6.0f;
        CGFloat width = ConstLabelWidth;
        CGFloat height = 12.0f;
        
        _chargeStation = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _chargeStation.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _chargeStation.textAlignment = NSTextAlignmentLeft;
        _chargeStation.adjustsFontSizeToFitWidth = YES;
        [_bjView addSubview:_chargeStation];
    }
    return _chargeStation;
}

-(UILabel *)date
{
    if (!_date) {
        CGFloat x = HistoryOrderCellXPoint;
        CGFloat y = _chargeStation.frame.origin.y + _chargeStation.frame.size.height + 6.0f;
        CGFloat width = ConstLabelWidth;
        CGFloat height = 9.0f;
        
        _date = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _date.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:9.0f];
        _date.textAlignment = NSTextAlignmentLeft;
        _date.adjustsFontSizeToFitWidth = YES;
        [_bjView addSubview:_date];
    }
    return _date;
}

#pragma mark - initUI
-(void)initUI
{
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
    
    [self bjView];
    [self point];
    [self orderNum];
    [self orderInfo];
    [self chargeStation];
    [self date];
}

#pragma mark -
- (void)setModel:(HistoryOrder *)model
{
    _orderNum.text = model.orderNum;
    _orderInfo.attributedText = model.orderInfo;
    _chargeStation.text = model.chargeStation;
    _date.text = model.date;
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
