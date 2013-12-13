//
//  PageView.m
//  PreciousMoments
//
//  Created by LingYun on 12-9-21.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "PageView.h"


#define albumNameTextField_x        18
#define albumNameTextField_y        240
#define albumNameTextField_width    200
#define albumNameTextField_height   28

#define albumDescriptionLabel_x      18
#define albumDescriptionLabel_y      268
#define albumDescriptionLabel_width  280
#define albumDescriptionLabel_height 40

@implementation PageView
@synthesize albumImageView;
@synthesize albumNameTextField,albumDescriptionLabel;
@synthesize delegate,albumName,fileName;

- (NSData *)getLastImageFileDataFromImageFileDirectory {
    NSString *viewTag=[NSString stringWithFormat:@"%d",self.tag];
    NSArray *fileArray=[[DatabaseOperator shareDatabaseOperator] selectAllImageInformationWithViewTagFromTable:viewTag];
    NSLog(@"array:%@",fileArray);
    ImageInformation *imageInfo=[fileArray lastObject];
    NSString *lastImageFilePath=imageInfo.imagePath;
    NSLog(@"filePath:%@",lastImageFilePath);
    self.albumName=imageInfo.imageAlbumName;
    self.fileName=imageInfo.imageFileName;
    NSData *lastImageFileData=[NSData dataWithContentsOfFile:lastImageFilePath];
    return lastImageFileData;
}

- (void)loadAddAlbumView {
    addAlbumButton=[UIButton buttonWithType:UIButtonTypeCustom];
    addAlbumButton.frame=CGRectMake(130, 140, 60, 60);
    addAlbumButton.tag=self.tag;
    addAlbumButton.frame=CGRectMake(addAlbumButton.frame.origin.x, addAlbumButton.frame.origin.y-40, addAlbumButton.frame.size.width, addAlbumButton.frame.size.height);
    [addAlbumButton addTarget:self action:@selector(addAlbumButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [addAlbumButton setBackgroundImage:[UIImage imageNamed:@"plus_big.png"] forState:UIControlStateNormal];
    [self addSubview:addAlbumButton];
}

- (void)loadAlbumImageView {
    albumImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, self.frame.size.height-1)];
    NSData *imageData=[self getLastImageFileDataFromImageFileDirectory];
    if(imageData)
        albumImageView.userInteractionEnabled=YES;
    else
        albumImageView.userInteractionEnabled=YES;
    albumImageView.image=[UIImage imageWithData:imageData];
    albumImageView.tag=self.tag;
    [self addSubview:albumImageView];
    
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(albumImageViewDidTapped:)];
    tapGestureRecognizer.numberOfTapsRequired=1;
    [albumImageView addGestureRecognizer:tapGestureRecognizer];
    [tapGestureRecognizer release];
}


- (void)loadAlbumNameView {
    albumNameTextField=[[UITextField alloc] initWithFrame:CGRectMake(albumNameTextField_x, albumNameTextField_y, albumNameTextField_width,albumNameTextField_height)];
    albumNameTextField.delegate=self;
    albumNameTextField.borderStyle=UITextBorderStyleNone;
    if(!albumName||[albumName length]==0) {
        switch (self.tag) {
            case 100:
                albumNameTextField.text=@"我的家庭";
                break;
            case 101:
                albumNameTextField.text=@"自己";
                break;
            case 102:
                break;
            default:
                albumNameTextField.text=[NSString stringWithFormat:@"相册%d",self.tag-102];
                break;
        }
    }
    else
        albumNameTextField.text=albumName;
    albumNameTextField.tag=self.tag;
    albumNameTextField.enabled=NO;
    albumNameTextField.textColor=[UIColor whiteColor];
    albumNameTextField.backgroundColor=[UIColor clearColor];
    albumNameTextField.font=[UIFont boldSystemFontOfSize:20];
    [self addSubview:albumNameTextField];
}

- (void)loadAlbumDescriptionView {
    albumDescriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(albumDescriptionLabel_x, albumDescriptionLabel_y, albumDescriptionLabel_width, albumDescriptionLabel_height)];
    albumDescriptionLabel.backgroundColor=[UIColor clearColor];
    albumDescriptionLabel.numberOfLines=2;
//    if([GlobalDefine currentSystemVersion]>=6)
//        albumDescriptionLabel.lineBreakMode=NSLineBreakByTruncatingTail;
//    else
//        albumDescriptionLabel.lineBreakMode=UILineBreakModeTailTruncation;
    albumDescriptionLabel.textColor=[UIColor whiteColor];
    albumDescriptionLabel.font=[UIFont systemFontOfSize:14];
    albumDescriptionLabel.tag=self.tag;
    albumDescriptionLabel.text=@"134dafsfsafdsafdsafdsfdsafsfadsafdsafdsfadsafdsafsdfadfsfadsafdsafdsafdfsafdsafdsafdadsfsafdsfds";
    [self addSubview:albumDescriptionLabel];
}

- (void)initUI {
    [self loadAddAlbumView];
    [self loadAlbumImageView];
    [self loadAlbumNameView];
    [self loadAlbumDescriptionView];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowNotification:) name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHiddenNotification:) name:UIKeyboardDidHideNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame andTag:(NSInteger)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        albumName=nil;
        self.tag=tag;
        [self initUI];
    }
    return self;
}



#pragma mark----
#pragma mark------------UITextFieldDelegate------------
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self moveAnimation:-120];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self moveAnimation:120];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return NO;
}

#pragma mark----
#pragma mark-----------Events----------
- (void)addAlbumButtonDidPressed:(id)sender {
    if(self.delegate&&[delegate respondsToSelector:@selector(addAlbumButtonDidTapped:)]){
        [delegate addAlbumButtonDidTapped:sender];
    }
}

- (void)albumImageViewDidTapped:(UIGestureRecognizer  *)tapGR {
    if(self.delegate&&[delegate respondsToSelector:@selector(albumImageViewDidTouch:)])
        [delegate albumImageViewDidTouch:tapGR];
}


- (void)moveAnimation:(CGFloat)offset{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y+offset, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}



#pragma mark----
#pragma mark-----------NSNotification Event-----------
- (void)keyboardShowNotification:(NSNotification *)notification {
    //-----显示键盘------
    [self moveAnimation:-60];
}

- (void)keyboardHiddenNotification:(NSNotification *)notification {
    //-----隐藏键盘------
    [self moveAnimation:60];
    //-----锁定输入框-----
    albumNameTextField.enabled=NO;
}




- (void)dealloc {
    [super dealloc];
    [albumImageView release];
    [albumNameTextField release];
    [albumDescriptionLabel release];
    [albumName release];
    [fileName  release];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
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
