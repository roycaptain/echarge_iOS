//
//  MessageDetailController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/7.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "MessageDetailController.h"

@interface MessageDetailController ()

@property(nonatomic,strong)UITextView *contentView;

@end

@implementation MessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - lazy load
-(UITextView *)contentView
{
    if (!_contentView) {
        CGFloat x = 17.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight + 39.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        
        _contentView = [[UITextView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _contentView.editable = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:self.messageTitle];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    
    [self contentView];
    self.contentView.attributedText = [self setStringJustifyAlign:self.content];
}

#pragma mark - 设置两端对齐
-(NSAttributedString *)setStringJustifyAlign:(NSString *)text
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *dictionary = @{
                                 NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#666666"],
                                 NSFontAttributeName : [UIFont fontWithName:@"PingFang SC" size:14.0f],
                                 NSParagraphStyleAttributeName : paragraphStyle,
                                 NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleNone]
                                 };
    [attributeString setAttributes:dictionary range:NSMakeRange(0, attributeString.length)];
    NSAttributedString *astring = [attributeString copy];
    return astring;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
