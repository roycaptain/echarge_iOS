//
//  FindViewController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/15.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "FindViewController.h"
#import "SearchBarView.h"
#import "FilterButton.h"
#import "ScanChargeButton.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "ChargeAnnotation.h"
#import "ChargeAnnotationView.h" // 自定义地图标注
#import "ChargeInfoAlert.h"
#import "AroundStationController.h"
#import "FilterView.h"
#import "CitySwitchController.h"
#import "FilterModel.h"
#import "AppDelegate.h"
#import "LoginController.h"
#import "SearchSiteController.h"
#import "QRCodeController.h"
#import "ElectricDetailController.h"
#import "AppointFailView.h"
#import "AppointCountDownView.h"
#import "SubscribeSheet.h"
#import "SubscribeSheetModel.h"

@interface FindViewController ()<AMapLocationManagerDelegate,
                                MAMapViewDelegate,
                                ChargeInfoAlertDelegate,
                                FilterViewDelegate,
                                SearchProtocol,
                                SearchSiteDelegate,
                                CityLocationDelegate,
                                SubscribeSheetDelegate>

@property(nonatomic,strong)SearchBarView *searchBarView;
@property(nonatomic,strong)ScanChargeButton *scanBtn; // 扫码充电按钮
@property(nonatomic,strong)FilterButton *filterBtn; // 筛选按钮
@property(nonatomic,strong)FilterButton *appointBtn; // 预约按钮
@property(nonatomic,strong)FilterView *filterView; // 筛选页面

@property(nonatomic,strong)MAMapView *mapView; // 地图
@property(nonatomic,strong)AMapLocationManager *locationManager; // 定位

@property(nonatomic,strong)NSMutableArray *chargeAnnotations; // 标注数组
@property(nonatomic,strong)NSMutableArray *chargeStations; // 站点数据

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.mapView.delegate = nil;
    self.mapView.showsUserLocation = NO;
    [super viewWillDisappear:animated];
}

-(void)dealloc
{
    self.mapView = nil;
}

