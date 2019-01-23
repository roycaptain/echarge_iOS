//
//  AppointCountDownView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/5.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import "AppointCountDownView.h"

@interface AppointCountDownView ()

@property(nonatomic,strong)UIImageView *backgroundImage;
@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *hourLabel; // 时
@property(nonatomic,strong)UILabel *minuteLabel; // 分
@property(nonatomic,strong)UILabel *secondLabel; // 秒

@property(nonatomic,strong)UILabel *hourTitle;
@property(nonatomic,strong)UILabel *minuteTitle;
@property(nonatomic,strong)UILabel *secondTitle;

@property(nonatomic,strong)UILabel *messageLabel;

@property(nonatomic,strong)UIButton *closeBtn;

@property(nonatomic,strong)NSString *endDate;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation AppointCountDownView

-(instancetype)initWithFrame:(CGRect)frame
{
    CGRect baseFrame = CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
    self = [super initWithFrame:baseFrame];
    if (self) {
        [self createUI];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        __weak typeof(self) weakSelf = self;
        self.backgroundImage.transform = CGAffineTransformScale(self.transform,0.1,0.1);
        [UIView animateWithDuration:0.2f animations:^{
            weakSelf.backgroundImage.transform = CGAffineTransformIdentity;
        }];
    }
    return self;
}

-(instancetype)initWithEndDate:(NSString *)endDate
{
    self = [super init];
    if (self) {
        self.endDate = [endDate copy];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

+(instancetype)initCountDownWithEndDate:(NSString *)endDate
{
    return [[self alloc] initWithEndDate:endDate];
}

#pragma mark - private method
-(void)countDownAction
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *startDate = [formatter dateFromString:[self getCurrentDate]];
    NSDate *endDate = [formatter dateFromString:self.endDate];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *delta = [calendar components:NSCalendarUnitSecond fromDate:startDate toDate:endDate options:0];
    NSInteger timeout = delta.second;
    
    if (timeout <= 0) {
        self.hourLabel.text = @"00";
        self.minuteLabel.text = @"00";
        self.secondLabel.text = @"00";
        return;
    }
    
    // 计算时分秒
    NSInteger hours = (NSInteger)(timeout/3600);
    NSInteger minutes = (NSInteger)(timeout - hours*3600)/60;
    NSInteger seconds = timeout - hours*3600 - minutes*60;
    
    NSString *hour;
    NSString *minute;
    NSString *second;
    if (hours < 10) {
        hour = [NSString stringWithFormat:@"0%ld",(long)hours];
    } else {
        hour = [NSString stringWithFormat:@"%ld",(long)hours];
    }
    if (minutes < 10) {
        minute = [NSString stringWithFormat:@"0%ld",(long)minutes];
    } else {
        minute = [NSString stringWithFormat:@"%ld",(long)minutes];
    }
    if (seconds < 10) {
        second = [NSString stringWithFormat:@"0%ld",(long)seconds];
    } else {
        second = [NSString stringWithFormat:@"%ld",(long)seconds];
    }
    self.hourLabel.text = hour;
    self.minuteLabel.text = minute;
    self.secondLabel.text = second;
}

/*
 获取当前时间
 @return dateString
 */
-(NSString *)getCurrentDate
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:currentDate];
}

// 关闭
-(void)closeClickAction
{
    [self removeFromSuperview];
    self.backgroundImage = nil;
    self.titleLabel = nil;
    self.hourLabel = nil;
    self.hourTitle = nil;
    self.minuteLabel = nil;
    self.minuteTitle = nil;
    self.secondLabel = nil;
    self.secondTitle = nil;
    self.messageLabel = nil;
    self.closeBtn = nil;
}

#pragma mark - createUI
-(void)createUI
{
    self.backgroundColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.4f];
    [self backgroundImage];
    [self titleLabel];
    
    [self hourLabel];
    [self hourTitle];
    [self minuteLabel];
    [self minuteTitle];
    [self secondLabel];
    [self secondTitle];
    [self messageLabel];
    [self closeBtn];
}

#pragma mark - lazy load
-(UIImageView *)backgroundImage
{
    if (!_backgroundImage) {
        CGFloat x = 50.0f;
        CGFloat y = 135.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 253.0f;
        _backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _backgroundImage.image = [UIImage imageNamed:@"bg_countdown_image"];
        _backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_backgroundImage];
    }
    return _backgroundImage;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGFloat width = 100.0f;
        CGFloat height = 12.0f;
        CGFloat x = (_backgroundImage.frame.size.width - width) / 2;
        CGFloat y = 78.0f;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _titleLabel.text = @"距离预约到期还有";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:10.0f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#090909"];
        [_backgroundImage addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)hourLabel
{
    if (!_hourLabel) {
        CGFloat x = (_backgroundImage.frame.size.width - 150.0f) / 2;
        CGFloat y = _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 20.0f;
        CGFloat width = 30.0f;
        CGFloat height = 40.0f;
        _hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        _hourLabel.backgroundColor = [UIColor blackColor];
        _hourLabel.textColor = [UIColor whiteColor];
        _hourLabel.font = [UIFont systemFontOfSize:17.0f];
        _hourLabel.layer.cornerRadius = 4.0f;
        _hourLabel.layer.masksToBounds = YES;
        [_backgroundImage addSubview:_hourLabel];
    }
    return _hourLabel;
}

