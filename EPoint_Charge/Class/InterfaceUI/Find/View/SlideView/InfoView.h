//
//  InfoView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/27.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const DistanceLeftSpace; // 距离左边距离
extern CGFloat const InfoUpDownSapce; // 上下控件的距离
extern CGFloat const IconWidth; // 图标的宽度

@protocol InfoViewDelegate<NSObject>

// 收藏按钮点击
-(void)collectItemClickWithStationID:(NSInteger)stationID withStatus:(NSInteger)status result:(void (^)(RequestNetworkStatus))result;

// 导航按钮点击事件
-(void)navItemClick;

// 电价详情按钮
-(void)electricDetailClickWithTemplateList:(NSArray *)templateList;

@end

@class ChargeAnnotation;

@interface InfoView : UIView

@property(nonatomic,strong)UILabel *poleLabel; // 充电桩名称
@property(nonatomic,strong)UIButton *electricDetail; // 电价详情按钮
@property(nonatomic,strong)UIButton *collectItem; // 收藏按钮
@property(nonatomic,strong)UIImageView *parkImageView; // 停车图标
@property(nonatomic,strong)UILabel *parkLabel; // 停车费费用
@property(nonatomic,strong)UILabel *electLabel; // 电费
@property(nonatomic,strong)UILabel *serviceLabel; // 服务费
@property(nonatomic,strong)UIImageView *placeImageView; // 地点图标
@property(nonatomic,strong)UILabel *placeLabel; // 地点
@property(nonatomic,strong)UIImageView *distanceImangeView; // 距离图标
@property(nonatomic,strong)UILabel *distanceLabel; // 距离
@property(nonatomic,strong)UIImageView *directElecImageView; // 直流图标
@property(nonatomic,strong)UILabel *directElecLabel; // 直流信息
//@property(nonatomic,strong)UIImageView *exchangeImageView; // 交流图标
//@property(nonatomic,strong)UILabel *exchangeLabel; // 交流信息
@property(nonatomic,strong)UIImageView *carrierImageView; // 营运商图标
@property(nonatomic,strong)UILabel *carrierLabel; // 运营商信息
@property(nonatomic,strong)UILabel *cutLine; // 分割线
@property(nonatomic,strong)UIButton *navItem; // 导航按钮

@property(nonatomic,assign)NSInteger stationID; // 站点id
@property(nonatomic,assign)NSInteger status; // 是否收藏

@property(nonatomic,strong)NSArray *templateList; // 计费模版详情

@property(nonatomic,weak)id<InfoViewDelegate> delegate;

-(void)setInfoWithStationModel:(ChargeAnnotation *)annotation;

@end
