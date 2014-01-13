//
//  ResultManager.m
//  womenhealth
//
//  Created by Er Li on 12/9/13.
//  Copyright (c) 2013 codes. All rights reserved.
//

#import "ResultManager.h"

@implementation ResultManager
@synthesize resultDictionary = _resultDictionary;
+ (id)sharedInstance{
    
    static ResultManager *sharedInstance = nil;
    
    if (!sharedInstance) {
        sharedInstance = [[ResultManager alloc] init];
    }
    return sharedInstance;
}
-(void)createPlistFile{
    _resultDictionary = [[NSMutableDictionary alloc] init];
}
-(void)saveResultWithValue :(NSString *)value withKey: (NSString *)key {
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [paths objectAtIndex:0];
//    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
    
    //_resultDictionary = [[NSMutableDictionary alloc] init];
    [_resultDictionary setObject:value forKey:key];
   // [_resultDictionary writeToFile:plistPath atomically:YES];
      
    NSLog(@"%@",_resultDictionary);

   
}
-(NSData *)getData{
//    NSError *error;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [paths objectAtIndex:0];
//    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
//    
//    BOOL settingsExist = [[NSFileManager defaultManager] fileExistsAtPath:plistPath];
//    if(settingsExist){
//        NSLog(@"file found!");
//        //[[NSFileManager defaultManager]  removeItemAtPath:plistPath error:&error];
//    }
//    else{
//        NSLog(@"file not found!");
//    }
//    
//    
//    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc] init];
//    [resultDictionary setObject:@"aaa" forKey:@"bbb"];
//    [resultDictionary setObject:@"ccc" forKey:@"ddd"];
//    
//    NSLog(@"%hhd",   [resultDictionary writeToFile:plistPath atomically: TRUE]);
//    NSLog(@"%@",plistPath);
//    
//    NSMutableDictionary *resultDictionar  = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    NSLog(@"%@",resultDictionar);
    NSLog(@"Upload data");
    [self showResult];
    NSData *pData = [NSPropertyListSerialization dataFromPropertyList:_resultDictionary format:NSPropertyListXMLFormat_v1_0 errorDescription:nil];
    NSLog(@"data %@",pData);
    return pData;
}

-(void)upload:(NSString *)filename{
    NSString *urlString = @"http://smartpark.bu.edu/mylifecloud/admin/receive_file.php";
    
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.plist\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[self getData]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postbody];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", returnString);

}
-(void)showResult{
    NSLog(@"Result %@",_resultDictionary);
}
@end
