//
//  TakePhotoViewController.h
//  PreciousMoments
//
//  Created by LingYun on 12-10-5.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TakePhotoView.h"

@interface TakePhotoViewController : UIViewController<TakePhotoViewDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    UIImage *takeImage;
   
    TakePhotoView *takePhotoView;
    
    NSString *fileName;
    NSString *albumName;
    NSString *viewTag;
    
    NSFileManager   *fileManager;
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer   *audioPlayer;
}
@property(nonatomic,retain)UIImage *takeImage;
@property(nonatomic,retain)NSString *fileName;
@property(nonatomic,retain)NSString *albumName;
@property(nonatomic,retain)NSString *viewTag;
@end
