//
//  UIImageView+LoadNetworkImage.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/4.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "UIImageView+LoadNetworkImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (LoadNetworkImage)

-(void)loadNetworkImageWithURL:(NSString *)urlString placeholderImageWithImageName:(NSString *)imageName
{
    NSURL *url = [NSURL URLWithString:urlString];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:imageName]];
}

@end
