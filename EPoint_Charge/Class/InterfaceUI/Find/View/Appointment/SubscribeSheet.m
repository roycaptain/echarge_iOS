//
//  SubscribeSheet.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/6.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import "SubscribeSheet.h"
#import "FilterButton.h"
#import "SubscribeSheetModel.h"
#import <AMapNaviKit/AMapNaviKit.h>

@interface SubscribeSheet ()

@property(nonatomic,strong)UIView *infoView;
@property(nonatomic,strong)UILabel *titleLabel; // 标题

@property(nonatomic,strong)UIImageView *parkIcon; //
@property(nonatomic,strong)UILabel *parkFeeLabel; // 停车费

@property(nonatomic,strong)UIImageView *distanceIcon; //
@property(nonatomic,strong)UILabel *distanceLabel; // 距离

@property(nonatomic,strong)UIImageView *locationIcon;//
@property(nonatomic,strong)UILabel *locationlabel; // 地点

@property(nonatomic,strong)UIImageView *startIcon;
@property(nonatomic,strong)UILabel *startLabel; // 预约开始时间

@property(nonatomic,strong)UIImageView *endIcon; //
@property(nonatomic,strong)UILabel *endLabel; // 预约结束时间

@property(nonatomic,strong)UILabel *alertLabel; // 温馨提示

@property(nonatomic,strong)FilterButton *renewBtn; // 续约
@property(nonatomic,strong)UIButton *cancelBtn; // 取消续约
@property(nonatomic,strong)UIButton *navBtn; // 导航

// 经纬度
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *longitude;

// 导航组件
@property(nonatomic,strong)AMapNaviCompositeManager *compositeManager;
@property(nonatomic,strong)AMapNaviCompositeUserConfig *config;

@end

@implementation SubscribeSheet

-(instancetype)initWithFrame:(CGRect)frame
{
    CGRect baseFrame = CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
    self = [super initWithFrame:baseFrame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - public method
-(instancetype)initSubscribeSheetWithModel:(SubscribeSheetModel *)model withSubscribeSheetDelegate:(id<SubscribeSheetDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        _titleLabel.text = model.deviceName;
        _parkFeeLabel.text = model.parkFee;
        _distanceLabel.text = model.distance;
        _locationlabel.text = model.address;
        _startLabel.text = model.startTime;
        _endLabel.text = model.endTime;
        _latitude = model.latitude;
        _longitude = model.longitude;
    }
    return self;
}

-(void)show
{
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        CGFloat y = [GeneralSize getMainScreenHeight] - weakSelf.infoView.frame.size.height;
        weakSelf.infoView.frame = CGRectMake(weakSelf.infoView.frame.origin.x, y, weakSelf.infoView.frame.size.width, weakSelf.infoView.frame.size.height);
    }];
}

#pragma mark - createUI
-(void)createUI
{
    self.backgroundColor = [UIColor clearColor];
    [self infoView];
    [self titleLabel];
    [self parkIcon];
    [self parkFeeLabel];
    [self distanceIcon];
    [self distanceLabel];
    [self locationIcon];
    [self locationlabel];
    [self startIcon];
    [self startLabel];
    [self endIcon];
    [self endLabel];
    [self alertLabel];
    
    [self renewBtn];
    [self cancelBtn];
    [self navBtn];
}

#pragma mark - private method
// 隐藏
-(void)hide
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        CGFloat y = [GeneralSize getMainScreenHeight];
        weakSelf.infoView.frame = CGRectMake(weakSelf.infoView.frame.origin.x, y, weakSelf.infoView.frame.size.width, weakSelf.infoView.frame.size.height);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
        weakSelf.infoView = nil;
        weakSelf.titleLabel = nil;
        weakSelf.parkIcon = nil;
        weakSelf.parkFeeLabel = nil;
        weakSelf.distanceIcon = nil;
        weakSelf.distanceLabel = nil;
        weakSelf.locationIcon = nil;
        weakSelf.locationlabel = nil;
        weakSelf.startIcon = nil;
        weakSelf.startLabel = nil;
        weakSelf.endIcon = nil;
        weakSelf.endLabel = nil;
        weakSelf.alertLabel = nil;
        
        weakSelf.renewBtn = nil;
        weakSelf.cancelBtn = nil;
        weakSelf.navBtn = nil;
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    if ([touch.view isEqual:self]) {
        [self hide];
    }
}

