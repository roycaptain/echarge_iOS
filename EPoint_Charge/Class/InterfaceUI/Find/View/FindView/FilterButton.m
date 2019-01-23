//
//  FilterButton.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/27.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "FilterButton.h"

@interface FilterButton ()

@property(nonatomic,strong)UIImageView *imageIcon;
@property(nonatomic,strong)UILabel *title;

@end

@implementation FilterButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark - public method
-(void)setItemWithTitle:(NSString *)title withIconImage:(NSString *)imageName
{
    _imageIcon.image = [UIImage imageNamed:imageName];
    _title.text = title;
}

#pragma mark - lazy load
-(UIImageView *)imageIcon
{
    if (!_imageIcon) {
        CGFloat width = 22.0f;
        CGFloat x = 14.0f;
        CGFloat y = 6.0f;
        
        _imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        [self addSubview:_imageIcon];
    }
    return _imageIcon;
}

-(UILabel *)title
{
    if (!_title) {
        CGFloat x = 13.0f;
        CGFloat y = _imageIcon.frame.origin.y + _imageIcon.frame.size.height + 4.0f;
        CGFloat width = 23.0f;
        CGFloat height = 12.0f;
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _title.textColor = [UIColor colorWithHexString:@"#02B1CD"];
        _title.font = [UIFont systemFontOfSize:12.0f];
        _title.adjustsFontSizeToFitWidth = YES;
        _title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_title];
    }
    return _title;
}

#pragma mark - initUI
-(void)initUI
{
    [self imageIcon];
    [self title];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
