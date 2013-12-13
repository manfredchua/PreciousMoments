//
//  ShareViewController.h
//  PreciousMoments
//
//  Created by FOX on 12-10-10.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    shareFacebook=0,
    shareSinaWeiBo,
    shareEmail,
}ShareType;

@interface ShareViewController : UIViewController<UITextViewDelegate>
{
    ShareType shareType;
    
    UIToolbar *keyboardToolbar;
    UITextView *textView;
    
    UIImage  *shareImage;
    NSString *shareText;
}
@property(nonatomic,assign)ShareType shareType;

@property(nonatomic,retain)UIImage  *shareImage;
@property(nonatomic,retain)NSString *shareText;


@end
