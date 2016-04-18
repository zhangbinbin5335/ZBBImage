//
//  NSString+CCCryptUtil.h
//  AES256Demo
//
//  Created by zhangbinbin on 16/4/11.
//  Copyright © 2016年 zhangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CCCryptUtil)

+ (NSString*)md5:(NSString*)key;

+ (NSData*)AES256Encrypt:(NSString*)strSource withKey:(NSString*)key;

+ (NSString*)AES256Decrypt:(NSData*)dataSource withKey:(NSString*)key;

@end
