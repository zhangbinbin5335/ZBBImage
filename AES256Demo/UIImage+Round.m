//
//  UIImage+Round.m
//  AES256Demo
//
//  Created by zhangbinbin on 16/4/14.
//  Copyright © 2016年 zhangbinbin. All rights reserved.
//

#import "UIImage+Round.h"

@implementation UIImage (Round)

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (id)createRoundedRectImage:(UIImage*)image radius:(CGFloat)radius
{
    return [self createRoundedRectImage:image radius:radius margin:0];
}

+ (id)createRoundedRectImage:(UIImage*)image radius:(CGFloat)radius margin:(CGFloat)margin
{
    return [self createRoundedRectImage:image size:image.size radius:radius margin:margin];
}

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(CGFloat)radius
{
    return [self createRoundedRectImage:image size:size radius:radius margin:0];
}

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(CGFloat)radius margin:(CGFloat)margin
{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    CGFloat scale = image.size.width / w * 1.;
    NSLog(@"scale = %f",scale);
    
    // Create a graphics image context
    CGSize newSize = CGSizeMake(w, h);
    UIGraphicsBeginImageContextWithOptions(newSize, YES, image.size.width / w * 1.);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    // Get the new image from the context
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGRect rect = CGRectMake(0, 0, w, h);
//    
//    if (margin != 0)
//    {
//        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
//        CGContextFillRect(context, rect);
//    }
//    
//    CGContextBeginPath(context);
//    addRoundedRectToPath(context, CGRectMake(margin / 2., margin / 2., w - margin, h - margin), radius, radius);
//    CGContextClosePath(context);
//    CGContextClip(context);
//    
//    CGContextDrawImage(context, CGRectMake(margin / 2., margin / 2., w - margin, h - margin), img.CGImage);
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    img = [UIImage imageWithCGImage:imageMasked];
//    
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    CGImageRelease(imageMasked);
    
    return img;
}

@end
