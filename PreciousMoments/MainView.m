//
//  MainView.m
//  PreciousMoments
//
//  Created by LingYun on 12-9-21.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "MainView.h"
#import "SettingViewController.h"

#define NumberOfAlbums           2

#define TimerDownSecond          2.0

#define PageView_tag             100

#define mainScrollView_height    340

#define takePhotoButton_y        341
#define takePhotoButton_width    164
#define takePhotoButton_height   124

#define calendarButton_x         160
#define calendarButton_y         takePhotoButton_y
#define calendarButton_width     164
#define calendarButton_height    takePhotoButton_height


@implementation MainView
@synthesize nowString;
@synthesize textFieldString;
@synthesize mainDelegate;
@synthesize currentPageView;

- (void)loadTakePhotoView {
    takePhotoButton=[UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoButton.frame=CGRectMake(-3, takePhotoButton_y, takePhotoButton_width, takePhotoButton_height);
    [takePhotoButton addTarget:self action:@selector(takePhotoButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [takePhotoButton setImage:[UIImage imageNamed:@"blue_box.png"] forState:UIControlStateNormal];
    [self addSubview:takePhotoButton];
    
    UILabel *takePhotoLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, takePhotoButton_y+10, 80, 30)];
    takePhotoLabel.backgroundColor=[UIColor clearColor];
    takePhotoLabel.textColor=[UIColor blackColor];
    takePhotoLabel.font=[UIFont boldSystemFontOfSize:18];
    takePhotoLabel.text=@"拍 照";
    [self addSubview:takePhotoLabel];
    [takePhotoLabel release];
    
    UIImageView *takePhotoImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    takePhotoImage.image=[UIImage imageNamed:@"camera_large.png"];
    takePhotoImage.center=takePhotoButton.center;
    takePhotoImage.frame=CGRectMake(takePhotoImage.frame.origin.x, takePhotoImage.frame.origin.y+12, takePhotoImage.frame.size.width, takePhotoImage.frame.size.height);
    [self addSubview:takePhotoImage];
    [takePhotoImage release];
}

- (void)loadCalendarView {
    calendarButton=[UIButton buttonWithType:UIButtonTypeCustom];
    calendarButton.frame=CGRectMake(calendarButton_x, calendarButton_y, calendarButton_width, calendarButton_height);
    [calendarButton addTarget:self action:@selector(calendarButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [calendarButton setImage:[UIImage imageNamed:@"pink_box.png"] forState:UIControlStateNormal];
    [self addSubview:calendarButton];
    
    UILabel *calendarLabel=[[UILabel alloc] initWithFrame:CGRectMake(calendarButton_x+10, calendarButton_y+10, 80, 30)];
    calendarLabel.backgroundColor=[UIColor clearColor];
    calendarLabel.textColor=[UIColor blackColor];
    calendarLabel.font=[UIFont boldSystemFontOfSize:18];
    calendarLabel.text=@"今 天";
    [self addSubview:calendarLabel];
    [calendarLabel release];
    
    UIImageView *calendarImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    calendarImageView.image=[UIImage imageNamed:@"calendar.png"];
    calendarImageView.center=calendarButton.center;
    calendarImageView.frame=CGRectMake(calendarImageView.frame.origin.x, calendarImageView.frame.origin.y+6, calendarImageView.frame.size.width, calendarImageView.frame.size.height);
    [self addSubview:calendarImageView];
    [calendarImageView release];
    
    monthFirstLabel=[[UILabel alloc] initWithFrame:CGRectMake(calendarButton_x+68, calendarButton_y+15, calendarButton_width, calendarButton_height)];
    monthFirstLabel.backgroundColor=[UIColor clearColor];
    monthFirstLabel.textColor=[UIColor blackColor];
    monthFirstLabel.font=[UIFont boldSystemFontOfSize:20];
    monthFirstLabel.text=@"0";
    [self addSubview:monthFirstLabel];
    
    monthSecondLabel=[[UILabel alloc] initWithFrame:CGRectMake(calendarButton_x+82, calendarButton_y+15, calendarButton_width, calendarButton_height)];
    monthSecondLabel.backgroundColor=[UIColor clearColor];
    monthSecondLabel.textColor=[UIColor blackColor];
    monthSecondLabel.font=[UIFont boldSystemFontOfSize:20];
    monthSecondLabel.text=@"0";
    [self addSubview:monthSecondLabel];
    
    [self onTimer];
}

- (void)loadMainScrollView {
    mainScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, mainScrollView_height)];
    mainScrollView.backgroundColor=[UIColor lightGrayColor];
    mainScrollView.delegate=self;
    mainScrollView.scrollEnabled=YES;
    mainScrollView.pagingEnabled=YES;
    mainScrollView.showsHorizontalScrollIndicator=NO;
    mainScrollView.showsVerticalScrollIndicator=NO;
    [self addSubview:mainScrollView];
    
    pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(100, mainScrollView_height-30, 120, 10)];
    pageControl.currentPage=0;
    pageControl.numberOfPages=NumberOfAlbums;
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
}