#pragma mark - lazy load
-(SearchBarView *)searchBarView
{
    if (!_searchBarView) {
        CGFloat x = [GeneralSize getMainScreenWidth] - 114.0f;
        CGFloat y = 0.0f;
        CGFloat width = 260.0f;
        CGFloat height = 34.0f;
        
        _searchBarView = [[SearchBarView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _searchBarView.delegate = self;
        self.navigationItem.titleView = _searchBarView;
        self.navigationItem.titleView.frame = CGRectMake(0.0f, 0.0f, width, height);
    }
    return _searchBarView;
}

// 地图
-(MAMapView *)mapView
{
    if (!_mapView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y - TabBarHeight;
        
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        _mapView.showsCompass = NO;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.zoomLevel = 17;
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

// 扫码充电按钮
-(ScanChargeButton *)scanBtn
{
    if (!_scanBtn) {
        CGFloat x = 30.0f;
        CGFloat height = 44.0f;
        CGFloat y = [GeneralSize getMainScreenHeight] - 20.0f - height - TabBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        
        
        _scanBtn = [ScanChargeButton buttonWithType:UIButtonTypeCustom];
        _scanBtn.frame = CGRectMake(x, y, width, height);
        [_scanBtn setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        _scanBtn.layer.cornerRadius = 22.0f;
        [_scanBtn addTarget:self action:@selector(scanClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_scanBtn];
    }
    return _scanBtn;
}

// 筛选按钮
-(FilterButton *)filterBtn
{
    if (!_filterBtn) {
        CGFloat width = 50.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] - 15.0f - width;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight + 29.0f;
        _filterBtn = [FilterButton buttonWithType:UIButtonTypeCustom];
        _filterBtn.frame = CGRectMake(x, y, width, width);
        [_filterBtn setItemWithTitle:@"筛选" withIconImage:@"filter_icon"];
        _filterBtn.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [_filterBtn addTarget:self action:@selector(filterClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_filterBtn];
    }
    return _filterBtn;
}

// 预约按钮
-(FilterButton *)appointBtn
{
    if (!_appointBtn) {
        CGFloat width = 50.0f;
        CGFloat x = _filterBtn.frame.origin.x;
        CGFloat y = _filterBtn.frame.origin.y + _filterBtn.frame.size.height + 10.0f;
        _appointBtn = [FilterButton buttonWithType:UIButtonTypeCustom];
        _appointBtn.frame = CGRectMake(x, y, width, width);
        [_appointBtn setItemWithTitle:@"预约" withIconImage:@"btn_bgimg_appointment"];
        _appointBtn.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [_appointBtn addTarget:self action:@selector(appointAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_appointBtn];
    }
    return _appointBtn;
}

// 定位
-(AMapLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 10;
        [_locationManager startUpdatingLocation];
        [_locationManager setLocatingWithReGeocode:YES];
    }
    return _locationManager;
}

// 地图标注数组
-(NSMutableArray *)chargeAnnotations
{
    if (!_chargeAnnotations) {
        _chargeAnnotations = [[NSMutableArray alloc] init];
    }
    return _chargeAnnotations;
}

// 筛选界面
-(FilterView *)filterView
{
    if (!_filterView) {
        CGFloat x = [GeneralSize getMainScreenWidth];
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight];
        
        _filterView = [[FilterView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _filterView.delegate = self;
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_filterView];
    }
    return _filterView;
}

-(NSMutableArray *)chargeStations
{
    if (!_chargeStations) {
        _chargeStations = [[NSMutableArray alloc] init];
    }
    return _chargeStations;
}

#pragma mark - initUI
-(void)initUI
{
    NSString *city = [[UserInfoManager shareInstance] getUserLocationCity];
    city = (city == nil) ? @"城市" : city;
    [super setFindVCLeftBarButtonItemWithTitle:city withImageNamed:@"find_city_location" withTarget:self action:@selector(cityChanged)];
    [super setNavigationRightButtonItemWithTitle:@"列表" withTarget:self withAction:@selector(listClick)];
    [self searchBarView];
    [UserLocationManager shareInstance];
    [self mapView];// 地图
    [self scanBtn];
    [self filterBtn];
    [self appointBtn];
    [self locationManager];
    
    // 检测版本更新
    [self checkVersionUpdate];
    
    if ([[UserInfoManager shareInstance] isLocation]) { // 有定位数据
        NSString *latitude = [[UserInfoManager shareInstance] getUserLocationWithLatitude];
        NSString *longitude = [[UserInfoManager shareInstance] getUserLocationWithLongitude];
        [self startAnnotationNetworkWithLatitude:latitude withLongitude:longitude]; // 获取标注
    }
}

#pragma mark - click
// 城市
-(void)cityChanged
{
    UIStoryboard *findSB = [UIStoryboard storyboardWithName:@"Find" bundle:[NSBundle mainBundle]];
    CitySwitchController *citySwitchVC = [findSB instantiateViewControllerWithIdentifier:@"CitySwitchController"];
    citySwitchVC.delegate = self;
    [self.navigationController pushViewController:citySwitchVC animated:YES];
}

// 列表
-(void)listClick
{
    UIStoryboard *findSB = [UIStoryboard storyboardWithName:@"Find" bundle:[NSBundle mainBundle]];
    AroundStationController *aroundVC = [findSB instantiateViewControllerWithIdentifier:@"AroundStationController"];
    [self.navigationController pushViewController:aroundVC animated:YES];
}

// 筛选
-(void)filterClick
{
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSString *latitude = [[UserLocationManager shareInstance] getUserLocationWithLatitude];
    NSString *longitude = [[UserLocationManager shareInstance] getUserLocationWithLongitude];
    
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixNearbyCompany];
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"latitude" : latitude,@"longitude" : longitude};
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDict) {
        [CustomAlertView hide];
        NSString *code = resultDict[@"code"];
        NSString *msg = resultDict[@"msg"];
        if ([code integerValue] == RequestNetworkTokenLose) {
            [weakSelf presentLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithWarnMessage:msg];
            return ;
        }
        
        NSArray *data = [[FilterModel shareInstance] setFilterArray:resultDict[@"data"]];
        weakSelf.filterView.data = data;
        [weakSelf.filterView presentFilterView];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithFailureMessage:NetworkingError];
    }];
}

// 查询预约接口
-(void)getAppointmentInfo
{
    __weak typeof(self) weakSelf = self;
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixAppointmentInfo];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSString *latitude = [[UserLocationManager shareInstance] getUserLocationWithLatitude];
    NSString *longitude = [[UserLocationManager shareInstance] getUserLocationWithLongitude];
    NSString *lonLat = [NSString stringWithFormat:@"%@,%@",longitude,latitude];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"lonLat" : lonLat};
    
    [[DDNetworkRequest shareInstance] requestGETWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *result) {
        [CustomAlertView hide];
        NSString *code = result[@"code"];
        if ([code integerValue] == RequestNetworkTokenLose) { // token失效
            [super presentLoginController];
            return;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            NSString *msg = result[@"msg"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:NULL];
            [alert addAction:confirm];
            [weakSelf presentViewController:alert animated:YES completion:NULL];
            return;
        }
        NSDictionary *data = result[@"data"];
        SubscribeSheetModel *model = [SubscribeSheetModel modelWithDictionary:data];
        // 预约sheet
        SubscribeSheet *sheet = [[SubscribeSheet alloc] initSubscribeSheetWithModel:model withSubscribeSheetDelegate:weakSelf];
        [sheet show];
       
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithFailureMessage:NetworkingError];
    }];
}

