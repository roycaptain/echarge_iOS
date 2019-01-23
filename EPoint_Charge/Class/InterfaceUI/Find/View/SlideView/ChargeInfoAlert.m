//
//  ChargeInfoAlert.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/27.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ChargeInfoAlert.h"
#import "ChargeAnnotation.h"

CGFloat const InfoHeight = 300.0f;

@implementation ChargeInfoAlert

+(ChargeInfoAlert *)shareInstance
{
    static ChargeInfoAlert *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self baseView];
        [self infoView];
        
        [self compositeManager];
        [self config];
    }
    return self;
}

// 展示
-(void)showChargeStationInfoView
{
    [UIView animateWithDuration:0.5f animations:^{
        self.baseView.frame = CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
    }];
}

// 隐藏
-(void)removeChargeStationInfoView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.baseView.frame = CGRectMake(0.0f, [GeneralSize getMainScreenHeight], [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
    } completion:^(BOOL finished) {
        
    }];
}

// 添加信息
-(void)setInfoWithStationModel:(ChargeAnnotation *)annotation
{
    [self.infoView setInfoWithStationModel:annotation];
    self.latitude = annotation.coordinate.latitude;
    self.longitude = annotation.coordinate.longitude;
}

#pragma mark - lazy load
-(UIView *)baseView
{
    if (!_baseView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getMainScreenHeight];
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight];
        
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _baseView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        tapGesturRecognizer.delegate = self;
        [_baseView addGestureRecognizer:tapGesturRecognizer];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_baseView];
    }
    return _baseView;
}

-(InfoView *)infoView
{
    if (!_infoView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getMainScreenHeight] - InfoHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = InfoHeight;
        
        _infoView = [[InfoView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _infoView.delegate = self;
        [_baseView addSubview:_infoView];
    }
    return _infoView;
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

#pragma mark - touch
- (void)tapAction
{
    [self removeChargeStationInfoView];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.infoView]) {
        return NO;
    }
    return YES;
}

#pragma mark - InfoViewDelegate
// 导航按钮点击事件
-(void)navItemClick
{
    [self removeChargeStationInfoView];
    double latitude = self.latitude;
    double longitude = self.longitude;
    [self.config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:latitude longitude:longitude] name:NULL POIId:NULL];
    [self.compositeManager presentRoutePlanViewControllerWithOptions:self.config];
}

- (void)compositeManager:(AMapNaviCompositeManager *_Nonnull)compositeManager error:(NSError *_Nonnull)error
{
    NSLog(@"ss");
}

// 收藏按钮点击
-(void)collectItemClickWithStationID:(NSInteger)stationID withStatus:(NSInteger)status result:(void (^)(RequestNetworkStatus))result
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(infoViewCollectItemWithStationID:withStatus:result:)]) {
        
        [self.delegate infoViewCollectItemWithStationID:stationID withStatus:status result:^(RequestNetworkStatus requestStatus) {
            if (result) {
                result(requestStatus);
            }
        }];
    }
}

// 电价详情
-(void)electricDetailClickWithTemplateList:(NSArray *)templateList
{
    [self removeChargeStationInfoView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(checkElectricDetailClickWithTemplateList:)]) {
        [self.delegate checkElectricDetailClickWithTemplateList:templateList];
    }
}

@end
