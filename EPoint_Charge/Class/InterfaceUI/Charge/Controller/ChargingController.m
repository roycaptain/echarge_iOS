//
//  ChargingController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/17.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ChargingController.h"
#import "ScanAnimationView.h"
#import "CeaseChargeController.h"
#import "ChargeModel.h"

CGFloat const ChargeElectWidth = 200.0f;
CGFloat const ChargeElectHeight = 13.0f;
CGFloat const LabelUpDownSapce = 8.0f;
NSString *const CHARGE = @"CHARGE"; // 充电中
NSString *const FINISH = @"FINISH"; // 充电完成

@interface ChargingController ()

@property(nonatomic,strong)UIScrollView *baseScrollView;

@property(nonatomic,strong)ScanAnimationView *scanAnimationView;
@property(nonatomic,strong)UILabel *voltageLabel; // 充电电压
@property(nonatomic,strong)UILabel *powerLabel; // 充电功率
@property(nonatomic,strong)UILabel *electricity; // 充电电量
@property(nonatomic,strong)UILabel *refreshLabel; // 刷新提示
@property(nonatomic,strong)UIImageView *refreshImageView; // 刷新图标
@property(nonatomic,strong)UIButton *ceaseBtn; // 停止充电

@property(nonatomic,strong)NSTimer *timer;

@end

@implementation ChargingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [CustomAlertView showWithMessage:@"正在加载......"];
    [self startRequestNetwork];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationTitle:@"充电中"];
    [super setNavigationBarBackItemWithTarget:self action:@selector(backToRootClick)];
    
    [self baseScrollView];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    
    [self scanAnimationView];
    [self voltageLabel];
    [self powerLabel];
    [self electricity];
    [self refreshLabel];
    [self refreshImageView];
    [self ceaseBtn];
}

#pragma mark lazy load
-(UIScrollView *)baseScrollView
{
    if (!_baseScrollView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _baseScrollView.alwaysBounceVertical = YES;
        if (@available(iOS 10.0, *)) {
            _baseScrollView.refreshControl = [[UIRefreshControl alloc] init];
            [_baseScrollView.refreshControl addTarget:self action:@selector(startRequestNetwork) forControlEvents:UIControlEventValueChanged];
        } else {
            // Fallback on earlier versions
        }
        [self.view addSubview:_baseScrollView];
    }
    return _baseScrollView;
}

-(ScanAnimationView *)scanAnimationView
{
    if (!_scanAnimationView) {
        CGFloat width = [GeneralSize getMainScreenWidth] / 3;
        CGFloat x = ([GeneralSize getMainScreenWidth] - width) / 2;
        CGFloat y = 110.0f;
    
        _scanAnimationView = [[ScanAnimationView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _scanAnimationView.backgroundColor = [UIColor redColor];
//        [_scanAnimationView setScanLabelText:@"0%"];
        [self.view addSubview:_scanAnimationView];
    }
    return _scanAnimationView;
}

// 充电电压
-(UILabel *)voltageLabel
{
    if (!_voltageLabel) {
        CGFloat width = ChargeElectWidth;
        CGFloat height = ChargeElectHeight;
        CGFloat x = ([GeneralSize getMainScreenWidth] - ChargeElectWidth) / 2;
        CGFloat y = _scanAnimationView.frame.origin.y + _scanAnimationView.frame.size.height + 29;
        
        _voltageLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _voltageLabel.font = [UIFont systemFontOfSize:12.0f];
        _voltageLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_voltageLabel];
    }
    return _voltageLabel;
}

// 充电功率
-(UILabel *)powerLabel
{
    if (!_powerLabel) {
        CGFloat width = ChargeElectWidth;
        CGFloat height = ChargeElectHeight;
        CGFloat x = ([GeneralSize getMainScreenWidth] - ChargeElectWidth) / 2;
        CGFloat y = _voltageLabel.frame.origin.y + _voltageLabel.frame.size.height + LabelUpDownSapce;
        
        _powerLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        
        _powerLabel.font = [UIFont systemFontOfSize:12.0f];
        _powerLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_powerLabel];
    }
    return _powerLabel;
}

// 充电电量
-(UILabel *)electricity
{
    if (!_electricity) {
        CGFloat width = ChargeElectWidth;
        CGFloat height = ChargeElectHeight;
        CGFloat x = ([GeneralSize getMainScreenWidth] - ChargeElectWidth) / 2;
        CGFloat y = _powerLabel.frame.origin.y + _powerLabel.frame.size.height + LabelUpDownSapce;
        
        _electricity = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _electricity.font = [UIFont systemFontOfSize:12.0f];
        _electricity.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_electricity];
    }
    return _electricity;
}

// 刷新提示
-(UILabel *)refreshLabel
{
    if (!_refreshLabel) {
        CGFloat width = ChargeElectWidth;
        CGFloat height = 11.0f;
        CGFloat x = ([GeneralSize getMainScreenWidth] - ChargeElectWidth) / 2;
        CGFloat y = _electricity.frame.origin.y + _electricity.frame.size.height + 42.0f;
        
        _refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _refreshLabel.text = @"下拉刷新，实时查看充电数据";
        _refreshLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:10.0f];
        _refreshLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _refreshLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_refreshLabel];
    }
    return _refreshLabel;
}

