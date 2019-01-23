//
//  SearchBarView.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/27.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchProtocol<NSObject>

// 开始编辑时
- (void)textFieldBeginEditing;

@end

@interface SearchBarView : UIView<UITextFieldDelegate>

@property(nonatomic,strong)UIImageView *searchIcon;
@property(nonatomic,strong)UITextField *searchTextField;

@property(nonatomic,weak)id<SearchProtocol> delegate;

@end
