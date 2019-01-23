//
//  MineCell.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/22.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
        
    }
    return self;
}

#pragma mark - lazy load
-(UIImageView *)bgImageView
{
    if (!_bgImageView) {
        CGFloat x = 15.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 65.0f;

        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_bgImageView setImage:[UIImage imageNamed:@"mine_cell_middle"]];
        [self.contentView addSubview:_bgImageView];
    }
    return _bgImageView;
}

-(UIImageView *)icon
{
    if (!_icon) {
        CGFloat width = 22.0f;
        CGFloat height = 25.0f;
        CGFloat x = 20.0f;
        CGFloat y = 22.0f;
        
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_bgImageView addSubview:_icon];
    }
    return _icon;
}

-(UILabel *)title
{
    if (!_title) {
        CGFloat x = 51.0f;
        CGFloat y = 25.0f;
        CGFloat width = 63.0f;
        CGFloat height = 16.0f;
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _title.textColor = [UIColor colorWithHexString:@"#333333"];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.adjustsFontSizeToFitWidth = YES;
        _title.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        [_bgImageView addSubview:_title];
    }
    return _title;
}

-(UIImageView *)accessoryImage
{
    if (!_accessoryImage) {
        CGFloat width = 9.0f;
        CGFloat height = 18.0f;
        CGFloat x = _bgImageView.frame.size.width - width - 22.0f;
        CGFloat y = _bgImageView.frame.size.height / 2 - height / 2;
        
        _accessoryImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_accessoryImage setImage:[UIImage imageNamed:@"cell_accessory"]];
        
        [_bgImageView addSubview:_accessoryImage];
    }
    return _accessoryImage;
}

#pragma mark - private method
-(void)initUI
{
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
    [self bgImageView];
    [self icon];
    [self title];
    [self accessoryImage];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