// 刷新图标
-(UIImageView *)refreshImageView
{
    if (!_refreshImageView) {
        CGFloat width = 27.0f;
        CGFloat height = 29.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] / 2 - width / 2;
        CGFloat y = _refreshLabel.frame.origin.y + _refreshLabel.frame.size.height + 11.0f;
        
        _refreshImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_refreshImageView setImage:[UIImage imageNamed:@"pull_refresh_icon"]];
        [self.view addSubview:_refreshImageView];
    }
    return _refreshImageView;
}

// 停止充电
-(UIButton *)ceaseBtn
{
    if (!_ceaseBtn) {
        _ceaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat height = 44.0f;
        CGFloat x = 30.0f;
        CGFloat y = [GeneralSize getMainScreenHeight] - height - TabBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        
        _ceaseBtn.frame = CGRectMake(x, y, width, height);
        _ceaseBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        [_ceaseBtn setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        [_ceaseBtn setTitle:@"停止充电" forState:UIControlStateNormal];
        [_ceaseBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_ceaseBtn addTarget:self action:@selector(ceaseChargeClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_ceaseBtn];
    }
    return _ceaseBtn;
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(timeRefreshAction) userInfo:NULL repeats:YES];
    }
    return _timer;
}

#pragma mark - 下拉刷新操作
// 定时刷新
-(void)timeRefreshAction
{
    [self startRequestNetwork];
}

-(void)startRequestNetwork
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSufixxCharge];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSNumber *status = [[UserInfoManager shareInstance] getUserChargeStatus];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"status" : status};
    
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestGETWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *result) {
        if (@available(iOS 10.0, *)) {
            if ([weakSelf.baseScrollView.refreshControl isRefreshing]) {
                [weakSelf.baseScrollView.refreshControl endRefreshing];
            }
        } else {
            // Fallback on earlier versions
        }
        
        NSString *code = result[@"code"];
        NSString *msg = result[@"msg"];
        if ([code integerValue] == RequestNetworkTokenLose) {
            [CustomAlertView hide];
            [super presentLoginController];
            return ;
        }
        
        if ([code integerValue] == 400275) { // 等待启动充电
            [weakSelf startRequestNetwork];
            return;
        }
        [CustomAlertView hide];
        if ([code integerValue] != RequestNetworkSuccess) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            [alertVC addAction:action];
            [weakSelf presentViewController:alertVC animated:YES completion:NULL];
            return;
        }
        [[UserInfoManager shareInstance] saveUserStartChargeStatus:NO];
        NSDictionary *dictionary = result[@"data"];
        ChargeModel *model = [ChargeModel modelWithDictionary:dictionary];
        
        [weakSelf.scanAnimationView setScanLabelText:model.soc]; // 充电进度
        weakSelf.voltageLabel.attributedText = model.voltage; // 电压
        weakSelf.powerLabel.attributedText = model.power; // 电功率
        weakSelf.electricity.attributedText = model.current; // 电量
        weakSelf.deviceSerialNum = model.deviceSerialNum;
        weakSelf.childDeviceSerialNum = model.childDeviceSerialNum;
        
        NSString *status = ([model.orderStatus isEqualToString:CHARGE]) ? @"充电中" : @"充电完成";
        [super setNavigationTitle:status];
        [weakSelf timeRefreshAction];
        
        
    } failure:^(NSError *error) {
        if (@available(iOS 10.0, *)) {
            if ([self.baseScrollView.refreshControl isRefreshing]) {
                [self.baseScrollView.refreshControl endRefreshing];
            }
        } else {
            // Fallback on earlier versions
        }
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - 停止充电操作
-(void)ceaseChargeClick
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixStopCharge];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"deviceSerialNum" : self.deviceSerialNum,
                                @"childDeviceSerialNum" : self.childDeviceSerialNum,
                                @"clientType" : @"IOS",
                                };
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *result) {
        NSLog(@"result - %@",result);
        [CustomAlertView hide];
        NSString *code = result[@"code"];
        NSString *msg = result[@"msg"];

        if ([code integerValue] == RequestNetworkTokenLose) {
            [super presentLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:NULL];
            [alertVC addAction:action];
            [weakSelf presentViewController:alertVC animated:YES completion:NULL];
            return;
        }
        [[UserInfoManager shareInstance] saveUserStartChargeStatus:NO];
        UIStoryboard *chargeSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
        CeaseChargeController *ceaseChargeVC = [chargeSB instantiateViewControllerWithIdentifier:@"CeaseChargeController"];
        ceaseChargeVC.status = ([code integerValue] == RequestNetworkSuccess) ? YES : NO;
        ceaseChargeVC.alertString = [msg copy];
        [weakSelf.navigationController pushViewController:ceaseChargeVC animated:YES];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

-(void)backToRootClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
