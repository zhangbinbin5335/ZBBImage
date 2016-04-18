//
//  TestView.m
//  AES256Demo
//
//  Created by zhangbinbin on 16/4/12.
//  Copyright © 2016年 zhangbinbin. All rights reserved.
//

#import "TestView.h"

@implementation TestView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        NSLog(@"color = %@",self.backgroundColor);
    }
    
    return self;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
}

@end
