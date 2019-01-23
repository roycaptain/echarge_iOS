//
//  FilterView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/29.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CarrierModel;

extern NSString *const FilterCellIdentifier; // cell
// header
extern NSString *const StationTypeHeaderIdentifier;
extern NSString *const DisatnceIdentifier;
extern NSString *const CarrierIdentifier;
// footer
extern NSString *const FilterFooterIdentifier;

extern CGFloat const FilterLeftSpace;
extern CGFloat const FilterCellItemHeight;

@protocol FilterViewDelegate<NSObject>

// 点击确定按钮
-(void)confirmClickWithBodyParam:(NSDictionary *)dictionary;

@end

@interface FilterView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *filterCollectionView;
@property(nonatomic,strong)UIButton *resetItem; // 重置按钮
@property(nonatomic,strong)UIButton *confirmItem; // 确定按钮

@property(nonatomic,assign)BOOL isUse; // 是否显示空闲电桩
@property(nonatomic,weak)id<FilterViewDelegate> delegate;

@property(nonatomic,strong)NSArray *data; //

-(void)presentFilterView; // 侧滑效果

@end
