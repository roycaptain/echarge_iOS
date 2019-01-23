//
//  ScanAnimationView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/16.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ScanAnimationView.h"

@interface ScanAnimationView ()

@property(nonatomic,strong)UILabel *progressLabel;

@end

@implementation ScanAnimationView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *imageOne = [UIImage imageNamed:@"1_"];
        UIImage *imageTwo = [UIImage imageNamed:@"2_"];
        UIImage *imageThree = [UIImage imageNamed:@"3_"];
//        UIImage *imageFour = [UIImage imageNamed:@"4_"];
//        UIImage *imageFive = [UIImage imageNamed:@"5_"];
        NSArray *imagesArray = @[imageOne,imageTwo,imageThree];
        
        self.animationImages = imagesArray;
        self.animationDuration = 1.0f;
        self.animationRepeatCount = 0;
        [self startAnimating];
        
    }
    return self;
}

-(void)setScanImage:(NSString *)imageName andScanLabelText:(NSString *)text
{
    // 扫码图片
    CGFloat scanImageWidth = 26.0f;
    CGFloat scanImageX = self.frame.size.width / 2 - scanImageWidth / 2;
    CGFloat scanImageY = self.frame.size.height / 2 - scanImageWidth / 2 - 5.0f;
    UIImageView *scanImage = [[UIImageView alloc] initWithFrame:CGRectMake(scanImageX, scanImageY, scanImageWidth, scanImageWidth)];
    scanImage.image = [UIImage imageNamed:imageName]; // scan_charge_btn
    [self addSubview:scanImage];
    
    // 扫码充电文本
    CGFloat scanLabelWidth = 48.0f;
    CGFloat scanLabelHeight = 12.0f;
    CGFloat scanLabelX = self.frame.size.width / 2 - scanLabelWidth / 2;
    CGFloat scanLabelY = scanImage.frame.origin.y + scanImage.frame.size.height;
    UILabel *scanLabel = [[UILabel alloc] initWithFrame:CGRectMake(scanLabelX, scanLabelY, scanLabelWidth, scanLabelHeight)];
    scanLabel.text = text; // 扫码充电
    scanLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    scanLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:10.0f];
    scanLabel.textAlignment = NSTextAlignmentCenter;
    scanLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:scanLabel];
}

- (void)setScanLabelText:(NSString *)text
{
    CGFloat width = 42.0f;
    CGFloat height = 15.0f;
    CGFloat x = self.frame.size.width / 2 - width / 2;
    CGFloat y = self.frame.size.height / 2 - height / 2;
    if (self.progressLabel == nil) {
        self.progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        self.progressLabel.font = [UIFont fontWithName:@"PingFang-SC-Heavy" size:20];
        self.progressLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.progressLabel.textAlignment = NSTextAlignmentCenter;
        self.progressLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.progressLabel];
    }
    self.progressLabel.text = [NSString stringWithFormat:@"%@%%",text];
}

//-(void)setScanImage:(NSString *)imageName andTipLabel:(n)

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