- (void) loadSettingView {
    settingButton=[UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.frame=CGRectMake(262, -4, 40, 60);
    [settingButton addTarget:self action:@selector(settingButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"bookmark_gear.png"] forState:UIControlStateNormal];
    [self addSubview:settingButton];
}

- (void)loadPageView {
    for(int i=0;i<NumberOfAlbums;i++){
        PageView *pageView=[[PageView alloc] initWithFrame:CGRectMake(i*320, 0, 320, mainScrollView_height-1) andTag:PageView_tag+i];
        pageView.delegate=self;
        [mainScrollView addSubview:pageView];
        [pageView release];
    }
    currentPageView=(PageView *)[mainScrollView viewWithTag:PageView_tag];
    [mainScrollView setContentSize:CGSizeMake(NumberOfAlbums*320, mainScrollView_height)];
}

- (void)loadKeyboardToolbar {
    keyboardToolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *cancelBarButton=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelBarButtonDidPressed:)];
    UIBarButtonItem *spaceBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *saveBarButton=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBarButtonDidPressed:)];
    NSArray *barButtonItems=[NSArray arrayWithObjects:cancelBarButton,spaceBarButton,saveBarButton,nil];
    
    [cancelBarButton release];[spaceBarButton release];[saveBarButton release];
    keyboardToolbar.items=barButtonItems;
    keyboardToolbar.hidden=YES;
    [self addSubview:keyboardToolbar];
}

- (void)loadSettingBackgroundView {
    alphaBackgroundView=[[UIView alloc] initWithFrame:CGRectMake(0, 460, 320, 70)];
    alphaBackgroundView.backgroundColor=[UIColor blackColor];
    alphaBackgroundView.alpha=0.75;
    [self addSubview:alphaBackgroundView];
}

- (void)initUI {
    [self loadTakePhotoView];
    [self loadCalendarView];
    [self loadMainScrollView];
    [self loadSettingView];
    [self loadPageView];
    [self loadKeyboardToolbar];
    [self loadSettingBackgroundView];
}

- (void)stopLoop {
    [calendarTimer invalidate];
    calendarTimer=nil;
    monthFirstLabel.text=[nowString substringToIndex:1];
    monthSecondLabel.text=[nowString substringFromIndex:1];
}

- (void)startLoop {
    if(timerInt>=10)
        timerInt=timerInt-10;
    NSLog(@"timerInt:%d",timerInt);
    switch (timerInt%10){
        case 0:
            monthFirstLabel.text=@"0";
            monthSecondLabel.text=@"9";
            break;
        case 1:
            monthFirstLabel.text=@"1";
            monthSecondLabel.text=@"8";
            break;
        case 2:
            monthFirstLabel.text=@"2";
            monthSecondLabel.text=@"7";
            break;
        case 3:
            monthFirstLabel.text=@"3";
            monthSecondLabel.text=@"6";
            break;
        case 4:
            monthFirstLabel.text=@"4";
            monthSecondLabel.text=@"5";
            break;
        case 5:
            monthFirstLabel.text=@"5";
            monthSecondLabel.text=@"4";
            break;
        case 6:
            monthFirstLabel.text=@"6";
            monthSecondLabel.text=@"3";
            break;
        case 7:
            monthFirstLabel.text=@"7";
            monthSecondLabel.text=@"2";
            break;
        case 8:
            monthFirstLabel.text=@"8";
            monthSecondLabel.text=@"1";
            break;
        case 9:
            monthFirstLabel.text=@"9";
            monthSecondLabel.text=@"0";
            break;
    }
    timerInt++;
}

- (void)onTimer{
    calendarTimer=[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(startLoop) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:TimerDownSecond target:self selector:@selector(stopLoop) userInfo:nil repeats:NO];
}


#pragma mark-
#pragma mark--------------Timer Event---------




#pragma mark-
#pragma mark--------UIButton Event-----------
- (void)takePhotoButtonDidPressed:(id)sender {
    if(self.mainDelegate&&[mainDelegate respondsToSelector:@selector(takePhotoButtonDidTapped:)]){
        [mainDelegate takePhotoButtonDidTapped:sender];
    }
}

- (void)calendarButtonDidPressed:(id)sender {
    if(self.mainDelegate&&[mainDelegate respondsToSelector:@selector(calendarButtonDidTapped:)]){
        [mainDelegate calendarButtonDidTapped:sender];
    }
}

//-------动画结束时，删除导航控制器-------
- (void)releaseNavigationController {
    [nav.view removeFromSuperview];
    [nav release];
}

- (void)settingButtonDidPressed:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if([btn isSelected]){
        SettingViewController *settingVC=[[SettingViewController alloc] init];
        nav=[[UINavigationController alloc] initWithRootViewController:settingVC];
        [settingVC release];
        nav.view.frame=CGRectMake(0, -390, 320, 390);
        [nav setNavigationBarHidden:YES];
        [self addSubview:nav.view];
        
        [self bringSubviewToFront:settingButton];
        [settingButton setBackgroundImage:[UIImage imageNamed:@"bookmark_cross.png"] forState:UIControlStateNormal];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.3];
        nav.view.frame=CGRectMake(0, 0, 320, 390);
        settingButton.frame=CGRectMake(262, 386, 40, 60);
        alphaBackgroundView.frame=CGRectMake(0, 390, 320, 70);
        [UIView commitAnimations];
    }
    else {
        [settingButton setBackgroundImage:[UIImage imageNamed:@"bookmark_gear.png"] forState:UIControlStateNormal];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.3];
        nav.view.frame=CGRectMake(0, -390, 320, 390);
        settingButton.frame=CGRectMake(262, -4, 40, 60);
        alphaBackgroundView.frame=CGRectMake(0, 460, 320, 70);
        [UIView setAnimationDidStopSelector:@selector(releaseNavigationController)];
        [UIView commitAnimations];
    }
}


