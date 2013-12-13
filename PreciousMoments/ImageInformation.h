//
//  ImageInformation.h
//  PreciousMoments
//
//  Created by FOX on 12-10-9.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageInformation : NSObject
{
    NSString *_imageID;
    NSString *_viewTag;
    NSString *_imageAlbumName;
    NSString *_imageFileName;
    NSString *_imagePath;
    NSString *_audioPathOfImage;
    NSString *_imageTextDescription;
    NSString *_currentMonth;
}
@property(nonatomic,retain)NSString *imageID;
@property(nonatomic,retain)NSString *viewTag;
@property(nonatomic,retain)NSString *imageAlbumName;
@property(nonatomic,retain)NSString *imageFileName;
@property(nonatomic,retain)NSString *imagePath;
@property(nonatomic,retain)NSString *audioPathOfImage;
@property(nonatomic,retain)NSString *imageTextDescription;
@property(nonatomic,retain)NSString *currentMonth;
@end
