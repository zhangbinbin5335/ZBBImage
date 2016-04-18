//
//  NSData+AES256.h
//  AES256Demo
//
//  Created by zhangbinbin on 16/4/11.
//  Copyright © 2016年 zhangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)

//编码
- (NSData *)AES256EncryptWithKey:(NSString *)key;

//解码
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
