//
//  UIImageView+LoadNetworkImage.h
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/4.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LoadNetworkImage)

-(void)loadNetworkImageWithURL:(NSString *)urlString placeholderImageWithImageName:(NSString *)imageName;

@end
