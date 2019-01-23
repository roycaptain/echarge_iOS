//
//  ChargeAnnotationView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/27.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ChargeAnnotationView.h"

CGFloat const width = 36.0f; // 标注的宽度
CGFloat const height = 36.0f; // 标注的高度

@implementation ChargeAnnotationView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.bounds = CGRectMake(0.f, 0.f, width, height);
        [self chargeView];
    }
    
    return self;
}

#pragma mark -
-(UIImageView *)chargeView
{
    if (!_chargeView) {
        _chargeView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height)];
        [self addSubview:_chargeView];
    }
    return _chargeView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