// 预约
-(void)appointAction
{
    [self getAppointmentInfo]; // 查询预约接口
    // 启动失败
//    AppointFailView *failView = [[AppointFailView alloc] initFailWith:@"非常抱歉,启动未成功" withMessage:@"该枪已被预约,请重新更换充电枪进行充电.或预约其他枪进行充电" withLeftItemTitle:@"知道了" withRightItemTitle:@"去预约" withRightBlock:^{
//        NSLog(@"去预约");
//    }];
//    [failView show];
    // 预约失败
//    AppointFailView *failView = [[AppointFailView alloc] initFailWith:@"非常抱歉,预约失败" withMessage:@"该枪暂被刷卡用户刷卡充电了.您可以再次选择充电枪进行预约" withLeftItemTitle:@"知道了" withRightItemTitle:@"去预约" withRightBlock:^{
//        NSLog(@"去预约");
//    }];
//    [failView show];
    
    // 倒计时预约
//    [AppointCountDownView initCountDownWithEndDate:@"2018-12-06 16:44:00"];
    
}

-(void)scanClick
{
    UIStoryboard *chargingSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
    QRCodeController *qrcodeVC = [chargingSB instantiateViewControllerWithIdentifier:@"QRCodeController"];
    [self.navigationController pushViewController:qrcodeVC animated:YES];
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) { // 显示定位蓝点
        return nil;
    }
    if ([annotation isKindOfClass:[ChargeAnnotation class]])
    {
        static NSString *ChargeAnnotationIndentifier = @"ChargeAnnotationIndentifier";
        ChargeAnnotationView *chargeAnnotation = (ChargeAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ChargeAnnotationIndentifier];
        if (chargeAnnotation == nil)
        {
            chargeAnnotation = [[ChargeAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ChargeAnnotationIndentifier];
            chargeAnnotation.canShowCallout= NO;       //设置气泡可以弹出，默认为NO
            chargeAnnotation.draggable = NO;        //设置标注可以拖动，默认为NO
        }
         chargeAnnotation.chargeView.image = [UIImage imageNamed:@"map_mark"];
        return chargeAnnotation;
    }
    return nil;
}

