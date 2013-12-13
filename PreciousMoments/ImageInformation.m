//
//  ImageInformation.m
//  PreciousMoments
//
//  Created by FOX on 12-10-9.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "ImageInformation.h"

@implementation ImageInformation
@synthesize imageID=_imageID;
@synthesize viewTag=_viewTag;
@synthesize imageAlbumName=_imageAlbumName;
@synthesize imageFileName=_imageFileName;
@synthesize imagePath=_imagePath;
@synthesize audioPathOfImage=_audioPathOfImage;
@synthesize imageTextDescription=_imageTextDescription;
@synthesize currentMonth=_currentMonth;

-(id)init{
    if(self=[super init]){
        self.imageID=nil;
        self.viewTag=nil;
        self.imageAlbumName=nil;
        self.imageFileName=nil;
        self.imagePath=nil;
        self.audioPathOfImage=nil;
        self.imageTextDescription=nil;
        self.currentMonth=nil;
    }
    return self;
}


- (void)dealloc {
    [_imageID release];
    [_viewTag release];
    [_imageAlbumName release];
    [_imageFileName release];
    [_imagePath release];
    [_audioPathOfImage release];
    [_imageTextDescription release];
    [_currentMonth release];
    [super dealloc];
}

@end
