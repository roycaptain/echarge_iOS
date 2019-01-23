//
//  SetupController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "SetupController.h"
#import "SetButton.h"
#import "AboutUsController.h"
#import "ChangePWController.h"
#import "LoginController.h"
#import "AppDelegate.h"

CGFloat const SetTableRowHeight = 55.0f; // 单元格行高

@interface SetupController ()

@property(nonatomic,strong)SetButton *changePWBtn; // 修改密码
@property(nonatomic,strong)SetButton *aboutBtn; // 关于我们
@property(nonatomic,strong)SetButton *clearBtn; // 清除缓存

@property(nonatomic,strong)UIButton *loginout; // 退出登录

@end

@implementation SetupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - lazy load
-(SetButton *)changePWBtn
{
    if (!_changePWBtn) {
        CGFloat x = 0.0f;
        CGFloat y = 76.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = SetTableRowHeight;
        
        _changePWBtn = [SetButton buttonWithType:UIButtonTypeCustom];
        _changePWBtn.frame = CGRectMake(x, y, width, height);
        [_changePWBtn setSetButtonHeadTitle:@"修改密码"];
        [_changePWBtn setSetButtonAccessoryImageView];
        [_changePWBtn addTarget:self action:@selector(changePWClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_changePWBtn];
    }
    return _changePWBtn;
}

-(SetButton *)aboutBtn
{
    if (!_aboutBtn) {
        CGFloat x = 0.0f;
        CGFloat y = _changePWBtn.frame.origin.y + _changePWBtn.frame.size.height + 1.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = SetTableRowHeight;
        
        _aboutBtn = [SetButton buttonWithType:UIButtonTypeCustom];
        _aboutBtn.frame = CGRectMake(x, y, width, height);
        [_aboutBtn setSetButtonAccessoryImageView];
        [_aboutBtn setSetButtonHeadTitle:@"关于我们"];
        [_aboutBtn addTarget:self action:@selector(aboutClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_aboutBtn];
    }
    return _aboutBtn;
}

-(SetButton *)clearBtn
{
    if (!_clearBtn) {
        CGFloat x = 0.0f;
        CGFloat y = _aboutBtn.frame.origin.y + 12.0f + SetTableRowHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = SetTableRowHeight;
        
        _clearBtn = [SetButton buttonWithType:UIButtonTypeCustom];
        _clearBtn.frame = CGRectMake(x, y, width, height);
        [_clearBtn setSetButtonHeadTitle:@"清除缓存"];
        [_clearBtn addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_clearBtn];
    }
    return _clearBtn;
}

// 退出登录按钮
-(UIButton *)loginout
{
    if (!_loginout) {
        CGFloat x = 0.0f;
        CGFloat y = _clearBtn.frame.origin.y + 12.0f + SetTableRowHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = SetTableRowHeight;
        
        _loginout = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginout.frame = CGRectMake(x, y, width, height);
        _loginout.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        [_loginout setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [_loginout setTitle:@"退出登录" forState:UIControlStateNormal];
        [_loginout setTitleColor:[UIColor colorWithHexString:@"#CC0000"] forState:UIControlStateNormal];
        [_loginout addTarget:self action:@selector(loginoutClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginout];
    }
    return _loginout;
}

#pragma mark - private method
-(void)initUI
{
    [super setNavigationTitle:@"系统设置"];
    [super setNavigationBarBackItem];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    [super setNavigationBarOpaqueStyle];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
    
    [self changePWBtn];
    [self aboutBtn];
    [self clearBtn];
    [self loginout];
    
    // 计算缓存
    __weak typeof(self) weakSelf = self;
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSString *cacheSize = [NSString stringWithFormat:@"%.1fM",[[FileManager shareInstance] getCachesSize]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.clearBtn setSetButtonDetailTitle:cacheSize];
        });
    });
}

#pragma mark - Button Click 
-(void)changePWClick
{
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    ChangePWController *changePWVC = [mineSB instantiateViewControllerWithIdentifier:@"ChangePWController"];
    [self.navigationController pushViewController:changePWVC animated:YES];
}

-(void)aboutClick
{
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    AboutUsController *aboutVC = [mineSB instantiateViewControllerWithIdentifier:@"AboutUsController"];
    [self.navigationController pushViewController:aboutVC animated:YES];
}

-(void)clearClick
{
    [CustomAlertView showWithMessage:@"正在清理..."];
    [[FileManager shareInstance] clearCachesSize];
    [CustomAlertView hide];
    __weak typeof(self) weakSelf = self;
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSString *cacheSize = [NSString stringWithFormat:@"%.1fM",[[FileManager shareInstance] getCachesSize]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.clearBtn setSetButtonDetailTitle:cacheSize];
        });
    });
}

-(void)loginoutClick
{
    [[UserInfoManager shareInstance] loginOut];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    LoginController *loginVC = [loginSB instantiateViewControllerWithIdentifier:@"LoginController"];
    app.window.rootViewController = loginVC;
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
