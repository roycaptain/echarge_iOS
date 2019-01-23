//
//  AppointFailView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/5.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import "AppointFailView.h"

@interface AppointFailView ()

@property(nonatomic,strong)UIView *alertView;
@property(nonatomic,strong)UIImageView *topIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UIButton *leftItem;
@property(nonatomic,strong)UIButton *rightItem;

@end

@implementation AppointFailView

-(instancetype)initWithFrame:(CGRect)frame
{
    CGRect baseFrame = CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
    self = [super initWithFrame:baseFrame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - public method
-(instancetype)initFailWith:(NSString *)title withMessage:(NSString *)message withLeftItemTitle:(NSString *)leftTitle withRightItemTitle:(NSString *)rightTitle withRightBlock:(void(^)(void))rightBlock
{
    self = [super init];
    if (self) {
        _titleLabel.text = title;
        _messageLabel.text = message;
        [_leftItem setTitle:leftTitle forState:UIControlStateNormal];
        [_rightItem setTitle:rightTitle forState:UIControlStateNormal];
        self.rightBlock = rightBlock;
    }
    return self;
}

// 显示
-(void)show
{
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    __weak typeof(self) weakSelf = self;
    self.alertView.transform = CGAffineTransformScale(self.transform,0.1,0.1);
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.alertView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - click action
-(void)leftItemAction
{
    [self hide];
}

-(void)rightItemAction
{
    if (self.rightBlock) {
        self.rightBlock();
    }
    [self hide];
}

#pragma mark - private method
-(void)createUI
{
    self.backgroundColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.4f];
    [self alertView];
    [self topIcon];
    [self titleLabel];
    [self messageLabel];
    [self leftItem];
    [self rightItem];
}

// 隐藏
-(void)hide
{
    [self removeFromSuperview];
    self.alertView = nil;
    self.topIcon = nil;
    self.titleLabel = nil;
    self.messageLabel = nil;
    self.leftItem = nil;
    self.rightItem = nil;
}

#pragma mark - lazy load
-(UIView *)alertView
{
    if (!_alertView) {
        CGFloat x = 60.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 240.0f;
        CGFloat y = ([GeneralSize getMainScreenHeight] - height) / 2;
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _alertView.layer.cornerRadius = 8.5f;
        _alertView.layer.masksToBounds = YES;
        _alertView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_alertView];
    }
    return _alertView;
}

-(UIImageView *)topIcon
{
    if (!_topIcon) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = _alertView.frame.size.width;
        CGFloat height = 105.0f;
        _topIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _topIcon.image = [UIImage imageNamed:@"appoint_fail_icon"];
        _topIcon.contentMode = UIViewContentModeScaleAspectFill;
        [_alertView addSubview:_topIcon];
    }
    return _topIcon;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGFloat width = _alertView.frame.size.width;
        CGFloat height = 18.0f;
        CGFloat x = 0.0f;
        CGFloat y = _topIcon.frame.origin.y + _topIcon.frame.size.height + 18.0f;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        [_alertView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        CGFloat x = 10.0f;
        CGFloat y = _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 10.0f;
        CGFloat width = _alertView.frame.size.width - x * 2;
        CGFloat height = 25.0f;
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:10.0f];
        _messageLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [_alertView addSubview:_messageLabel];
    }
    return _messageLabel;
}

-(UIButton *)leftItem
{
    if (!_leftItem) {
        CGFloat width = (_alertView.frame.size.width - 30.0f) / 2;
        CGFloat height = 30.0f;
        CGFloat x = 10.0f;
        CGFloat y = _messageLabel.frame.origin.y + _messageLabel.frame.size.height + 10.0f;
        _leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftItem.frame = CGRectMake(x, y, width, height);
        [_leftItem setTitleColor:[UIColor colorWithHexString:@"#03B2CD"] forState:UIControlStateNormal];
        _leftItem.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        _leftItem.layer.cornerRadius = 13.0f;
        _leftItem.layer.masksToBounds = YES;
        _leftItem.layer.borderColor = [UIColor colorWithHexString:@"#03B2CD"].CGColor;
        _leftItem.layer.borderWidth = 1.0f;
        [_leftItem addTarget:self action:@selector(leftItemAction) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:_leftItem];
    }
    return _leftItem;
}

-(UIButton *)rightItem
{
    if (!_rightItem) {
        CGFloat width = (_alertView.frame.size.width - 30.0f) / 2;
        CGFloat height = 30.0f;
        CGFloat x = _alertView.frame.size.width - 10.0f - width;
        CGFloat y = _leftItem.frame.origin.y;
        _rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightItem.frame = CGRectMake(x, y, width, height);
        [_rightItem setTitleColor:[UIColor colorWithHexString:@"#03B2CD"] forState:UIControlStateNormal];
        _rightItem.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        _rightItem.layer.cornerRadius = 13.0f;
        _rightItem.layer.masksToBounds = YES;
        _rightItem.layer.borderColor = [UIColor colorWithHexString:@"#03B2CD"].CGColor;
        _rightItem.layer.borderWidth = 1.0f;
        [_rightItem addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:_rightItem];
    }
    return _rightItem;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
