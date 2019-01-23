//
//  InfoView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/27.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "InfoView.h"
#import "ChargeAnnotation.h"

CGFloat const DistanceLeftSpace = 15.0f; // 距离左边距离
CGFloat const InfoUpDownSapce = 20.0f; // 上下控件的距离
CGFloat const IconWidth = 14.0f; // 图标的宽度
#define LabelWidth ([GeneralSize getMainScreenWidth] - DistanceLeftSpace - IconWidth - 5.0f ) /3 // 默认宽度

@implementation InfoView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        
        [self initUI];
    }
    return self;
}

#pragma mark - initUI
-(void)initUI
{
    [self poleLabel];
    [self parkImageView];
    [self parkLabel];
    [self electLabel];
    [self serviceLabel];
    [self collectItem];
    [self electricDetail];
    [self placeImageView];
    [self placeLabel];
    [self distanceImangeView];
    [self distanceLabel];
    [self directElecImageView];
    [self directElecLabel];
//    [self exchangeImageView];
//    [self exchangeLabel];
    [self carrierImageView];
    [self carrierLabel];
    [self cutLine];
    [self navItem];

}

#pragma mark - lazy load
-(UILabel *)poleLabel
{
    if (!_poleLabel) {
        CGFloat x = DistanceLeftSpace;
        CGFloat y = 30.0f;
        CGFloat width = 200.0f;
        CGFloat height = 18.0f;
        
        _poleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _parkLabel.backgroundColor = [UIColor redColor];
        _poleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _poleLabel.textAlignment = NSTextAlignmentLeft;
        _poleLabel.font = [UIFont fontWithName:@"PingFang-SC-Mediumx" size:18.0f];
        [self addSubview:_poleLabel];
    }
    return _poleLabel;
}

-(UIButton *)collectItem
{
    if (!_collectItem) {
        CGFloat width = 22.0f;
        CGFloat x = self.frame.size.width - width - 15.0f;
        CGFloat y = 20.0f;
        
        _collectItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectItem.frame = CGRectMake(x, y, width, width);
        [_collectItem addTarget:self action:@selector(collectClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_collectItem];
    }
    return _collectItem;
}

-(UIButton *)electricDetail
{
    if (!_electricDetail) {
        CGFloat width = 80.0f;
        CGFloat height = 20.0f;
        CGFloat x = _collectItem.frame.origin.x - width - 30.0f;
        CGFloat y = _collectItem.frame.origin.y;
    
        _electricDetail = [UIButton buttonWithType:UIButtonTypeCustom];
        _electricDetail.frame = CGRectMake(x, y, width, height);
        [_electricDetail setTitle:@"电价详情" forState:UIControlStateNormal];
        [_electricDetail setImage:[UIImage imageNamed:@"right_icon"] forState:UIControlStateNormal];
        _electricDetail.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
        
        CGFloat imageWidth = _electricDetail.imageView.bounds.size.width;
        CGFloat labelWidth = _electricDetail.titleLabel.bounds.size.width;
        _electricDetail.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+5, 0, -labelWidth-5);
        _electricDetail.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    
        [_electricDetail setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateNormal];
        [_electricDetail addTarget:self action:@selector(checkElectricDetail) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_electricDetail];
    }
    return _electricDetail;
}

-(UIImageView *)parkImageView
{
    if (!_parkImageView) {
        CGFloat x = DistanceLeftSpace;
        CGFloat y = InfoUpDownSapce + _poleLabel.frame.origin.y + _poleLabel.frame.size.height;
        CGFloat width = IconWidth;
        
        _parkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _parkImageView.image = [UIImage imageNamed:@"parking_fee"];
        [self addSubview:_parkImageView];
    }
    return _parkImageView;
}

-(UILabel *)parkLabel
{
    if (!_parkLabel) {
        CGFloat x = _parkImageView.frame.origin.x + _parkImageView.frame.size.width + 5.0f;
        CGFloat y = _parkImageView.frame.origin.y;
        CGFloat width = LabelWidth;
        CGFloat height = 12.0f;
        
        _parkLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _parkLabel.textAlignment = NSTextAlignmentLeft;
        _parkLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _parkLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:_parkLabel];
    }
    return _parkLabel;
}

-(UILabel *)electLabel
{
    if (!_electLabel) {
        CGFloat x = _parkLabel.frame.origin.x + _parkLabel.frame.size.width;
        CGFloat y = _parkImageView.frame.origin.y;
        CGFloat width = LabelWidth;
        CGFloat height = 12.0f;
        
        _electLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _electLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _electLabel.textAlignment = NSTextAlignmentLeft;
        _electLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:_electLabel];
    }
    return _electLabel;
}

