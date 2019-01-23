//
//  MessageCell.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageCell : UITableViewCell

@property(nonatomic,strong)UIView *tipView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,strong)MessageModel *model;

@end
