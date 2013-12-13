//
//  MainViewController.h
//  PreciousMoments
//
//  Created by LingYun on 12-9-21.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"

@class TakePhotoViewController;
@interface MainViewController : UIViewController<MainViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
//    TakePhotoViewController *takePhotoVC;
    MainView                *mainView;
    
    UIImagePickerController *picker;
    UIImagePickerController *photoPicker;
    UIView *bottomView;
    UIButton *firstButton;
    UILabel *firstLabel;
    UIButton *secondButton;
}
@property(nonatomic,retain)UIView *bottomView;
@property(nonatomic,retain)UIButton *firstButton;
@property(nonatomic,retain)UIButton *secondButton;
//+(MainViewController *)shareMainViewController;
@end
