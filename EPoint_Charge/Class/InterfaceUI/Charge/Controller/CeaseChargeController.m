//
//  CeaseChargeController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/17.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "CeaseChargeController.h"

@interface CeaseChargeController ()

@property(nonatomic,strong)UIImageView *statusImageView;
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)UIButton *submitBtn;

@end

@implementation CeaseChargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark pravite method
-(void)initUI
{
    [super setHideNavigationBarBackItem];
    [super setNavigationTitle:@"充电完成"];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [self statusImageView];
    [self statusLabel];
    [self submitBtn];
}

#pragma mark lazy load
-(UIImageView *)statusImageView
{
    if (!_statusImageView) {
        CGFloat width = 151.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] / 2 - width / 2;
        CGFloat y = 134.0f;
        _statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        NSString *imageName = _status ? @"charge_normal_complete" : @"charge_unusual_complete";
        [_statusImageView setImage:[UIImage imageNamed:imageName]];
        [self.view addSubview:_statusImageView];
    }
    return _statusImageView;
}

-(UILabel *)statusLabel
{
    if (!_statusLabel) {
        CGFloat x = 129.0f;
        CGFloat y = _statusImageView.frame.origin.y + _statusImageView.frame.size.height + 36.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 20.0f;
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _statusLabel.text = @"充电正常完成";
        _statusLabel.font = [UIFont fontWithName:@"PingFang-SC-Heavy" size:20];
        NSString *colorString = _status ? @"#13BBC9" : @"#999999";
        _statusLabel.textColor = [UIColor colorWithHexString:colorString];
        [self.view addSubview:_statusLabel];
    }
    return _statusLabel;
}

-(UIButton *)submitBtn
{
    if (!_submitBtn) {
        CGFloat x = 30.0f;
        CGFloat height = 44.0f;
        CGFloat y = [GeneralSize getMainScreenHeight] - height * 2;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(x, y, width, height);
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        [_submitBtn setTitle:@"完成" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(backRootClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitBtn];
    }
    return _submitBtn;
}

#pragma mark - click
-(void)backRootClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
