//
//  ChargeViewController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/15.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ChargeViewController.h"
#import "EntryHandController.h"
#import "ScanAnimationView.h"
#import "ChargingController.h"
#import "QRCodeController.h"
#import "ChargingController.h"

CGFloat const TipLabelFont = 14.0f; // 扫码文本字体大小
CGFloat const BottomTipWidth = 96.0f; // 手动提示文本宽度
CGFloat const BottomTipHeight = 12.0f; // 手动提示文本高度

@interface ChargeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel; // 扫码提示文本
@property (nonatomic,strong)ScanAnimationView *scanAnimationView; //扫码充电
@property (nonatomic,strong)UIButton *entryBtn; // 手动输入按钮
@property (nonatomic,strong)UILabel *bottomTipLabel; // 手动提示文本

@end

@implementation ChargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma private method
-(void)initUI
{
    [super setNavigationTitle:@"充电"];// 导航栏标题
    [super setNavigationRightButtonItemWithTitle:@"查看充电进度" withTarget:self withAction:@selector(checkChargeSchedule)];
    
    _tipLabel.text = @"扫描充电桩上的二维码即可启动充电";
    _tipLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:TipLabelFont];
    _tipLabel.adjustsFontSizeToFitWidth = YES;
    
    // 扫码充电
    [self scanAnimationView];
    // 手动输入按钮
    [self entryBtn];
    [self bottomTipLabel];
}

-(void)entryClickAction
{
    UIStoryboard *chargeSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
    EntryHandController *entryVC = [chargeSB instantiateViewControllerWithIdentifier:@"EntryHandController"];
    [self.navigationController pushViewController:entryVC animated:YES];
}

-(void)scanChargeClick
{
    UIStoryboard *chargingSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
    QRCodeController *qrcodeVC = [chargingSB instantiateViewControllerWithIdentifier:@"QRCodeController"];
    [self.navigationController pushViewController:qrcodeVC animated:YES];
}

-(void)checkChargeSchedule
{
    UIStoryboard *chargingSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
    ChargingController *chargingVC = [chargingSB instantiateViewControllerWithIdentifier:@"ChargingController"];
    [self.navigationController pushViewController:chargingVC animated:YES];
}

#pragma lazy load
// 扫码充电
-(UIImageView *)scanAnimationView
{
    if (!_scanAnimationView) {
        CGFloat width = [GeneralSize getMainScreenWidth] / 3;
        CGFloat x = [GeneralSize getMainScreenWidth] / 2 - width / 2;
        CGFloat y = _tipLabel.frame.origin.y + _tipLabel.frame.size.height + 90.0f;
        
        _scanAnimationView = [[ScanAnimationView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        [_scanAnimationView setScanImage:@"scan_charge_btn_one" andScanLabelText:@"扫码充电"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanChargeClick)];
        [_scanAnimationView addGestureRecognizer:tap];
        _scanAnimationView.userInteractionEnabled = YES;
        [self.view addSubview:_scanAnimationView];
    }
    return _scanAnimationView;
}

// 手动输入按钮
-(UIButton *)entryBtn
{
    if (!_entryBtn) {
        CGFloat width = [GeneralSize getMainScreenWidth] / 6;
        CGFloat x = [GeneralSize getMainScreenWidth] / 2 - width / 2;
        CGFloat y = [GeneralSize getMainScreenHeight] - 130.0f - width;
        
        _entryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _entryBtn.frame = CGRectMake(x, y, width, width);
        _entryBtn.backgroundColor = [UIColor colorWithHexString:@"13BBC9"];
        _entryBtn.layer.cornerRadius = width / 2;
        _entryBtn.layer.masksToBounds = YES;
        [_entryBtn setImage:[UIImage imageNamed:@"hand_entry"] forState:UIControlStateNormal];
        [_entryBtn addTarget:self action:@selector(entryClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_entryBtn];
    }
    return _entryBtn;
}

// 手动提示文本
-(UILabel *)bottomTipLabel
{
    if (!_bottomTipLabel) {
        CGFloat x = [GeneralSize getMainScreenWidth] / 2 - BottomTipWidth / 2;
        CGFloat y = _entryBtn.frame.origin.y + _entryBtn.frame.size.height + 10.0f;
        _bottomTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, BottomTipWidth, BottomTipHeight)];
        _bottomTipLabel.text = @"手动输入设备号充电";
        _bottomTipLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _bottomTipLabel.textAlignment = NSTextAlignmentCenter;
        _bottomTipLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        _bottomTipLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_bottomTipLabel];
    }
    return _bottomTipLabel;
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
