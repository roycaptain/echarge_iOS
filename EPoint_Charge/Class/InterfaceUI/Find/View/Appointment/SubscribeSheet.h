//
//  SubscribeSheet.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/6.
//  Copyright © 2018 dddgong. All rights reserved.
//

/*
 预约
 */
#import <UIKit/UIKit.h>

@class SubscribeSheetModel;

@protocol SubscribeSheetDelegate <NSObject>

// 续约
-(void)renewalAppointment;

// 取消预约
-(void)cancelAppointment;

// 导航
//-(void)navigationClickWithLatitude:(CGFloat)latitude withLongitude:(CGFloat)longitude;

@end

@interface SubscribeSheet : UIView

@property(nonatomic,weak)id<SubscribeSheetDelegate> delegate;

-(instancetype)initSubscribeSheetWithModel:(SubscribeSheetModel *)model withSubscribeSheetDelegate:(id<SubscribeSheetDelegate>)delegate;
-(void)show;

@end
