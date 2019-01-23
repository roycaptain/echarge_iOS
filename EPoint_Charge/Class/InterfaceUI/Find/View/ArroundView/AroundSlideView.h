//
//  AroundSlideView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/29.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const AroundItemContainerHeight; // 按钮容器的高度
extern CGFloat const AroundItemHeight; // 按钮高度

@protocol AroundSlideViewDelegate<NSObject>

// 获取选中的值
-(void)getAroundSlideSelectedIndex:(NSInteger)selectIndex;

@end

@interface AroundSlideView : UIView

@property(nonatomic,strong)UIView *itemContainerView; // 按钮容器
@property(nonatomic,strong)UIButton *disatnceItem; // 距离最近按钮
@property(nonatomic,strong)UIButton *idleItem; // 空闲优先按钮
@property(nonatomic,strong)UILabel *slideLabel; // 滑动条

/*
 当前选中的索引 0 距离优先 1 空闲优先
 */
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,weak)id<AroundSlideViewDelegate> delegate;

@end
