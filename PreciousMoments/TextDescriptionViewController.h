//
//  TextDescriptionViewController.h
//  PreciousMoments
//
//  Created by LingYun on 12-10-6.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TextDescriptionViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>
{
    UITextView  *textDescriptionView;
    UITextField *textField;
    
    UIImage     *takePhotoImage;
    NSString    *fileName;
    NSString    *albumName;
    NSString    *viewTag;
}
@property(nonatomic,retain)UITextView *textDescriptionView;
@property(nonatomic,retain)UIImage    *takePhotoImage;
@property(nonatomic,retain)NSString   *fileName;
@property(nonatomic,retain)NSString   *albumName;
@property(nonatomic,retain)NSString   *viewTag;
@end
