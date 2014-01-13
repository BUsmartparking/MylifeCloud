//
//  ResultManager.h
//  womenhealth
//
//  Created by Er Li on 12/9/13.
//  Copyright (c) 2013 codes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultManager : NSObject
@property (nonatomic,strong) NSMutableDictionary *resultDictionary;
+ (id)sharedInstance;
-(void)createPlistFile;
-(void)saveResultWithValue :(NSString *)value withKey: (NSString *)key ;
-(void)showResult;
-(void)upload:(NSString *)name;
@end
