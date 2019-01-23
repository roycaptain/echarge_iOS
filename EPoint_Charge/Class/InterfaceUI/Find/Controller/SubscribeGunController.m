//
//  SubscribeGunController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/7.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import "SubscribeGunController.h"
#import "SubscribeGunCell.h"

NSString *const SubscribeGunCellIdentifier = @"SubscribeGunCellIdentifier";

@interface SubscribeGunController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *selectCollectView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UIButton *cancelBtn; // 取消
@property(nonatomic,strong)UIButton *confirmBtn; // 确认预约

@end

@implementation SubscribeGunController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

#pragma mark - createUI
-(void)createUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"预约充电枪"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    [self layout];
    [self selectCollectView];
    [_selectCollectView registerClass:[SubscribeGunCell class] forCellWithReuseIdentifier:SubscribeGunCellIdentifier];
    [self cancelBtn];
    [self confirmBtn];
}

#pragma mark - lazy load
-(UICollectionViewLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumLineSpacing = 17.0f; // item 纵间距
        _layout.minimumInteritemSpacing = 24.0f; // item之间 行间距
    }
    return _layout;
}

-(UICollectionView *)selectCollectView
{
    if (!_selectCollectView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight + 40.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y - TabBarHeight;
        
        _selectCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(x, y, width, height) collectionViewLayout:_layout];
        _selectCollectView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _selectCollectView.delegate = self;
        _selectCollectView.dataSource = self;
        [self.view addSubview:_selectCollectView];
    }
    return _selectCollectView;
}

-(UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        CGFloat width = [GeneralSize getMainScreenWidth] / 2;
        CGFloat height = 40.0f;
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getMainScreenHeight] - height;
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(x, y, width, height);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#090909"] forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"]];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.view addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

-(UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        CGFloat width = [GeneralSize getMainScreenWidth] / 2;
        CGFloat height = 40.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] / 2;
        CGFloat y = [GeneralSize getMainScreenHeight] - height;
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(x, y, width, height);
        [_confirmBtn setTitle:@"确认预约" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:[UIColor colorWithHexString:@"#32CFC1"]];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.view addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

#pragma mark - UICollectionViewDelegateFlowLayout
// 每个item的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat FilterCellItemWidth = [GeneralSize getMainScreenWidth] - 166.0f;
    return CGSizeMake(FilterCellItemWidth, 40.0f);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubscribeGunCell *cell = (SubscribeGunCell *)[collectionView dequeueReusableCellWithReuseIdentifier:SubscribeGunCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    for (NSInteger i = 0; i < [[_devices objectAtIndex:indexPath.section] count];i++) {
//        if (i == indexPath.item) {
//            [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
//        }else {
//            [collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES];
//        }
//    }
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
