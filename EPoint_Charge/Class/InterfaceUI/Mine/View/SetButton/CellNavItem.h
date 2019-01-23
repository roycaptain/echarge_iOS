//
//  CellNavItem.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/24.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellNavItem : UIButton

@property(nonatomic,strong)UILabel *headLabel;
@property(nonatomic,strong)UIImageView *navImage;

-(void)setCellNavItemHeadTitle:(NSString *)title;
-(void)setCellNavItemImageWithImageNamed:(NSString *)imageNamed;

@end