-(UILabel *)serviceLabel
{
    if (!_serviceLabel) {
        CGFloat x = _electLabel.frame.origin.x + _electLabel.frame.size.width;
        CGFloat y = _parkImageView.frame.origin.y;
        CGFloat width = LabelWidth;
        CGFloat height = 12.0f;
        
        _serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _serviceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _serviceLabel.textAlignment = NSTextAlignmentLeft;
        _serviceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:_serviceLabel];
    }
    return _serviceLabel;
}

-(UIImageView *)placeImageView
{
    if (!_placeImageView) {
        CGFloat width = IconWidth;
        CGFloat x = DistanceLeftSpace;
        CGFloat y = InfoUpDownSapce + _parkImageView.frame.origin.y + _parkImageView.frame.size.height;
        
        _placeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _placeImageView.image = [UIImage imageNamed:@"place"];
        [self addSubview:_placeImageView];
    }
    return _placeImageView;
}

-(UILabel *)placeLabel
{
    if (!_placeLabel) {
        CGFloat x = _placeImageView.frame.origin.x + _placeImageView.frame.size.width + 5.0f;
        CGFloat y = _placeImageView.frame.origin.y;
        CGFloat width = [GeneralSize getMainScreenWidth] - x - 100.0f;
        CGFloat height = 12.0f;
        
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _placeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _placeLabel.textAlignment = NSTextAlignmentLeft;
        _placeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _placeLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_placeLabel];
    }
    return _placeLabel;
}

-(UIImageView *)distanceImangeView
{
    if (!_distanceImangeView) {
        CGFloat width = IconWidth;
        CGFloat x = _placeLabel.frame.origin.x + _placeLabel.frame.size.width + 5.0f;
        CGFloat y = _placeImageView.frame.origin.y;
        
        _distanceImangeView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _distanceImangeView.image = [UIImage imageNamed:@"distance"];
        [self addSubview:_distanceImangeView];
    }
    return _distanceImangeView;
}

-(UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        CGFloat x = _distanceImangeView.frame.origin.x + _distanceImangeView.frame.size.width + 6.0f;
        CGFloat y = _placeImageView.frame.origin.y;
        CGFloat width = [GeneralSize getMainScreenWidth] - x;
        CGFloat height = 12.0f;
        
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _distanceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        _distanceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _distanceLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_distanceLabel];
    }
    return _distanceLabel;
}

-(UIImageView *)directElecImageView
{
    if (!_directElecImageView) {
        CGFloat width = IconWidth;
        CGFloat x = DistanceLeftSpace;
        CGFloat y = InfoUpDownSapce + _placeImageView.frame.origin.y + _placeImageView.frame.size.height;
        
        _directElecImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _directElecImageView.image = [UIImage imageNamed:@"direct_electric"];
        [self addSubview:_directElecImageView];
    }
    return _directElecImageView;
}

-(UILabel *)directElecLabel
{
    if (!_directElecLabel) {
        CGFloat x = _directElecImageView.frame.origin.x + _directElecImageView.frame.size.width + 6.0f;
        CGFloat y = _directElecImageView.frame.origin.y;
        CGFloat width = 123.0f;
        CGFloat height = 12.0f;
        
        _directElecLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _directElecLabel.textAlignment = NSTextAlignmentLeft;
        _directElecLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _directElecLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _directElecLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_directElecLabel];
    }
    return _directElecLabel;
}

//-(UIImageView *)exchangeImageView
//{
//    if (!_exchangeImageView) {
//        CGFloat width = IconWidth;
//        CGFloat x = DistanceLeftSpace;
//        CGFloat y = _directElecImageView.frame.origin.y + _directElecImageView.frame.size.height + InfoUpDownSapce;
//
//        _exchangeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
//        _exchangeImageView.image = [UIImage imageNamed:@"exchange_electric"];
//        [self addSubview:_exchangeImageView];
//    }
//    return _exchangeImageView;
//}

//-(UILabel *)exchangeLabel
//{
//    if (!_exchangeLabel) {
//        CGFloat x = _exchangeImageView.frame.origin.x + _exchangeImageView.frame.size.width + 6.0f;
//        CGFloat y = _exchangeImageView.frame.origin.y;
//        CGFloat width = 123.0f;
//        CGFloat height = 12.0f;
//
//        _exchangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
//        _exchangeLabel.textAlignment = NSTextAlignmentLeft;
//        _exchangeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
//        _exchangeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
//        _exchangeLabel.adjustsFontSizeToFitWidth = YES;
//        [self addSubview:_exchangeLabel];
//    }
//    return _exchangeLabel;
//}

