//
//  SubscribeGunCell.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/7.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import "SubscribeGunCell.h"

@implementation SubscribeGunCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
        _backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImage.image = [UIImage imageNamed:@"subgun_normal_bgimg"];
        [self.contentView addSubview:_backgroundImage];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#070707"];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.text = @"充电枪1";
        [self.contentView addSubview:_titleLabel];
    }
    
    return self;
}

-(void)setSelected:(BOOL)selected
{
    if (selected) {
        self.backgroundImage.image = [UIImage imageNamed:@"subgun_select_bgimg"];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE"];
    } else {
        self.backgroundImage.image = [UIImage imageNamed:@"subgun_normal_bgimg"];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#070707"];
    }
}

@end
