//
//  SubscribeDetailController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/6.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import "SubscribeDetailController.h"

@interface SubscribeDetailController ()

@property(nonatomic,strong)UIImageView *topImageView;
@property(nonatomic,strong)UILabel *siteLabel; // 充电桩名称
@property(nonatomic,strong)UIImageView *distanceIcon;
@property(nonatomic,strong)UILabel *distanceLabel; // 距离
@property(nonatomic,strong)UIImageView *parkIcon;
@property(nonatomic,strong)UILabel *parkFeeLabel; // 停车费
@property(nonatomic,strong)UILabel *elerticLabel; // 电费
@property(nonatomic,strong)UILabel *serviceLabel; // 服务费
@property(nonatomic,strong)UIImageView *locationIcon;
@property(nonatomic,strong)UILabel *locationLabel; // 地点
@property(nonatomic,strong)UIImageView *sitePointIcon;
@property(nonatomic,strong)UILabel *sitePointLabel; // 所属站点
@property(nonatomic,strong)UIImageView *directIcon;
@property(nonatomic,strong)UILabel *directLabel; // 直流
@property(nonatomic,strong)UIImageView *exchangeIcon;
@property(nonatomic,strong)UILabel *exchangeLabel; // 交流
@property(nonatomic,strong)UIImageView *carrierIcon;
@property(nonatomic,strong)UILabel *carrierLabel; // 运营商

@property(nonatomic,strong)UIButton *cancelBtn; // 取消预约
@property(nonatomic,strong)UIButton *navBtn; // 导航

@end

@implementation SubscribeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

#pragma mark - createUI
-(void)createUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"特斯拉充电桩"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#000000"];
    
    [self topImageView];
    [self siteLabel];
    [self distanceIcon];
    [self distanceLabel];
    [self parkIcon];
    [self parkFeeLabel];
    [self elerticLabel];
    [self serviceLabel];
    [self locationIcon];
    [self locationLabel];
    [self sitePointIcon];
    [self sitePointLabel];
    [self directIcon];
    [self directLabel];
    [self exchangeIcon];
    [self exchangeLabel];
    [self carrierIcon];
    [self carrierLabel];
    
    [self cancelBtn];
    [self navBtn];
}

#pragma mark - lazy load
-(UIImageView *)topImageView
{
    if (!_topImageView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 250.0f;
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topImageView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_topImageView];
    }
    return _topImageView;
}

-(UILabel *)siteLabel
{
    if (!_siteLabel) {
        CGFloat x = 15.0f;
        CGFloat y = _topImageView.frame.origin.y + _topImageView.frame.size.height + 30.0f;
        CGFloat width = 150.0f;
        CGFloat height = 17.0f;
        _siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _siteLabel.text = @"特斯拉充电桩";
        _siteLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _siteLabel.textAlignment = NSTextAlignmentLeft;
        _siteLabel.font = [UIFont systemFontOfSize:17.0f];
        [self.view addSubview:_siteLabel];
    }
    return _siteLabel;
}

-(UIImageView *)distanceIcon
{
    if (!_distanceIcon) {
        CGFloat x = [GeneralSize getMainScreenWidth] - 130.0f;
        CGFloat y = _siteLabel.frame.origin.y;
        CGFloat width = 14.0f;
        _distanceIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _distanceIcon.contentMode = UIViewContentModeScaleAspectFill;
        _distanceIcon.image = [UIImage imageNamed:@"distance"];
        [self.view addSubview:_distanceIcon];
    }
    return _distanceIcon;
}

-(UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        CGFloat x = _distanceIcon.frame.origin.x + _distanceIcon.frame.size.width + 5.0f;
        CGFloat y = _distanceIcon.frame.origin.y;
        CGFloat width = 100.0f;
        CGFloat height = 14.0f;
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        _distanceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _distanceLabel.font = [UIFont systemFontOfSize:12.0f];
        _distanceLabel.text = @"离我1.2公里";
        [self.view addSubview:_distanceLabel];
    }
    return _distanceLabel;
}