-(UIImageView *)carrierImageView
{
    if (!_carrierImageView) {
        CGFloat width = IconWidth;
        CGFloat x = DistanceLeftSpace;
        CGFloat y = _directElecImageView.frame.origin.y + InfoUpDownSapce + _directElecImageView.frame.size.height;
        
        _carrierImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _carrierImageView.image = [UIImage imageNamed:@"carrier_icon"];
        [self addSubview:_carrierImageView];
    }
    return _carrierImageView;
}

-(UILabel *)carrierLabel
{
    if (!_carrierLabel) {
        CGFloat x = _carrierImageView.frame.origin.x + _carrierImageView.frame.size.width + 6.0f;
        CGFloat y = _carrierImageView.frame.origin.y;
        CGFloat width = 95.0f;
        CGFloat height = 12.0f;
        
        _carrierLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _carrierLabel.textAlignment = NSTextAlignmentLeft;
        _carrierLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _carrierLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _carrierLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_carrierLabel];
    }
    return _carrierLabel;
}

-(UILabel *)cutLine
{
    if (!_cutLine) {
        CGFloat x = 0.0f;
        CGFloat y = self.frame.size.height - 56.0f;
        CGFloat width = self.frame.size.width;
        CGFloat height = 1.0f;
        
        _cutLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _cutLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self addSubview:_cutLine];
    }
    return _cutLine;
}

-(UIButton *)navItem
{
    if (!_navItem) {
        CGFloat x = 0.0f;
        CGFloat y = _cutLine.frame.origin.y + _cutLine.frame.size.height;
        CGFloat width = self.frame.size.width;
        CGFloat height = 55.0f;
        
        _navItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _navItem.frame = CGRectMake(x, y, width, height);
        [_navItem setTitle:@"导航" forState:UIControlStateNormal];
        [_navItem setImage:[UIImage imageNamed:@"nav_item"] forState:UIControlStateNormal];
        [_navItem setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_navItem addTarget:self action:@selector(navClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_navItem];
    }
    return _navItem;
}

-(NSArray *)templateList
{
    if (!_templateList) {
        _templateList = [[NSArray alloc] init];
    }
    return _templateList;
}

#pragma mark - private method
-(void)setInfoWithStationModel:(ChargeAnnotation *)annotation
{
    self.poleLabel.text = annotation.stationName; // 充电桩名称
    self.parkLabel.text = annotation.parkFee; // 停车费
    self.electLabel.text = annotation.electFee; // 电费
    self.serviceLabel.text = annotation.serviceFee; // 服务费
    self.placeLabel.text = annotation.place; // 地点
    self.distanceLabel.text = annotation.distance; // 距离
    self.directElecLabel.attributedText = annotation.direct; // 直流信息
//    self.exchangeLabel.text = annotation.exchange; // 交流信息
    self.carrierLabel.text = annotation.carrier; // 运营商
    
    self.stationID = annotation.stationID;
    self.status = annotation.collectStatus;
    NSString *collectItemBackImage = (self.status == 1) ? @"collect_select" : @"collect_normal";
    [_collectItem setBackgroundImage:[UIImage imageNamed:collectItemBackImage] forState:UIControlStateNormal];
    
    self.templateList = annotation.templateList;
}

// 导航按钮
-(void)navClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(navItemClick)]) {
        [self.delegate navItemClick];
    }
}

// 收藏按钮
-(void)collectClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectItemClickWithStationID:withStatus:result:)]) {
        
        NSInteger status = (self.status == 1) ? 0 : 1;
        [self.delegate collectItemClickWithStationID:self.stationID withStatus:status result:^(RequestNetworkStatus result) {
            if (result == RequestNetworkSuccess) {
                self.status = status;
                NSString *collectItemBackImage = (self.status == 1) ? @"collect_select" : @"collect_normal";
                [self.collectItem setBackgroundImage:[UIImage imageNamed:collectItemBackImage] forState:UIControlStateNormal];
            }
        }];
    }
}

// 电价详情按钮
-(void)checkElectricDetail
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(electricDetailClickWithTemplateList:)]) {
        [self.delegate electricDetailClickWithTemplateList:self.templateList];
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
