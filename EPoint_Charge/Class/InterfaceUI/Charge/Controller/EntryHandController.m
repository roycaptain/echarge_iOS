//
//  EntryHandController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/16.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "EntryHandController.h"
#import "DDTextField.h"
#import "SelectChargeController.h"

#import "ChargingController.h"

@interface EntryHandController ()<DDTextFieldDelegate>

@property(nonatomic,strong)DDTextField *textField;
@property(nonatomic,strong)UIButton *confirmBtn;
@property(nonatomic,strong)UIButton *scanBtn;
@property(nonatomic,strong)UILabel *bottomTip;

@end

@implementation EntryHandController

- (void)viewDidLoad {
    [super viewDidLoad];

    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"输入设备号充电"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
    
    [self textField];
    [self confirmBtn];
    [self scanBtn];
    [self bottomTip];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark private method
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// 确认按钮
-(void)confirmClickAction
{
    NSString *deviceNum = [NSString stringWithFormat:@"%@",self.textField.textField.text];
    deviceNum = [deviceNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    UIStoryboard *chargeSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
    SelectChargeController *selectVC = [chargeSB instantiateViewControllerWithIdentifier:@"SelectChargeController"];
    selectVC.deviceSerialNum = deviceNum;
    [self.navigationController pushViewController:selectVC animated:YES];
}

// 扫码充电按钮
-(void)scanChargeClickAction
{
    UIStoryboard *chargeSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
    ChargingController *chargeVC = [chargeSB instantiateViewControllerWithIdentifier:@"ChargingController"];
    [self.navigationController pushViewController:chargeVC animated:YES];
}

#pragma mark lazy load
-(DDTextField *)textField
{
    if (!_textField) {
        CGFloat x = 15.0f;
        CGFloat y = 136.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 27.0f;
        _textField = [[DDTextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_textField setPlaceHolder:@"请输入充电桩编号" andHolderFontOfSize:17.0f andPlaceHolderColor:[UIColor colorWithHexString:@"#999999"]];
        [_textField setUnderLineDefaultColor:[UIColor colorWithHexString:@"#CCCCCC"] andunderLineSelectedColor:[UIColor colorWithHexString:@"#02B1CD"]];
        _textField.delegate = self;
        [self.view addSubview:_textField];
    }
    return _textField;
}

-(UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = 30.0f;
        CGFloat y = 276.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 44.0f;
        _confirmBtn.frame = CGRectMake(x, y, width, height);
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_noclickable"] forState:UIControlStateNormal];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = 22.0f;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        _confirmBtn.enabled = NO;
        [_confirmBtn addTarget:self action:@selector(confirmClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

-(UIButton *)scanBtn
{
    if (!_scanBtn) {
        _scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat width = 60.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] / 2 - width / 2;
        CGFloat y = [GeneralSize getMainScreenHeight] - width - TabBarHeight;
        _scanBtn.frame = CGRectMake(x, y, width, width);
        _scanBtn.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [_scanBtn setImage:[UIImage imageNamed:@"scan_charge_btn"] forState:UIControlStateNormal];
        _scanBtn.layer.cornerRadius = width / 2;
        _scanBtn.layer.masksToBounds = YES;
        [_scanBtn addTarget:self action:@selector(scanChargeClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_scanBtn];
    }
    return _scanBtn;
}

-(UILabel *)bottomTip
{
    if (!_bottomTip) {
        CGFloat width = 48.0f;
        CGFloat height = 12.0f;
        CGFloat x = ([GeneralSize getMainScreenWidth] - width) / 2;
        CGFloat y = _scanBtn.frame.origin.y + _scanBtn.frame.size.height + 8.0f;
        
        _bottomTip = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _bottomTip.text = @"扫码充电";
        _bottomTip.textAlignment = NSTextAlignmentCenter;
        _bottomTip.adjustsFontSizeToFitWidth = YES;
        _bottomTip.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
        _bottomTip.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.view addSubview:_bottomTip];
    }
    return _bottomTip;
}

#pragma mark DDTextFieldDelegate
-(void)ddTextfieldDidChange:(NSString *)text
{
    if (text.length) {
        _confirmBtn.enabled = YES;
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    } else {
        _confirmBtn.enabled = NO;
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_noclickable"] forState:UIControlStateNormal];
    }
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
