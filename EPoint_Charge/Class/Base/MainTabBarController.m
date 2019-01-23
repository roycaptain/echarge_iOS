//
//  MainTabBarController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/15.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // 设置TabBar背景颜色
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [GeneralSize getMainScreenWidth], 49)];
    backView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    // 选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#02B1CD"],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    // 添加TabBar控件按钮和控制器
    [self initTabBar];
    
}

// 添加TabBar控件按钮和控制器
-(void)initTabBar
{
    // 找桩
    UIImage *pileNormal = [[UIImage imageNamed:@"tabbar_findpile_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *pileSelect = [[UIImage imageNamed:@"tabbar_findpile_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIStoryboard *pileSB = [UIStoryboard storyboardWithName:@"Find" bundle:[NSBundle mainBundle]];
    MainNavigationController *pileNav = [[MainNavigationController alloc] initWithRootViewController:[pileSB instantiateViewControllerWithIdentifier:@"FindViewController"]];
    pileNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"找桩" image:pileNormal selectedImage:pileSelect];
    
    // 充电
    UIImage *chargeNormal = [[UIImage imageNamed:@"tabbar_charge_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *chargeSelect = [[UIImage imageNamed:@"tabbar_charge_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIStoryboard *chargeSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
    MainNavigationController *chargeNav = [[MainNavigationController alloc] initWithRootViewController:[chargeSB instantiateViewControllerWithIdentifier:@"ChargeViewController"]];
    chargeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"充电" image:chargeNormal selectedImage:chargeSelect];
    
    // 我的
    UIImage *mineNormal = [[UIImage imageNamed:@"tabbar_personal_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *mineSelect = [[UIImage imageNamed:@"tabbar_personal_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    MainNavigationController *mineNav = [[MainNavigationController alloc] initWithRootViewController:[mineSB instantiateViewControllerWithIdentifier:@"MineViewController"]];
    mineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:mineNormal selectedImage:mineSelect];
    
    self.viewControllers = @[pileNav,chargeNav,mineNav];
    
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
