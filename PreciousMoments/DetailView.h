//
//  DetailView.h
//  PreciousMoments
//
//  Created by FOX on 12-10-10.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailViewDelegate <NSObject>
- (void)facebookButtonDidTapped:(id)sender;
- (void)sinaButtonDidTapped:(id)sender;
- (void)emailButtonDidTapped:(id)sender;
- (void)playButtonDidTapped:(id)sender;
- (void)forwardButtonDidTapped:(id)sender;
- (void)backwardButtonDidTapped:(id)sender;

- (void)backBarButtonDidTapped:(id)sender;
- (void)actionBarButtonDidTapped:(id)sender;
@end

@interface DetailView : UIView
{
    UIImageView *imageView;
    UILabel   *textDescriptionLabel;
    UIToolbar *topToolbar;
    UIButton  *facebookButton;
    UIButton  *sinaButton;
    UIButton  *emailButton;
    UIButton  *playButton;
    
    id<DetailViewDelegate>delegate;
}
@property(nonatomic,assign)id<DetailViewDelegate>delegate;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UILabel     *textDescriptionLabel;
@end
