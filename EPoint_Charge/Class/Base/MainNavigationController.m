//
//  MainNavigationController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/16.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置 NavigationBar 的背景颜色
    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"#FFFFFF"];
    // NavigationBar 标题设置
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]}];
    
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