// 点击标注
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) { // 点击定位蓝点
        return ;
    }
    ChargeAnnotation *annotation = (ChargeAnnotation *)view.annotation;
    [mapView deselectAnnotation:annotation animated:YES];
    [[ChargeInfoAlert shareInstance] setInfoWithStationModel:annotation];
    [[ChargeInfoAlert shareInstance] setDelegate:self];
    [[ChargeInfoAlert shareInstance] showChargeStationInfoView];
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    [CustomAlertView showWithWarnMessage:@"定位失败"];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    if ([[UserInfoManager shareInstance] getUserLocationCity] == nil && reGeocode.city) {
        NSString *city = [reGeocode.city stringByReplacingOccurrencesOfString:@"市" withString:@""];
        [[UserInfoManager shareInstance] setUserLocationCity:city];
        [super setFindVCLeftBarButtonItemWithTitle:city withImageNamed:@"find_city_location" withTarget:self action:@selector(cityChanged)];
    }

    [[UserLocationManager shareInstance] setUserLocationWithLatitude:latitude withLongitude:longitude];
    if (![[UserInfoManager shareInstance] isLocation]) { // 没有定位数据
        [[UserInfoManager shareInstance] saveUserLocationWithLatitude:latitude withLongitude:longitude];
        [self startAnnotationNetworkWithLatitude:latitude withLongitude:longitude]; // 获取标注
    }
}

#pragma mark - network
// 检测版本更新
-(void)checkVersionUpdate
{
    __weak typeof(self) weakSelf = self;
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixVersion];
    NSDictionary *bodyDictionary = @{@"terminal" : @2};
    [[DDNetworkRequest shareInstance] requestGETWithURLString:requestURL WithHTTPHeaderFieldDictionary:NULL withParamDictionary:bodyDictionary successful:^(NSDictionary *result) {
        
        NSDictionary *data = result[@"data"];
        NSString *urlStr = result[@"downloadPath"]; // http://itunes.apple.com/cn/app/id1434038419
        double versionCode = [data[@"versionCode"] doubleValue];
        NSString *version = [NSString stringWithFormat:@"%.1f",versionCode];
        if ([Common compareNewVersion:version]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"新版本上线了,去更新吧" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleCancel handler:NULL];
            [alert addAction:confirmAction];
            [alert addAction:cancelAction];
            [weakSelf presentViewController:alert animated:YES completion:NULL];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

// 开始获取周边充电桩信息
-(void)startAnnotationNetworkWithLatitude:(NSString *)latitude withLongitude:(NSString *)longitude
{
    [CustomAlertView showWithMessage:@"正在加载周边电桩"];
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixAroundStation];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"latitude" : latitude,@"longitude" : longitude,@"isUse" : @YES};
    
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        
        if ([code integerValue] == RequestNetworkTokenLose) {
            [weakSelf presentLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        NSArray *data = resultDictionary[@"data"];
        if (data.count == 0) {
            [CustomAlertView showWithWarnMessage:@"暂无数据"];
            return;
        }
        [weakSelf.mapView removeAnnotations:weakSelf.chargeAnnotations];
        [weakSelf.chargeAnnotations removeAllObjects];
        [weakSelf.chargeStations removeAllObjects];
        
        for (NSDictionary *dictionary in data) {
            // 添加标注
            ChargeAnnotation *pointAnnotation = [[ChargeAnnotation alloc] initWithAnnotationModelWithDict:dictionary];
            [weakSelf.chargeAnnotations addObject:pointAnnotation];
        }
        [weakSelf.mapView addAnnotations:weakSelf.chargeAnnotations];
        
    } failure:^(NSError *error) {
        NSLog(@"周边充电桩 - %@",error);
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - ChargeInfoAlertDelegate
// 收藏按钮事件
-(void)infoViewCollectItemWithStationID:(NSInteger)stationID withStatus:(NSInteger)status result:(void (^)(RequestNetworkStatus))requestStatus
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixSetCollectionStation];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSNumber *stationIDNum = [NSNumber numberWithInteger:stationID];
    NSNumber *statusNum = [NSNumber numberWithInteger:status];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"stationId" : stationIDNum,@"status" : statusNum,@"clientType" : @"IOS",};
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPUTWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        NSLog(@"resultDictionary - %@",resultDictionary);
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        
        if ([code integerValue] == RequestNetworkTokenLose) {
            [weakSelf presentLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return ;
        }
        // 通过回调讲结果返回弹出框
        if (requestStatus) {
            requestStatus([code integerValue]);
        }
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        if (requestStatus) {
            requestStatus(RequestNetworkTokenLose);
        }
    }];
}

