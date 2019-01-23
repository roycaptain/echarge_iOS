//
//  MessageCell.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        [self initUI];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _contentLabel.frame = _model.contentLabelFrame;
}

#pragma mark - lazy load
-(UIView *)tipView
{
    if (!_tipView) {
        CGFloat x = 15.0f;
        CGFloat y = 25.0f;
        CGFloat width = 8.0f;
        
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _tipView.backgroundColor = [UIColor colorWithHexString:@"#CC0000"];
        _tipView.layer.cornerRadius = width / 2;
        _tipView.clipsToBounds = YES;
        [self.contentView addSubview:_tipView];
    }
    return _tipView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGFloat x = 30.0f;
        CGFloat y = 20.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x;
        CGFloat height = 17.0f;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
//        [_contentLabel sizeToFit];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

#pragma mark - initUI
-(void)initUI
{
    [self tipView];
    [self titleLabel];
    [self contentLabel];
}

- (void)setModel:(MessageModel *)model
{
    _model = model;
    
    _tipView.hidden = model.status == 1 ? NO : YES;
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
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
