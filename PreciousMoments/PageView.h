//
//  PageView.h
//  PreciousMoments
//
//  Created by LingYun on 12-9-21.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageViewDelegate <NSObject>
- (void)addAlbumButtonDidTapped:(id)sender;
- (void)albumImageViewDidTouch:(UIGestureRecognizer *)tapGR;
@end

@interface PageView : UIView<UITextFieldDelegate>
{
    UIButton      *addAlbumButton;
    UIImageView   *albumImageView;
    UITextField   *albumNameTextField;
    UILabel       *albumDescriptionLabel;
    id<PageViewDelegate>delegate;
    
    NSString      *albumName;
    NSString      *fileName;
}

@property(nonatomic,assign)id<PageViewDelegate>delegate;
@property(nonatomic,retain)UITextField *albumNameTextField;
@property(nonatomic,retain)UILabel     *albumDescriptionLabel;
@property(nonatomic,retain)UIImageView *albumImageView;
@property(nonatomic,retain)NSString    *albumName;
@property(nonatomic,retain)NSString    *fileName;

- (id)initWithFrame:(CGRect)frame andTag:(NSInteger)tag;
@end
