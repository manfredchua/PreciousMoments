//
//  GlobalDefine.m
//  PreciousMoments
//
//  Created by LingYun on 12-9-22.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "GlobalDefine.h"

@implementation GlobalDefine

+(NSUInteger)currentSystemVersion {
    return [[[UIDevice currentDevice] systemVersion] intValue];
}


+(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message andCancelButton:(NSString *)cancel{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}


+(NSString *)createDBAtHomeDirectoryAndReturnPath {
    NSString *dbPath=[NSString stringWithFormat:@"%@/%@",HomePath,DataBaseName];
    return dbPath;
}


+(NSString *)createAudioFileDirectoryAndReturnPath {
    NSFileManager *fileManager=[[NSFileManager alloc] init];
    NSString *fileDirectory=[NSString stringWithFormat:@"%@/%@",HomePath,AudioFilePath];
    if([fileManager createDirectoryAtPath:fileDirectory withIntermediateDirectories:YES attributes:nil error:nil]){
        [fileManager release];
        return fileDirectory;
    }
    [fileManager release];
    return nil;
}
+(NSString *)createImageFileDirectoryAndReturnPath {
    NSFileManager *fileManager=[[NSFileManager alloc] init];
    NSString *fileDirectory=[NSString stringWithFormat:@"%@/%@",HomePath,ImageFilePath];
    if([fileManager createDirectoryAtPath:fileDirectory withIntermediateDirectories:YES attributes:nil error:nil]){
        [fileManager release];
        return fileDirectory;
    }
    [fileManager release];
    return nil;
}
@end
