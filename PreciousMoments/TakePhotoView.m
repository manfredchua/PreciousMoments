//
//  TakePhotoView.m
//  PreciousMoments
//
//  Created by LingYun on 12-10-5.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "TakePhotoView.h"


#define playButton_Width            60
#define playButton_Height           60

#define timeDownLabel_x             30
#define timeDownLabel_y             340
#define timeDownLabel_Width         80
#define timeDownLabel_Height        26

#define recordButton_x              15
#define recordButton_y              365
#define recordButton_Width          80
#define recordButton_Height         40

#define fuguButton_x                245
#define fuguButton_y                370
#define fuguButton_Width            70
#define fuguButton_Height           30

@implementation TakePhotoView
@synthesize delegate;
@synthesize imageView,timeDownLabel;
@synthesize playButton;

#pragma mark-
#pragma mark-------Memory manager--------
- (void)dealloc {
    [imageView release];
    [timeDownLabel release];
    [showImageView release];
    [showLabel release];
    [timeDownMSecLabel release];
    [timeDownSecondLabel release];
    [speLabel release];
    [toolbar release];
    [super dealloc];
}

#pragma mark-
#pragma mark-----------init UI---------
- (void)loadImageView {
    imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    imageView.userInteractionEnabled=YES;
    [self addSubview:imageView];
    
    UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTapped:)];
    tapGR.numberOfTapsRequired=1;
    [imageView addGestureRecognizer:tapGR];
    [tapGR release];
}

