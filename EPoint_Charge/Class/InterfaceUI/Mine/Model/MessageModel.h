//
//  MessageModel.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <Foundation/Foundation.h>

extern CGFloat const MContentXPoint; // x坐标
extern CGFloat const MContentBottomSpace; // 底部距离
extern CGFloat const MContentTopSapce;
extern CGFloat const MContentTitleHeight;
extern CGFloat const MContentTitleSpace;

@interface MessageModel : NSObject

@property(nonatomic,copy)NSString *mID;
@property(nonatomic,assign)NSInteger status; // 状态 0 - 已读 1 -未读 
@property(nonatomic,copy)NSString *title; // 标题
@property(nonatomic,copy)NSString *content; // 内容

@property(nonatomic,assign)CGRect contentLabelFrame; // 内容的坐标
@property(nonatomic,assign)CGFloat cellHeight; // 行高

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

-(void)setMessageStatus;

@end
