//
//  MainViewController.m
//  PreciousMoments
//
//  Created by LingYun on 12-9-21.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "MainViewController.h"
#import "TakePhotoViewController.h"
#import "DetailViewController.h"
#import "ImageUtil.h"


@interface MainViewController ()
- (void)loadBottomView;
@end

//static MainViewController *_mainViewController=nil;

@implementation MainViewController
@synthesize bottomView;
@synthesize firstButton,secondButton;

//+ (MainViewController *)shareMainViewController {
//    return _mainViewController;
//}

- (void)viewWillAppear:(BOOL)animated {
    [UIApplication sharedApplication].statusBarHidden=NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    _mainViewController=self;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissModelViewController:) name:NSNotificationDismissModelVC object:nil];
    
	// Do any additional setup after loading the view.
    mainView=[[MainView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    mainView.mainDelegate=self;
    [self.view addSubview:mainView];
}

- (void)loadBottomView {
    
    firstButton=[UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame=CGRectMake(8, 8, 70, 40);
    [firstButton setBackgroundImage:[UIImage imageNamed:@"button_round_clear.png"] forState:UIControlStateNormal];
    [firstButton addTarget:self action:@selector(firstButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [picker.view addSubview:firstButton];
    
    UIImageView *firstImageView=[[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 20, 30)];
    [firstImageView setImage:[UIImage imageNamed:@"flash.png"]];
    [firstButton addSubview:firstImageView];
    [firstImageView release];
    
    firstLabel=[[UILabel alloc] initWithFrame:CGRectMake(24, 7, 40, 26 )];
    firstLabel.backgroundColor=[UIColor clearColor];
    firstLabel.text=@"自动";
    [firstButton addSubview:firstLabel];
    
    secondButton=[UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame=CGRectMake(250, 8, 60,40);
    [secondButton setBackgroundImage:[UIImage imageNamed:@"button_round_clear.png"] forState:UIControlStateNormal];
    [secondButton addTarget:self action:@selector(secondButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [picker.view addSubview:secondButton];
    
    UIImageView *secondImageView=[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 56, 36)];
    [secondImageView setImage:[UIImage imageNamed:@"camera_rotate.png"]];
    [secondButton addSubview:secondImageView];
    [secondImageView release];
    
    if(bottomView)
    {
        [bottomView release];
        bottomView=nil;
    }
    bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 430, 640, 50)];
    bottomView.backgroundColor=[UIColor colorWithRed:202.0/255.0 green:206.0/255.0 blue:212.0/255.0 alpha:1.0];
    
    UIButton *cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame=CGRectMake(15, 12, 30, 30);
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancelButton];
    
    UIButton *takePhotoButton=[UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoButton.frame=CGRectMake(105, 0, 110, 50);
    [takePhotoButton setBackgroundImage:[UIImage imageNamed:@"camera_shot.png"] forState:UIControlStateNormal];
    [takePhotoButton addTarget:self action:@selector(takePhotoButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:takePhotoButton];
    
    UIButton *pickPhotoButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pickPhotoButton.frame=CGRectMake(270, 12, 30, 30);
    [pickPhotoButton setBackgroundImage:[UIImage imageNamed:@"pickPhoto.png"] forState:UIControlStateNormal];
    [pickPhotoButton addTarget:self action:@selector(pickPhotoButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:pickPhotoButton];
    
    [picker.view addSubview:bottomView];
}

#pragma mark-
#pragma mark------------MainViewDelegate-----------

-(void)takePhotoButtonDidTapped:(id)sender{
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
        if(picker){
            [picker release];
            picker=nil;
        }
        picker=[[UIImagePickerController alloc] init];
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        picker.showsCameraControls=NO;
        picker.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
        picker.cameraViewTransform=CGAffineTransformScale(picker.cameraViewTransform, 1.0, 1.0);
        picker.delegate=self;	//take photo delegate,
        
     
       //------自定义拍照界面--------
        [self performSelector:@selector(loadBottomView) withObject:nil afterDelay:0.8];
        
        [self presentModalViewController:picker animated:YES];
	}
}


-(void)calendarButtonDidTapped:(id)sender{
    
}

- (void)albumImageViewDidPressed:(UIGestureRecognizer *)tapGR {
    NSLog(@"view:%@",[tapGR view]);
    UIImageView *tapGRImageView=(UIImageView *)[tapGR view];
    PageView *pageView=(PageView *)[tapGRImageView superview];
    
    DetailViewController *detailVC=[[DetailViewController alloc] init];
    detailVC.fileName=[pageView fileName];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

#pragma mark-
#pragma mark---------UIBarButtonItem Event--------

- (void)firstButtonDidPressed:(id)sender {
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    if(btn.isSelected){
        firstLabel.text=@"关闭";
        picker.cameraFlashMode=UIImagePickerControllerCameraFlashModeOff;
    }
    else{
        firstLabel.text=@"自动";
        picker.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
    }
}

- (void)secondButtonDidPressed:(id)sender {
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    if(btn.isSelected){
        picker.cameraDevice=UIImagePickerControllerCameraDeviceFront;
        firstButton.hidden=YES;
    }
    else{
        picker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
        firstButton.hidden=NO;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:(btn.isSelected?UIViewAnimationTransitionFlipFromLeft:UIViewAnimationTransitionFlipFromRight) forView:picker.view cache:NO];
    [UIView setAnimationDuration:0.5];
    [UIView commitAnimations];
}

- (void)cancelButtonDidPressed:(id)sender {
    [self imagePickerControllerDidCancel:picker];
}

- (void)takePhotoButtonDidPressed:(id)sender {
    [firstButton setHidden:YES];
    [secondButton setHidden:YES];
    [picker takePicture];
}

- (void)openPhotoLibrary {
    [self presentModalViewController:photoPicker animated:YES];
}
- (void)pickPhotoButtonDidPressed:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
        if(picker){
            [picker dismissModalViewControllerAnimated:NO];
            picker=nil;
        }
        
        if(!photoPicker){
            photoPicker=[[UIImagePickerController alloc] init];
            photoPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            photoPicker.delegate=self;	//take photo delegate,
        }
        [self performSelector:@selector(openPhotoLibrary) withObject:nil afterDelay:0.4];
	}
}


#pragma mark-
#pragma mark-------------UIImagePickerControllerDelegate----------
- (void)imagePickerController:(UIImagePickerController *)pick didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if([pick sourceType]==UIImagePickerControllerSourceTypeCamera||[pick sourceType]==UIImagePickerControllerSourceTypePhotoLibrary)//take photo delegate
	{
		//执行拍照的代理方法
		NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
		if([mediaType isEqualToString:@"public.image"])
		{
			UIImage *imageJPEG=[info objectForKey:UIImagePickerControllerOriginalImage];
            UIImage *newImageJPEG=[ImageUtil image:imageJPEG fitInSize:CGSizeMake(640, 960)];
            TakePhotoViewController *takePhotoVC=[[TakePhotoViewController alloc] init];
			takePhotoVC.takeImage=newImageJPEG;
            [bottomView setHidden:YES];
            takePhotoVC.albumName=[[[mainView currentPageView] albumNameTextField] text];
            takePhotoVC.viewTag=[NSString stringWithFormat:@"%d",[[mainView currentPageView] tag]];
			[self.navigationController pushViewController:takePhotoVC animated:YES];
            [takePhotoVC release];
            [pick dismissModalViewControllerAnimated:NO];
		}
	}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)pick{
    [pick dismissModalViewControllerAnimated:YES];
}

- (void)dismissModelViewController:(NSNotification *)notification {
//    [picker dismissModalViewControllerAnimated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNotificationDismissModelVC object:nil];
//    if(_mainViewController)
//        [_mainViewController release];
    [mainView release];
//    [takePhotoVC release];
    [picker release];
    [photoPicker release];
    [bottomView release];
    [firstLabel release];
    [super dealloc];
}

@end
