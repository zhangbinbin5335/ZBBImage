//
//  UIImage+Round.h
//  AES256Demo
//
//  Created by zhangbinbin on 16/4/14.
//  Copyright © 2016年 zhangbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Round)

+ (id)createRoundedRectImage:(UIImage*)image radius:(CGFloat)radius;

+ (id)createRoundedRectImage:(UIImage*)image radius:(CGFloat)r margin:(CGFloat)margin;

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(CGFloat)r;

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(CGFloat)r margin:(CGFloat)margin;

@end