// 取消预约
-(void)cancelClickAction
{
    [self hide];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelAppointment)]) {
        [self.delegate cancelAppointment];
    }
}

// 续约
-(void)renewalAppointmentAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(renewalAppointment)]) {
        [self.delegate renewalAppointment];
    }
    [self hide];
}

// 导航
-(void)navActionClick
{
    CGFloat latitude = [_latitude doubleValue];
    CGFloat longitude = [_longitude doubleValue];
    [self.config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:latitude longitude:longitude] name:NULL POIId:NULL];
    [self.compositeManager presentRoutePlanViewControllerWithOptions:self.config];
    
    [self hide];
}

#pragma mark - lazy load
-(UIView *)infoView
{
    if (!_infoView) {
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 250.0f;
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getMainScreenHeight];
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _infoView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_infoView];
    }
    return _infoView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGFloat width = 200.0f;
        CGFloat height = 17.0f;
        CGFloat x = 25.0f;
        CGFloat y = 25.0f;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [_infoView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UIImageView *)parkIcon
{
    if (!_parkIcon) {
        CGFloat x = 25.0f;
        CGFloat y = _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 10.0f;
        CGFloat width = 14.0f;
        _parkIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _parkIcon.contentMode = UIViewContentModeScaleAspectFill;
        _parkIcon.image = [UIImage imageNamed:@"parking_fee"];
        [_infoView addSubview:_parkIcon];
    }
    return _parkIcon;
}

-(UILabel *)parkFeeLabel
{
    if (!_parkFeeLabel) {
        CGFloat x = _parkIcon.frame.origin.x + _parkIcon.frame.size.width + 5.0f;
        CGFloat y = _parkIcon.frame.origin.y;
        CGFloat width = 100.0f;
        CGFloat height = 14.0f;
        _parkFeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _parkFeeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _parkFeeLabel.font = [UIFont systemFontOfSize:13.0f];
        _parkFeeLabel.textAlignment = NSTextAlignmentLeft;
        [_infoView addSubview:_parkFeeLabel];
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
        _distanceIcon.contentMode = UIViewContentModeScaleAspectFill;
        _distanceIcon.image = [UIImage imageNamed:@"distance"];
        [_infoView addSubview:_distanceIcon];
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
        _distanceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _distanceLabel.font = [UIFont systemFontOfSize:13.0f];
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        [_infoView addSubview:_distanceLabel];
    }
    return _distanceLabel;
}

-(UIImageView *)locationIcon
{
    if (!_locationIcon) {
        CGFloat x = 25.0f;
        CGFloat y = _parkIcon.frame.origin.y + _parkIcon.frame.size.height + 10.0f;
        CGFloat width = 14.0f;
        _locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _locationIcon.contentMode = UIViewContentModeScaleAspectFill;
        _locationIcon.image = [UIImage imageNamed:@"place"];
        [_infoView addSubview:_locationIcon];
    }
    return _locationIcon;
}

-(UILabel *)locationlabel
{
    if (!_locationlabel) {
        CGFloat x = _locationIcon.frame.origin.x + _locationIcon.frame.size.width + 5.0f;
        CGFloat y = _locationIcon.frame.origin.y;
        CGFloat width = [GeneralSize getMainScreenWidth] - x;
        CGFloat height = 14.0f;
        _locationlabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _locationlabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _locationlabel.font = [UIFont systemFontOfSize:13.0f];
        _locationlabel.textAlignment = NSTextAlignmentLeft;
        [_infoView addSubview:_locationlabel];
    }
    return _locationlabel;
}

-(UIImageView *)startIcon
{
    if (!_startIcon) {
        CGFloat x = 25.0f;
        CGFloat y = _locationIcon.frame.origin.y + _locationIcon.frame.size.height + 10.0f;
        CGFloat width = 14.0f;
        _startIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _startIcon.contentMode = UIViewContentModeScaleAspectFill;
        _startIcon.image = [UIImage imageNamed:@"icon_subscribe_start"];
        [_infoView addSubview:_startIcon];
    }
    return _startIcon;
}