#pragma mark -
#pragma mark ---------------UIScrollViewDelegate------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index;
    index = fabs(scrollView.contentOffset.x) / 320;
	pageControl.currentPage = index;
    currentPageView=(PageView *)[mainScrollView viewWithTag:PageView_tag+index];
}

#pragma mark -
#pragma mark---------------UIPageControl Event-------------
- (void)changePage:(id)sender {
    int page=pageControl.currentPage;
    CGRect frame=mainScrollView.frame;
    frame.origin.x=frame.size.width*page;
    frame.origin.y=0;
    [mainScrollView scrollRectToVisible:frame animated:YES];
    currentPageView=(PageView *)[mainScrollView viewWithTag:PageView_tag+page];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        timerInt=1;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recevieNotification:) name:NSNotificationTakePhotoDidFinish object:nil];
        
        NSDate *now=[NSDate date];
        NSDateFormatter *formater=[[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd"];
        [formater setTimeZone:[NSTimeZone localTimeZone]];
        [formater setLocale:[NSLocale currentLocale]];
        self.nowString=[[formater stringFromDate:now] substringFromIndex:8];
        self.backgroundColor=[UIColor whiteColor];
        self.userInteractionEnabled=YES;
        [formater release];
        [self initUI];
        
    }
    return self;
}


#pragma mark----
#pragma mark---------PageViewDelegate------
- (void)addAlbumButtonDidTapped:(id)sender{
    NSInteger buttonTag=[(UIButton *)sender tag];
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"编辑相册名称",/*@"加/更换封面照片",*/@"取消", nil];
    [actionSheet showInView:self];
    actionSheet.tag=buttonTag;
    [actionSheet release];
}

- (void)albumImageViewDidTouch:(UIGestureRecognizer *)tapGR {
    if(self.mainDelegate&&[mainDelegate respondsToSelector:@selector(albumImageViewDidPressed:)])
        [mainDelegate albumImageViewDidPressed:tapGR];
}


#pragma mark----
#pragma mark---------UIActionSheetDelegate--------
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger buttonTag=[actionSheet tag];
    PageView *pageView=(PageView *)[mainScrollView viewWithTag:buttonTag];
    self.textFieldString=[[pageView albumNameTextField] text];
    if(buttonIndex==0){
        [[pageView albumNameTextField] setEnabled:YES];
        [[pageView albumNameTextField] becomeFirstResponder];
        [[pageView albumNameTextField] setInputAccessoryView:(UIView *)keyboardToolbar];
        [keyboardToolbar setTag:buttonTag];
        [keyboardToolbar setHidden:NO];
    }
}

#pragma mark----
#pragma mark-------UIToolBar--------
- (void)cancelBarButtonDidPressed:(id)sender {
    NSInteger toolbarTag=[keyboardToolbar tag];
    PageView *pageView=(PageView *)[mainScrollView viewWithTag:toolbarTag];
    [[pageView albumNameTextField] setText:self.textFieldString];
    [[pageView albumNameTextField] resignFirstResponder];
    [[pageView albumNameTextField] setEnabled:NO];
    [keyboardToolbar setHidden:YES];
}

- (void)saveBarButtonDidPressed:(id)sender {
    //-----获取保存的pageView-----
    NSInteger toolbarTag=[keyboardToolbar tag];
    PageView *pageView=(PageView *)[mainScrollView viewWithTag:toolbarTag];
    //-----更新数据库中的相册名------
    [[DatabaseOperator shareDatabaseOperator] updateTableWithAlbumName:self.textFieldString andNewAlbumName:[[pageView albumNameTextField] text]];
    
    [[pageView albumNameTextField] resignFirstResponder];
    [[pageView albumNameTextField] setEnabled:NO];
    [keyboardToolbar setHidden:YES];
}

#pragma mark-
#pragma mark---------NSNotificationCenter---------
- (void)recevieNotification:(NSNotification *)notification {
    NSDictionary *userInfo=[notification userInfo];
    UIImage *takePhotoImage=[userInfo objectForKey:@"takePhotoImage"];
    [[currentPageView albumImageView] setImage:takePhotoImage];
    [[currentPageView albumImageView] setUserInteractionEnabled:YES];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNotificationTakePhotoDidFinish object:nil];
    [mainScrollView release];
    if(currentPageView)
        [currentPageView release];
    [pageControl    release];
    [keyboardToolbar release];
    [alphaBackgroundView release];
    [monthFirstLabel release];
    [monthSecondLabel release];
    [super dealloc];
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