- (void)loadPlayButton {
    playButton=[UIButton buttonWithType:UIButtonTypeCustom];
    playButton.frame=CGRectMake(0, 0, playButton_Width, playButton_Height);
    playButton.center=self.center;
    [playButton addTarget:self action:@selector(playButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [playButton setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [self addSubview:playButton];
}

- (void)loadTimeDownLabel {
    timeDownSecondLabel=[[UILabel alloc] initWithFrame:CGRectMake(timeDownLabel_x, timeDownLabel_y, timeDownLabel_Width-50, timeDownLabel_Height)];
    timeDownSecondLabel.backgroundColor=[UIColor clearColor];
    timeDownSecondLabel.font=[UIFont fontWithName:@"DBLCDTempBlack" size:16];
    timeDownSecondLabel.text=@"10";
    [self addSubview:timeDownSecondLabel];
    
    speLabel=[[UILabel alloc] initWithFrame:CGRectMake(timeDownLabel_x+22, timeDownLabel_y-2, timeDownLabel_Width-70, timeDownLabel_Height)];
    speLabel.backgroundColor=[UIColor clearColor];
    speLabel.font=[UIFont fontWithName:@"DBLCDTempBlack" size:16];
    speLabel.text=@":";
    [self addSubview:speLabel];

    
    timeDownMSecLabel=[[UILabel alloc] initWithFrame:CGRectMake(timeDownLabel_x+32, timeDownLabel_y, timeDownLabel_Width-45, timeDownLabel_Height)];
    timeDownMSecLabel.backgroundColor=[UIColor clearColor];
    timeDownMSecLabel.font=[UIFont fontWithName:@"DBLCDTempBlack" size:16];
    timeDownMSecLabel.text=@"00";
    [self addSubview:timeDownMSecLabel];
}

- (void)loadRecordButton {
    recordButton=[UIButton buttonWithType:UIButtonTypeCustom];
    recordButton.frame=CGRectMake(recordButton_x, recordButton_y, recordButton_Width, recordButton_Height);
    [recordButton addTarget:self action:@selector(recordButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [recordButton setBackgroundImage:[UIImage imageNamed:@"button_round_clear.png"] forState:UIControlStateNormal];
    [self addSubview:recordButton];
    
    UIImageView *micImageView=[[UIImageView alloc] initWithFrame:CGRectMake(7, 5, 26, 30)];
    [micImageView setImage:[UIImage imageNamed:@"mic.png"]];
    [recordButton addSubview:micImageView];
    [micImageView release];
    
    showImageView=[[UIImageView alloc] initWithFrame:CGRectMake(45, 5, 12, 12)];
    [showImageView setImage:[UIImage imageNamed:@"reddot.png"]];
    [recordButton addSubview:showImageView];
    
    showLabel=[[UILabel alloc] initWithFrame:CGRectMake(35, 10, 45, 25)];
    showLabel.backgroundColor=[UIColor clearColor];
    showLabel.text=@"start";
    [recordButton addSubview:showLabel];
}

- (void)loadFUGUButton {
    fuguButton=[UIButton buttonWithType:UIButtonTypeCustom];
    fuguButton.frame=CGRectMake(fuguButton_x, fuguButton_y, fuguButton_Width, fuguButton_Height);
    [fuguButton addTarget:self action:@selector(fuguButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [fuguButton setBackgroundImage:[UIImage imageNamed:@"button_round_clear.png"] forState:UIControlStateNormal];
    [self addSubview:fuguButton];
    
    UIImageView *contrastImageView=[[UIImageView alloc] initWithFrame:CGRectMake(7, 3, 24, 24)];
    [contrastImageView setImage:[UIImage imageNamed:@"contrast.png"]];
    [fuguButton addSubview:contrastImageView];
    [contrastImageView release];
    
    UILabel *proLabel=[[UILabel alloc] initWithFrame:CGRectMake(34,0,36,26)];
    proLabel.backgroundColor=[UIColor clearColor];
    proLabel.text=@"pro";
    [fuguButton addSubview:proLabel];
    [proLabel release];
}

- (void)loadToolbar {
    toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 416, 320, 44)];
    toolbar.barStyle=UIBarStyleBlackTranslucent;
    [self addSubview:toolbar];
    
    UIBarButtonItem *flexSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *cancelBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cross.png"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelBarButtonDidPressed:)];
    UIBarButtonItem *flexSpace1=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *saveBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tick.png"] style:UIBarButtonItemStylePlain target:self action:@selector(saveBarButtonDidPressed:)];
    UIBarButtonItem *flexSpace2=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSArray *barButtonArray=[[NSArray alloc] initWithObjects:flexSpace,cancelBarButtonItem,flexSpace1,saveBarButtonItem,flexSpace2, nil];
    toolbar.items=barButtonArray;
    [flexSpace release];[cancelBarButtonItem release];[flexSpace1 release];
    [saveBarButtonItem release];[flexSpace2 release];
    [barButtonArray release];
}


#pragma mark-
#pragma mark-------------Private Method---------
- (void)resetLabel {
    showLabel.text=@"start";
    timeDownSecondLabel.text=@"10";
    timeDownMSecLabel.text=@"00";
    [downTimer invalidate];
    downTimer=nil;
}

- (NSString *)stayTwoValidData:(NSInteger)value {
    NSString *twoValidString=[NSString stringWithFormat:@"%@%d",@"0",value];
    return twoValidString;
}

- (void)setStringWithLabel:(UILabel *)label andTextIntValue:(NSInteger)value {
    if(value<10)
        label.text=[self stayTwoValidData:value];
    else
        label.text=[NSString stringWithFormat:@"%d",value];
}

- (void)startTimeDown {
    msValue--;
    if(msValue==0){
        NSInteger secondNum=[[timeDownSecondLabel text] intValue];
        if(secondNum==0){//----停止录音----
            [self resetLabel];
            [self recordButtonDidPressed:recordButton];
        }
        else
            [self setStringWithLabel:timeDownSecondLabel andTextIntValue:secondNum-1];
        msValue=100;
    }
    else 
        [self setStringWithLabel:timeDownMSecLabel andTextIntValue:msValue];
}

- (void)startTimerDownIsRecording:(BOOL)isRecording {
    if(isRecording){
        showLabel.text=@"stop";
        downTimer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(startTimeDown) userInfo:nil repeats:YES];
        imageView.userInteractionEnabled=NO;//--正在录音时不可以隐藏按钮--
    }
    else {//---停止录音时重新设置----
        imageView.userInteractionEnabled=YES;
        [self resetLabel];
    }
}


#pragma mark-
#pragma mark-------UIButton Event-----------
- (void)playButtonDidPressed:(id)sender {
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    if(btn.isSelected){
        [btn setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        imageView.userInteractionEnabled=NO;
    }
    else {
        [btn setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        imageView.userInteractionEnabled=YES;
    }
    
    if(self.delegate&&[delegate respondsToSelector:@selector(playButtonDidTapped:)])
        [delegate playButtonDidTapped:btn];
}

- (void)recordButtonDidPressed:(id)sender {
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    [self startTimerDownIsRecording:btn.isSelected];
    if(self.delegate&&[delegate respondsToSelector:@selector(recordButtonDidTapped:)])
        [delegate recordButtonDidTapped:btn];
}

- (void)fuguButtonDidPressed:(id)sender {
    if(self.delegate&&[delegate respondsToSelector:@selector(fuguButtonDidTapped:)])
        [delegate fuguButtonDidTapped:sender];
}


#pragma mark-
#pragma mark-------UIBarButtonItem Event---------
- (void)cancelBarButtonDidPressed:(id)sender {
    if(self.delegate&&[delegate respondsToSelector:@selector(cancelBarButtonDidTapped:)])
        [delegate cancelBarButtonDidTapped:sender];
}

- (void)saveBarButtonDidPressed:(id)sender {
    if(self.delegate&&[delegate respondsToSelector:@selector(saveBarButtonDidTapped:)])
        [delegate saveBarButtonDidTapped:sender];
}

#pragma mark-
#pragma mark-----------UITapGestureRecognizer---------
- (void)imageViewDidTapped:(UITapGestureRecognizer *)tapGr {
    playButton.hidden=!playButton.hidden;
    
    showLabel.hidden=!showLabel.hidden;
    recordButton.hidden=!recordButton.hidden;
    timeDownSecondLabel.hidden=!timeDownSecondLabel.hidden;
    timeDownMSecLabel.hidden=!timeDownMSecLabel.hidden;
    speLabel.hidden=!speLabel.hidden;
    
    fuguButton.hidden=!fuguButton.hidden;
    
    toolbar.hidden=!toolbar.hidden;
}

- (void)initUI {
    [self loadImageView];
    [self loadPlayButton];
    [self loadTimeDownLabel];
    [self loadRecordButton];
    [self loadFUGUButton];
    [self loadToolbar];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        msValue=100;
        [self initUI];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
