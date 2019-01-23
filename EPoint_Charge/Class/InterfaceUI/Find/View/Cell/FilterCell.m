//
//  FilterCell.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/28.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "FilterCell.h"

@implementation FilterCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentView.layer.cornerRadius = 5.0f;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 0.0f, self.frame.size.width - 10.0f, self.frame.size.height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_titleLabel];
    }
    
    return self;
}

-(void)setSelected:(BOOL)selected
{
    if (selected) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#32CFC1"];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    } else {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
}

@end
