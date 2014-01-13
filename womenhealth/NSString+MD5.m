//
//  NSString+MD5.m
//  womenhealth
//
//  Created by Er Li on 1/2/14.
//  Copyright (c) 2014 codes. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (MD5)
-(NSString *)toMD5{
    const char *ptr = [self UTF8String];
    
    unsigned char md5buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, strlen(ptr), md5buffer);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH;i++){
        [output appendFormat:@"%02x",md5buffer[i]];
    }
    return output;
}
@end
