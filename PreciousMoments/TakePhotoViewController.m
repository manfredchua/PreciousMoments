//
//  TakePhotoViewController.m
//  PreciousMoments
//
//  Created by LingYun on 12-10-5.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "TakePhotoViewController.h"
#import "TextDescriptionViewController.h"
#import "MainViewController.h"
#import "ImageUtil.h"

@interface TakePhotoViewController ()
- (void)isStartRecord:(BOOL)isRecording;
- (void)isStartPlay:(BOOL)isPlay;
- (void)deleteAudioFile;
@end

@implementation TakePhotoViewController
@synthesize takeImage;
@synthesize fileName;
@synthesize albumName;
@synthesize viewTag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    UIView *selfView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    self.view=selfView;
    self.view.backgroundColor=[UIColor blackColor];
    [selfView release];
}

- (void)viewWillAppear:(BOOL)animated {
//    [UIApplication sharedApplication].statusBarHidden=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSDate *now=[NSDate date];
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd_hh-mm-ss"];
    [formater setTimeZone:[NSTimeZone localTimeZone]];
    [formater setLocale:[NSLocale currentLocale]];
    self.fileName=[formater stringFromDate:now];
    [formater release];
    
    fileManager=[[NSFileManager alloc] init];

    takePhotoView=[[TakePhotoView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    takePhotoView.delegate=self;
    [self.view addSubview:takePhotoView];
    
    [[takePhotoView imageView] setImage:takeImage];
}

#pragma mark-
#pragma mark---------Private Methods--------------
- (void)isStartRecord:(BOOL)isRecording {
    if(isRecording){
        NSString *fileDirectory=[GlobalDefine createAudioFileDirectoryAndReturnPath];
        if(fileDirectory!=nil){
            NSString *filePath=[NSString stringWithFormat:@"%@/%@.caf",fileDirectory,fileName];
            NSURL *url=[NSURL URLWithString:filePath];
            if(!audioRecorder){
                audioRecorder=[[AVAudioRecorder alloc] initWithURL:url settings:nil error:nil];
                audioRecorder.delegate=self;
                [audioRecorder recordForDuration:10.0];
            }
            [audioRecorder prepareToRecord];
            [audioRecorder record];
        }
    }else 
        [audioRecorder stop];
}

- (void)isStartPlay:(BOOL)isPlay{
    if(![audioPlayer isPlaying]){
        NSString *filePath=[NSString stringWithFormat:@"%@/%@.caf",[GlobalDefine createAudioFileDirectoryAndReturnPath],fileName];
        if([fileManager fileExistsAtPath:filePath]){
            if(!audioPlayer){
                NSURL *url=[NSURL URLWithString:filePath];
                audioPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                audioPlayer.delegate=self;
            }
            [audioPlayer prepareToPlay];
            [audioPlayer play];
        }
        else {
            [[takePhotoView playButton] setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        }
    }
    else 
        [audioPlayer stop];
    
}


- (void)deleteAudioFile {
    //------删除本地音频文件-------
    NSString *filePath=[NSString stringWithFormat:@"%@/%@.caf",[GlobalDefine createAudioFileDirectoryAndReturnPath],fileName];
    if([fileManager fileExistsAtPath:filePath])
        [fileManager removeItemAtPath:filePath error:nil];
}

#pragma mark-
#pragma mark----------AVAudioRecorderDelegate--------
- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder{
    [recorder stop];
}

#pragma mark-
#pragma mark---------AVAudioPlayerDelegate----------
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    [player stop];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [[takePhotoView playButton] setSelected:NO];
    [[takePhotoView playButton] setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
}

#pragma mark-
#pragma mark----------TakePhotoViewDelegate---------
-(void)playButtonDidTapped:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self isStartPlay:btn.selected];
}

-(void)recordButtonDidTapped:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self isStartRecord:btn.selected];
}

-(void)fuguButtonDidTapped:(id)sender {
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    if(btn.isSelected){
         UIImage *fuguImage=[ImageUtil memory:takeImage];
        [[takePhotoView imageView] setImage:fuguImage];
    }
    else {
        [[takePhotoView imageView] setImage:takeImage];
    }
}

//- (void)showCustomCameraView {
//    [[[MainViewController shareMainViewController] firstButton] setHidden:NO];
//    [[[MainViewController shareMainViewController] secondButton] setHidden:NO];
//}

-(void)cancelBarButtonDidTapped:(id)sender {
    [self deleteAudioFile];
    
    /****取消时，自定义的拍照界面显示出来*****/
//    [[[MainViewController shareMainViewController] bottomView] setHidden:NO];
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self performSelector:@selector(showCustomCameraView) withObject:nil afterDelay:0.9];
}

-(void)saveBarButtonDidTapped:(id)sender {
    TextDescriptionViewController *textDescriptionVC=[[TextDescriptionViewController alloc] init];
    textDescriptionVC.takePhotoImage=[takePhotoView imageView].image;
    textDescriptionVC.fileName=fileName;
    textDescriptionVC.albumName=albumName;
    textDescriptionVC.viewTag=viewTag;
    [self.navigationController pushViewController:textDescriptionVC animated:YES];
    [textDescriptionVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [takePhotoView release];
    if(fileName)
        [fileName release];
    [fileManager release];
    [audioRecorder release];
    [audioPlayer   release];
    [super dealloc];
}

@end
