//
//  TakePhotoView.h
//  PreciousMoments
//
//  Created by LingYun on 12-10-5.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TakePhotoViewDelegate <NSObject>
-(void)playButtonDidTapped:(id)sender;
-(void)recordButtonDidTapped:(id)sender;
-(void)fuguButtonDidTapped:(id)sender;

-(void)cancelBarButtonDidTapped:(id)sender;
-(void)saveBarButtonDidTapped:(id)sender;
@end

@interface TakePhotoView : UIView
{
    UIImageView *imageView;
    UIToolbar   *toolbar;
    UIButton    *playButton;
    UIButton    *fuguButton;
    
    UIButton    *recordButton;
    UILabel     *timeDownSecondLabel;
    UILabel     *speLabel;
    UILabel     *timeDownMSecLabel;
    
    UILabel     *showLabel;
    UIImageView *showImageView;
    NSTimer     *downTimer;
    
    NSInteger   msValue;
    id<TakePhotoViewDelegate>delegate;
}
@property(nonatomic,assign)id<TakePhotoViewDelegate>delegate;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UILabel     *timeDownLabel;
@property(nonatomic,retain)UIButton    *playButton;
@end
