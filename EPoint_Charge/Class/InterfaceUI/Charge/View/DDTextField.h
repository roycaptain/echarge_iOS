//
//  DDTextField.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/16.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 自定义Textfield 
 */
@protocol DDTextFieldDelegate<NSObject>

// 获取输入框内的值
-(void)ddTextfieldDidChange:(NSString *)text;

@end

@interface DDTextField : UIView<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UIColor *underLineDefaultColor; // 默认下划线颜色
@property(nonatomic,strong)UIColor *underLineSelectedColor; // 选中下划线颜色

@property(nonatomic,strong)UIView *underLine; // 下划线
@property(nonatomic,weak)id<DDTextFieldDelegate> delegate;

-(void)setPlaceHolder:(NSString *)placeHolder andHolderFontOfSize:(CGFloat)value andPlaceHolderColor:(UIColor *)placeHolderColor;
-(void)setUnderLineDefaultColor:(UIColor *)underLineDefaultColor andunderLineSelectedColor:(UIColor *)underLineSelectedColor;

@end