-(UIImageView *)parkIcon
{
    if (!_parkIcon) {
        CGFloat x = 15.0f;
        CGFloat y = _siteLabel.frame.origin.y + _siteLabel.frame.size.height + 10.0f;
        CGFloat width = 14.0f;
        _parkIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _parkIcon.contentMode = UIViewContentModeScaleAspectFill;
        _parkIcon.image = [UIImage imageNamed:@"parking_fee"];
        [self.view addSubview:_parkIcon];
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
        _parkFeeLabel.text = @"停车费: 5元";
        [self.view addSubview:_parkFeeLabel];
    }
    return _parkFeeLabel;
}

-(UILabel *)elerticLabel
{
    if (!_elerticLabel) {
        CGFloat x = _parkFeeLabel.frame.origin.x + _parkFeeLabel.frame.size.width + 5.0f;
        CGFloat y = _parkIcon.frame.origin.y;
        CGFloat width = 80.0f;
        CGFloat height = 14.0f;
        _elerticLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _elerticLabel.textAlignment = NSTextAlignmentLeft;
        _elerticLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _elerticLabel.font = [UIFont systemFontOfSize:12.0f];
        _elerticLabel.text = @"电费: 1.8元/度";
        [self.view addSubview:_elerticLabel];
    }
    return _elerticLabel;
}

-(UILabel *)serviceLabel
{
    if (!_serviceLabel) {
        CGFloat x = _elerticLabel.frame.origin.x + _elerticLabel.frame.size.width + 5.0f;
        CGFloat y = _parkIcon.frame.origin.y;
        CGFloat width = [GeneralSize getMainScreenWidth] - x;
        CGFloat height = 14.0f;
        _serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _serviceLabel.textAlignment = NSTextAlignmentLeft;
        _serviceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _serviceLabel.font = [UIFont systemFontOfSize:12.0f];
        _serviceLabel.text = @"服务费: 0.2元/度";
        _serviceLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_serviceLabel];
    }
    return _serviceLabel;
}

-(UIImageView *)locationIcon
{
    if (!_locationIcon) {
        CGFloat x = 15.0f;
        CGFloat y = _parkIcon.frame.origin.y + _parkIcon.frame.size.height + 10.0f;
        CGFloat width = 14.0f;
        _locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _locationIcon.contentMode = UIViewContentModeScaleAspectFill;
        _locationIcon.image = [UIImage imageNamed:@"place"];
        [self.view addSubview:_locationIcon];
    }
    return _locationIcon;
}

-(UILabel *)locationLabel
{
    if (!_locationLabel) {
        CGFloat x = _locationIcon.frame.origin.x + _locationIcon.frame.size.width + 5.0f;
        CGFloat y = _locationIcon.frame.origin.y;
        CGFloat width = 250.0f;
        CGFloat height = 14.0f;
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _locationLabel.textAlignment = NSTextAlignmentLeft;
        _locationLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _locationLabel.font = [UIFont systemFontOfSize:12.0f];
        _locationLabel.text = @"深圳市宝深路与狼山路三号路口交叉处";
        [self.view addSubview:_locationLabel];
    }
    return _locationLabel;
}

-(UIImageView *)sitePointIcon
{
    if (!_sitePointIcon) {
        CGFloat x = 15.0f;
        CGFloat y = _locationIcon.frame.origin.y + _locationIcon.frame.size.height + 10.0f;
        CGFloat width = 14.0f;
        _sitePointIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _sitePointIcon.contentMode = UIViewContentModeScaleAspectFill;
        _sitePointIcon.image = [UIImage imageNamed:@"icon_site_belong"];
        [self.view addSubview:_sitePointIcon];
    }
    return _sitePointIcon;
}

-(UILabel *)sitePointLabel
{
    if (!_sitePointLabel) {
        CGFloat x = _sitePointIcon.frame.origin.x + _sitePointIcon.frame.size.width + 5.0f;
        CGFloat y = _sitePointIcon.frame.origin.y;
        CGFloat width = 250.0f;
        CGFloat height = 14.0f;
        _sitePointLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _sitePointLabel.textAlignment = NSTextAlignmentLeft;
        _sitePointLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _sitePointLabel.font = [UIFont systemFontOfSize:12.0f];
        _sitePointLabel.text = @"所属站点：暂无";
        [self.view addSubview:_sitePointLabel];
    }
    return _sitePointLabel;
}

