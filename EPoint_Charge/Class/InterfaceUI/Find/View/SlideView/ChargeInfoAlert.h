//
//  ChargeInfoAlert.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/27.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "InfoView.h"

extern CGFloat const InfoHeight;

@protocol ChargeInfoAlertDelegate<NSObject>

// 收藏
-(void)infoViewCollectItemWithStationID:(NSInteger)stationID withStatus:(NSInteger)status result:(void (^)(RequestNetworkStatus))requestStatus;

// 点击电价详情按钮
-(void)checkElectricDetailClickWithTemplateList:(NSArray *)templateList;

@end

@class ChargeAnnotation;

@interface ChargeInfoAlert : NSObject<UIGestureRecognizerDelegate,InfoViewDelegate,AMapNaviCompositeManagerDelegate>

@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)InfoView *infoView; // 信息背景

// 坐标
@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;

@property(nonatomic,weak)id<ChargeInfoAlertDelegate> delegate;

// 导航组件
@property(nonatomic,strong)AMapNaviCompositeManager *compositeManager;
@property(nonatomic,strong)AMapNaviCompositeUserConfig *config;

+(ChargeInfoAlert *)shareInstance;

-(void)showChargeStationInfoView;

-(void)setInfoWithStationModel:(ChargeAnnotation *)annotation;

@end