-(UILabel *)startLabel
{
    if (!_startLabel) {
        CGFloat x = _startIcon.frame.origin.x + _startIcon.frame.size.width + 5.0f;
        CGFloat y = _startIcon.frame.origin.y;
        CGFloat width = 250.0f;
        CGFloat height = 14.0f;
        _startLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _startLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _startLabel.font = [UIFont systemFontOfSize:13.0f];
        _startLabel.textAlignment = NSTextAlignmentLeft;
        [_infoView addSubview:_startLabel];
    }
    return _startLabel;
}

-(UIImageView *)endIcon
{
    if (!_endIcon) {
        CGFloat x = 25.0f;
        CGFloat y = _startIcon.frame.origin.y + _startIcon.frame.size.height + 10.0f;
        CGFloat width = 14.0f;
        _endIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _endIcon.contentMode = UIViewContentModeScaleAspectFill;
        _endIcon.image = [UIImage imageNamed:@"icon_subscribe_end"];
        [_infoView addSubview:_endIcon];
    }
    return _endIcon;
}

-(UILabel *)endLabel
{
    if (!_endLabel) {
        CGFloat x = _endIcon.frame.origin.x + _endIcon.frame.size.width + 5.0f;
        CGFloat y = _endIcon.frame.origin.y;
        CGFloat width = 250.0f;
        CGFloat height = 14.0f;
        _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _endLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _endLabel.font = [UIFont systemFontOfSize:13.0f];
        _endLabel.textAlignment = NSTextAlignmentLeft;
        [_infoView addSubview:_endLabel];
    }
    return _endLabel;
}

-(UILabel *)alertLabel
{
    if (!_alertLabel) {
        CGFloat x = 25.0f;
        CGFloat y = _endIcon.frame.origin.y + _endIcon.frame.size.height + 10.0f;
        CGFloat wdith = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 30.0f;
        _alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, wdith, height)];
        _alertLabel.numberOfLines = 0;
        _alertLabel.font = [UIFont systemFontOfSize:10.0f];
        _alertLabel.textColor = [UIColor colorWithHexString:@"#DDDDDD"];
        _alertLabel.text = @"温馨提示“请在预约规定时间内到达充电站充电呦”,若有突发情况，您可以 进行续约，保障充电正常进行。";
        [_infoView addSubview:_alertLabel];
    }
    return _alertLabel;
}

-(FilterButton *)renewBtn
{
    if (!_renewBtn) {
        CGFloat width = 50.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] - width - 10.0f;
        CGFloat y = 20.0f;
        _renewBtn = [FilterButton buttonWithType:UIButtonTypeCustom];
        _renewBtn.frame = CGRectMake(x, y, width, width);
        [_renewBtn setItemWithTitle:@"续约" withIconImage:@"btn_renew_done"];
        _renewBtn.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [_renewBtn addTarget:self action:@selector(renewalAppointmentAction) forControlEvents:UIControlEventTouchUpInside];
        [_infoView addSubview:_renewBtn];
    }
    return _renewBtn;
}

-(UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        CGFloat width = [GeneralSize getMainScreenWidth] / 2;
        CGFloat height = 54.0f;
        CGFloat x = 0.0f;
        CGFloat y = _infoView.frame.size.height - height;
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(x, y, width, height);
        _cancelBtn.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        [_cancelBtn setTitle:@"取消预约" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelClickAction) forControlEvents:UIControlEventTouchUpInside];
        [_infoView addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

-(UIButton *)navBtn
{
    if (!_navBtn) {
        CGFloat width = [GeneralSize getMainScreenWidth] / 2;
        CGFloat height = 54.0f;
        CGFloat x = width;
        CGFloat y = _infoView.frame.size.height - height;
        _navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _navBtn.frame = CGRectMake(x, y, width, height);
        _navBtn.backgroundColor = [UIColor colorWithHexString:@"#32CFC1"];
        [_navBtn setTitle:@"导航前往" forState:UIControlStateNormal];
        [_navBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_navBtn addTarget:self action:@selector(navActionClick) forControlEvents:UIControlEventTouchUpInside];
        [_infoView addSubview:_navBtn];
    }
    return _navBtn;
}

-(AMapNaviCompositeManager *)compositeManager
{
    if (!_compositeManager) {
        _compositeManager = [[AMapNaviCompositeManager alloc] init];
    }
    return _compositeManager;
}

-(AMapNaviCompositeUserConfig *)config
{
    if (!_config) {
        _config = [[AMapNaviCompositeUserConfig alloc] init];
    }
    return _config;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
