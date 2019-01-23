//
//  SiteHistoryCell.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/11.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "SiteHistoryCell.h"

@implementation SiteHistoryCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentView.layer.cornerRadius = 13.0f;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_titleLabel];
    }
    
    return self;
}

@end