-(UILabel *)hourTitle
{
    if (!_hourTitle) {
        CGFloat x = _hourLabel.frame.origin.x + _hourLabel.frame.size.width;
        CGFloat y = _hourLabel.frame.origin.y + 20.0f;
        CGFloat width = 20.0f;
        CGFloat height = 20.0f;
        _hourTitle = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _hourTitle.textColor = [UIColor blackColor];
        _hourTitle.textAlignment = NSTextAlignmentCenter;
        _hourLabel.font = [UIFont systemFontOfSize:14.0f];
        _hourTitle.text = @"时";
        [_backgroundImage addSubview:_hourTitle];
    }
    return _hourTitle;
}

-(UILabel *)minuteLabel
{
    if (!_minuteLabel) {
        CGFloat x = _hourTitle.frame.origin.x + _hourTitle.frame.size.width;
        CGFloat y = _hourLabel.frame.origin.y;
        CGFloat width = 30.0f;
        CGFloat height = 40.0f;
        _minuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _minuteLabel.textAlignment = NSTextAlignmentCenter;
        _minuteLabel.backgroundColor = [UIColor blackColor];
        _minuteLabel.textColor = [UIColor whiteColor];
        _minuteLabel.font = [UIFont systemFontOfSize:17.0f];
        _minuteLabel.layer.cornerRadius = 4.0f;
        _minuteLabel.layer.masksToBounds = YES;
        [_backgroundImage addSubview:_minuteLabel];
    }
    return _minuteLabel;
}

-(UILabel *)minuteTitle
{
    if (!_minuteTitle) {
        CGFloat x = _minuteLabel.frame.origin.x + _minuteLabel.frame.size.width;
        CGFloat y = _minuteLabel.frame.origin.y + 20.0f;
        CGFloat width = 20.0f;
        CGFloat height = 20.0f;
        _minuteTitle = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _minuteTitle.textColor = [UIColor blackColor];
        _minuteTitle.textAlignment = NSTextAlignmentCenter;
        _minuteTitle.font = [UIFont systemFontOfSize:14.0f];
        _minuteTitle.text = @"分";
        [_backgroundImage addSubview:_minuteTitle];
    }
    return _minuteTitle;
}

-(UILabel *)secondLabel
{
    if (!_secondLabel) {
        CGFloat x = _minuteTitle.frame.origin.x + _minuteTitle.frame.size.width;
        CGFloat y = _hourLabel.frame.origin.y;
        CGFloat width = 30.0f;
        CGFloat height = 40.0f;
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        _secondLabel.backgroundColor = [UIColor blackColor];
        _secondLabel.textColor = [UIColor whiteColor];
        _secondLabel.font = [UIFont systemFontOfSize:17.0f];
        _secondLabel.layer.cornerRadius = 4.0f;
        _secondLabel.layer.masksToBounds = YES;
        [_backgroundImage addSubview:_secondLabel];
    }
    return _secondLabel;
}

-(UILabel *)secondTitle
{
    if (!_secondTitle) {
        CGFloat x = _secondLabel.frame.origin.x + _secondLabel.frame.size.width;
        CGFloat y = _secondLabel.frame.origin.y + 20.0f;
        CGFloat width = 20.0f;
        CGFloat height = 20.0f;
        _secondTitle = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _secondTitle.textColor = [UIColor blackColor];
        _secondTitle.textAlignment = NSTextAlignmentCenter;
        _secondTitle.font = [UIFont systemFontOfSize:14.0f];
        _secondTitle.text = @"秒";
        [_backgroundImage addSubview:_secondTitle];
    }
    return _secondTitle;
}

-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        CGFloat x = 15.0f;
        CGFloat y = _hourLabel.frame.origin.y + _hourLabel.frame.size.height + 10.0f;
        CGFloat width = _backgroundImage.frame.size.width - x * 2;
        CGFloat height = _backgroundImage.frame.size.height - y - 10.0f;
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _messageLabel.text = @"您有一个预约订单即将超过预约时限请确保您能如约抵达充电(或可进续约)来给爱车及时补充能量";
        _messageLabel.textColor = [UIColor colorWithHexString:@"#090909"];
        _messageLabel.font = [UIFont systemFontOfSize:13.0f];
        _messageLabel.numberOfLines = 0;
        [_backgroundImage addSubview:_messageLabel];
    }
    return _messageLabel;
}

-(UIButton *)closeBtn
{
    if (!_closeBtn) {
        CGFloat x = _backgroundImage.frame.origin.x + _backgroundImage.frame.size.width;
        CGFloat y = _backgroundImage.frame.origin.y;
        CGFloat width = 25.0f;
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(x, y, width, width);
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"btn_close_alert"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeBtn];
    }
    return _closeBtn;
}

-(void)dealloc
{
    if (self.timer.isValid) {
        [self.timer invalidate];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