// 电价详情按钮
-(void)checkElectricDetailClickWithTemplateList:(NSArray *)templateList
{
    UIStoryboard *findSB = [UIStoryboard storyboardWithName:@"Find" bundle:[NSBundle mainBundle]];
    ElectricDetailController *electricDetailVC = [findSB instantiateViewControllerWithIdentifier:@"ElectricDetailController"];
    electricDetailVC.templateList = templateList;
    [self.navigationController pushViewController:electricDetailVC animated:YES];
}

#pragma mark - FilterViewDelegate
-(void)confirmClickWithBodyParam:(NSDictionary *)dictionary
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixAroundStation];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:dictionary successful:^(NSDictionary *resultDictionary) {
        
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        
        if ([code integerValue] == RequestNetworkTokenLose) {
            [weakSelf presentLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        NSArray *data = resultDictionary[@"data"];
        if (data.count == 0) {
            [CustomAlertView showWithWarnMessage:@"暂无数据"];
            return;
        }
        [weakSelf.mapView removeAnnotations:self.chargeAnnotations];
        [weakSelf.chargeAnnotations removeAllObjects];
        [weakSelf.chargeStations removeAllObjects];
        
        for (NSDictionary *dictionary in data) {
            // 添加标注
            ChargeAnnotation *pointAnnotation = [[ChargeAnnotation alloc] initWithAnnotationModelWithDict:dictionary];
            [weakSelf.chargeAnnotations addObject:pointAnnotation];
        }
        [weakSelf.mapView addAnnotations:weakSelf.chargeAnnotations];
        [weakSelf.mapView reloadMap]; // 这个地方会使内存增大
        
    } failure:^(NSError *error) {
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

/*
 在首页判断 accesstoken是否有效
 */
-(void)presentLoginController
{
    // 先弹出一个 alert 提醒需要登陆
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证失效,请重新登陆" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf redirectLoginController];
    }];
    [alert addAction:confirmAction];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 跳转到登陆界面
-(void)redirectLoginController
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    LoginController *loginVC = [loginSB instantiateViewControllerWithIdentifier:@"LoginController"];
    app.window.rootViewController = loginVC;
}

#pragma mark - SearchProtocol
// 开始编辑时 进入搜索地名界面
- (void)textFieldBeginEditing
{
    UIStoryboard *findSB = [UIStoryboard storyboardWithName:@"Find" bundle:[NSBundle mainBundle]];
    SearchSiteController *searchVC = [findSB instantiateViewControllerWithIdentifier:@"SearchSiteController"];
    searchVC.delegate = self;
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - SearchSiteDelegate
-(void)locationMapCenterSiteWithLatitude:(CGFloat)latitude withLongitude:(CGFloat)longitude
{
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
}

#pragma mark - CityLocationDelegate
-(void)cityLocationWithCity:(NSString *)city withLatitude:(CGFloat)latitude withLongitude:(CGFloat)longitude
{
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    [super setFindVCLeftBarButtonItemWithTitle:city withImageNamed:@"find_city_location" withTarget:self action:@selector(cityChanged)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SubscribeSheetDelegate
// 续约
-(void)renewalAppointment
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixRenewalAppoint];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSDictionary *headerParam = @{@"access_token" : accessToken};
   
    [CustomAlertView show];
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:NULL successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return ;
        }
        [CustomAlertView showWithSuccessMessage:msg];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

// 取消预约
-(void)cancelAppointment
{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                             message:@"确定取消预约"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    // 2.创建并添加按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf startCancelAppointment];
    
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:NULL];
}

-(void)startCancelAppointment
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixCancelAppoint];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    
    [CustomAlertView show];
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:NULL successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return ;
        }
        [CustomAlertView showWithSuccessMessage:msg];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
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
