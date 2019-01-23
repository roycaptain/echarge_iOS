//
//  MenuItem.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/6.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItem : UIButton

-(void)setHeadLabelTitle:(NSString *)text;
-(void)setItemSelectState:(BOOL)isSelect;

@end

