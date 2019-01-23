//
//  SubscribeListCell.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/6.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellNavItem.h"

@class SubscribModel;

@interface SubscribeListCell : UITableViewCell

@property(nonatomic,strong)CellNavItem *navItem; // 导航
@property(nonatomic,strong)CellNavItem *subscribeItem; // 预约

@property(nonatomic,strong)SubscribModel *model;

@end
