//
//  ListDetailController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/19.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ListDetailController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "ChargeAnnotation.h"
#import "ChargeAnnotationView.h" // 自定义地图标注
#import "ChargeInfoAlert.h"
#import "ElectricDetailController.h"

@interface ListDetailController ()<MAMapViewDelegate,ChargeInfoAlertDelegate>

@property(nonatomic,strong)MAMapView *mapView;

@end

@implementation ListDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
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

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"站点详情"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#000000"];
    
    [self mapView];
    

    ChargeAnnotation *pointAnnotation = [[ChargeAnnotation alloc] initWithAnnotationModelWithDict:self.model.data];
    [_mapView addAnnotation:pointAnnotation];
    
    double latitude = [self.model.latitude doubleValue];
    double longitude = [self.model.longitude doubleValue];
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
}

#pragma mark - lazy load
-(MAMapView *)mapView
{
    if (!_mapView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _mapView.zoomLevel = 17;
        _mapView.delegate = self;
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[ChargeAnnotation class]]) {
        static NSString *ChargeAnnotationIndentifier = @"ChargeAnnotationIndentifier";
        ChargeAnnotationView *chargeAnnotation = (ChargeAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ChargeAnnotationIndentifier];
        if (chargeAnnotation == nil) {
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
    NSLog(@" %f  %f ",annotation.coordinate.latitude,annotation.coordinate.longitude);
    [mapView deselectAnnotation:annotation animated:YES];
    [[ChargeInfoAlert shareInstance] setInfoWithStationModel:annotation];
    [ChargeInfoAlert shareInstance].delegate = self;
    [[ChargeInfoAlert shareInstance] showChargeStationInfoView];
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
    NSDictionary *bodyParam = @{@"stationId" : stationIDNum,@"status" : statusNum};
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPUTWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        
        if ([code integerValue] == RequestNetworkTokenLose) {
            [weakSelf presentLoginController];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
