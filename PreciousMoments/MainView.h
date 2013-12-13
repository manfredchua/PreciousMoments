//
//  MainView.h
//  PreciousMoments
//
//  Created by LingYun on 12-9-21.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageView.h"

@protocol MainViewDelegate <NSObject>
-(void)takePhotoButtonDidTapped:(id)sender;
-(void) calendarButtonDidTapped:(id)sender;
-(void)albumImageViewDidPressed:(UIGestureRecognizer *)tapGR;
@end

@interface MainView : UIView<UIScrollViewDelegate,PageViewDelegate,UIActionSheetDelegate>
{
    UIScrollView *mainScrollView;
    UIPageControl *pageControl;
    UIButton *takePhotoButton;
    UIButton *calendarButton;
    UIButton *settingButton;
    
    PageView *currentPageView;
    
    UILabel  *monthFirstLabel;
    UILabel  *monthSecondLabel;
    
    UIToolbar *keyboardToolbar;
    UIView    *alphaBackgroundView;
    UINavigationController *nav;
    
    NSString *textFieldString;
    NSString *nowString;
    
    NSTimer *calendarTimer;
    NSInteger timerInt;
    id<MainViewDelegate>mainDelegate;
}
@property(nonatomic,assign)id<MainViewDelegate>mainDelegate;
@property(nonatomic,retain)PageView *currentPageView;
@property(nonatomic,retain)NSString *textFieldString;
@property(nonatomic,retain)NSString *nowString;
@end
