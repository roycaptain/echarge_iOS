//
//  ChargeCell.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/8.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ChargeCell.h"

@implementation ChargeCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentView.layer.cornerRadius = 5.0f;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.borderColor = [UIColor colorWithHexString:@"#13BBC9"].CGColor;
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#13BBC9"];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_titleLabel];
    }
    
    return self;
}

-(void)setSelected:(BOOL)selected
{
    if (selected) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#13BBC9"];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE"];
    } else {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#13BBC9"];
    }
}

@end
