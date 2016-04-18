//
//  NSString+CCCryptUtil.m
//  AES256Demo
//
//  Created by zhangbinbin on 16/4/11.
//  Copyright © 2016年 zhangbinbin. All rights reserved.
//

#import "NSString+CCCryptUtil.h"
#import "NSData+AES256.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CCCryptUtil)

+(NSString *)ret32bitString
{
    char data[32];
    for (int x=0;x< 32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

+(NSString*)md5:(NSString*)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


+ (NSData*)AES256Encrypt:(NSString*)strSource withKey:(NSString*)key
{
    NSData *dataSource = [strSource dataUsingEncoding:NSUTF8StringEncoding];
    
    return [dataSource AES256EncryptWithKey:[self md5:key]];
}

+ (NSString*)AES256Decrypt:(NSData*)dataSource withKey:(NSString*)key
{
    NSData *decryptData = [dataSource AES256DecryptWithKey:[self md5:key]];

    return [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
}



@end