-(UIImageView *)directIcon
{
    if (!_directIcon) {
        CGFloat x = 15.0f;
        CGFloat y = _sitePointIcon.frame.origin.y + _sitePointIcon.frame.size.height + 10.0f;
        CGFloat width = 14.0f;
        _directIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _directIcon.contentMode = UIViewContentModeScaleAspectFill;
        _directIcon.image = [UIImage imageNamed:@"direct_electric"];
        [self.view addSubview:_directIcon];
    }
    return _directIcon;
}

-(UILabel *)directLabel
{
    if (!_directLabel) {
        CGFloat x = _directIcon.frame.origin.x + _directIcon.frame.size.width + 5.0f;
        CGFloat y = _directIcon.frame.origin.y;
        CGFloat width = 250.0f;
        CGFloat height = 14.0f;
        _directLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _directLabel.textAlignment = NSTextAlignmentLeft;
        _directLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _directLabel.font = [UIFont systemFontOfSize:12.0f];
        _directLabel.text = @"直流：空闲 8 /总数 18";
        [self.view addSubview:_directLabel];
    }
    return _directLabel;
}

-(UIImageView *)exchangeIcon
{
    if (!_exchangeIcon) {
        CGFloat x = 15.0f;
        CGFloat y = _directIcon.frame.origin.y + _directIcon.frame.size.height + 10.0f;
        CGFloat width = 14.0f;
        _exchangeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _exchangeIcon.contentMode = UIViewContentModeScaleAspectFill;
        _exchangeIcon.image = [UIImage imageNamed:@"direct_electric"];
        [self.view addSubview:_exchangeIcon];
    }
    return _exchangeIcon;
}

-(UILabel *)exchangeLabel
{
    if (!_exchangeLabel) {
        CGFloat x = _exchangeIcon.frame.origin.x + _exchangeIcon.frame.size.width + 5.0f;
        CGFloat y = _exchangeIcon.frame.origin.y;
        CGFloat width = 250.0f;
        CGFloat height = 14.0f;
        _exchangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _exchangeLabel.textAlignment = NSTextAlignmentLeft;
        _exchangeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _exchangeLabel.font = [UIFont systemFontOfSize:12.0f];
        _exchangeLabel.text = @"交流：空闲 8 /总数 18";
        [self.view addSubview:_exchangeLabel];
    }
    return _exchangeLabel;
}

-(UIImageView *)carrierIcon
{
    if (!_carrierIcon) {
        CGFloat x = 15.0f;
        CGFloat y = _exchangeIcon.frame.origin.y + _exchangeIcon.frame.size.height + 10.0f;
        CGFloat width = 14.0f;
        _carrierIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _carrierIcon.contentMode = UIViewContentModeScaleAspectFill;
        _carrierIcon.image = [UIImage imageNamed:@"carrier_icon"];
        [self.view addSubview:_carrierIcon];
    }
    return _carrierIcon;
}

-(UILabel *)carrierLabel
{
    if (!_carrierLabel) {
        CGFloat x = _carrierIcon.frame.origin.x + _carrierIcon.frame.size.width + 5.0f;
        CGFloat y = _carrierIcon.frame.origin.y;
        CGFloat width = 250.0f;
        CGFloat height = 14.0f;
        _carrierLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _carrierLabel.textAlignment = NSTextAlignmentLeft;
        _carrierLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _carrierLabel.font = [UIFont systemFontOfSize:12.0f];
        _carrierLabel.text = @"运营商: 普天电力";
        [self.view addSubview:_carrierLabel];
    }
    return _carrierLabel;
}

-(UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        CGFloat width = 150.0f;
        CGFloat height = 50.0f;
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getMainScreenHeight] - height;
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(x, y, width, height);
        [_cancelBtn setTitle:@"取消预约" forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"#F0F0F5"]];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [self.view addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

-(UIButton *)navBtn
{
    if (!_navBtn) {
        CGFloat width = [GeneralSize getMainScreenWidth] - _cancelBtn.frame.size.width;
        CGFloat height = 50.0f;
        CGFloat x = _cancelBtn.frame.origin.x + _cancelBtn.frame.size.width;
        CGFloat y = [GeneralSize getMainScreenHeight] - height;
        _navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _navBtn.frame = CGRectMake(x, y, width, height);
        [_navBtn setTitle:@"立即导航" forState:UIControlStateNormal];
        [_navBtn setBackgroundColor:[UIColor colorWithHexString:@"#32CFC1"]];
        _navBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _navBtn.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [self.view addSubview:_navBtn];
    }
    return _navBtn;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
