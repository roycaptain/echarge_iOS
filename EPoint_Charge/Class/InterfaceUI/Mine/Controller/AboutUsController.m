//
//  AboutUsController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "AboutUsController.h"
#import "SetButton.h"
#import "CompanyProfileController.h"

@interface AboutUsController ()

@property(nonatomic,strong)SetButton *versionBtn; // 版本信息
@property(nonatomic,strong)SetButton *profileBtn; // 公司简介

@end

@implementation AboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - lazy load
-(SetButton *)versionBtn
{
    if (!_versionBtn) {
        CGFloat x = 0.0f;
        CGFloat y = 76.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _versionBtn = [SetButton buttonWithType:UIButtonTypeCustom];
        _versionBtn.frame = CGRectMake(x, y, width, height);
        [_versionBtn setSetButtonHeadTitle:@"版本信息"];
        [self.view addSubview:_versionBtn];
    }
    return _versionBtn;
}

-(SetButton *)profileBtn
{
    if (!_profileBtn) {
        CGFloat x = 0.0f;
        CGFloat y = _versionBtn.frame.origin.y + _versionBtn.frame.size.height + 1.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 55.0f;
        
        _profileBtn = [SetButton buttonWithType:UIButtonTypeCustom];
        _profileBtn.frame = CGRectMake(x, y, width, height);
        [_profileBtn setSetButtonHeadTitle:@"公司简介"];
        [_profileBtn setSetButtonAccessoryImageView];
        [_profileBtn addTarget:self action:@selector(profileClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_profileBtn];
    }
    return _profileBtn;
}

#pragma mark - private method
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"关于我们"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
    
    [self versionBtn];
    [self profileBtn];
    
    // 当前版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [NSString stringWithFormat:@"V %@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [_versionBtn setSetButtonDetailTitle:version];
}

#pragma mark - click
-(void)profileClick
{
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    CompanyProfileController *profileVC = [mineSB instantiateViewControllerWithIdentifier:@"CompanyProfileController"];
    [self.navigationController pushViewController:profileVC animated:YES];
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
