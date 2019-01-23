//
//  MessageModel.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "MessageModel.h"

CGFloat const MContentXPoint = 30.0f; // x坐标
CGFloat const MContentBottomSpace = 20.0f; // 底部距离
CGFloat const MContentTopSapce = 20.0f;
CGFloat const McontentTitleHeight = 17.0f;
CGFloat const MContentTitleSpace = 13.0f;
#define MessageCellWidth [GeneralSize getMainScreenWidth] - MContentXPoint * 2 // 消息cell的宽度

@implementation MessageModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    NSString *mID = dictionary[@"id"];
    NSInteger status = [dictionary[@"status"] integerValue];
    NSString *title = dictionary[@"title"];
    NSString *content = dictionary[@"content"];
    
    MessageModel *model = [[self alloc] init];
    
    model.mID = mID;
    model.status = status;
    model.title = title; // 标题
    model.content = content; //内容
    
    // 计算 content 坐标
    CGFloat contentHeight = 0.0f;
    if (content.length) {
        contentHeight = [GeneralSize calculateStringHeight:dictionary[@"content"] withFontSize:14.0f withStringWidth:MessageCellWidth];
        model.contentLabelFrame = CGRectMake(MContentXPoint, MContentTopSapce + McontentTitleHeight + MContentTitleSpace , MessageCellWidth, contentHeight);
    } else {
        model.contentLabelFrame = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
    }

    // 计算 行高
    CGFloat rowHeight = contentHeight + MContentTopSapce + McontentTitleHeight + MContentBottomSpace;
    model.cellHeight = rowHeight;
    
    return model;
}

-(void)setMessageStatus
{
    self.status = 0;
}

@end
