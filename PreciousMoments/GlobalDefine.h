//
//  GlobalDefine.h
//  PreciousMoments
//
//  Created by LingYun on 12-9-22.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HomePath        [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define ImageFilePath   @"ImageFile"
#define AudioFilePath   @"AudioFile"

#define DataBaseName    @"PM.db"
#define TableName       @"ImageInformation"

#define NSNotificationTakePhotoDidFinish   @"TakePhotoFinish"
#define NSNotificationDismissModelVC       @"dismissModelViewController"

#define sinaWeiBo_appKey         @"1181202876"
#define sinaWeiBo_appSecret      @"22f321fe70f031e1ffd13fc02aee6170"

#define facebook_appkey          @"448185865224061"
#define facebook_appSecret       @"480d7fe28657c8667eee61b070b484d0"



@interface GlobalDefine : NSObject
{
    
}

/*  获取当前系统版本  */
+(NSUInteger)currentSystemVersion;

/*   显示警告信息   */
+(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message andCancelButton:(NSString *)cancel;


/*  创建数据库  */
+(NSString *)createDBAtHomeDirectoryAndReturnPath;

/*   创建音频文件目录和图片目录  */
+(NSString *)createAudioFileDirectoryAndReturnPath;
+(NSString *)createImageFileDirectoryAndReturnPath;
@end
