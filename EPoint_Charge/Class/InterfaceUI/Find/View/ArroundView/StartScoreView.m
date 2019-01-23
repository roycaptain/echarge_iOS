//
//  StartScoreView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/29.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "StartScoreView.h"

NSUInteger const StartNumber = 5;

@implementation StartScoreView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - createUI
-(void)setScroeWithStartNumber:(NSInteger)number
{
    for (NSInteger i = 1; i <= StartNumber; i++) {
        CGFloat x = (i - 1) * 19.0f;
        CGFloat y = 0.0f;
        CGFloat width = 14.0f;
        
        NSString *imageName = (i <= number) ? @"start_score_selected" : @"start_score_normal";
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:imageView];
    }
}

//-(void)setStartScoreWithNumber:(NSUInteger)number
//{
//
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
