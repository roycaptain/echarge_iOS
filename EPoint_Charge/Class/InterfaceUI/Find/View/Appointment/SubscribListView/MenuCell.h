//
//  MenuCell.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/6.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"

@interface MenuCell : UITableViewCell

@property(nonatomic,strong)MenuModel *model;
@property(nonatomic,assign)BOOL isSelected;

-(void)setCellSelectState:(BOOL)isSelected;

@end
