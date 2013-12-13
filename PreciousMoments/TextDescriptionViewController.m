//
//  TextDescriptionViewController.m
//  PreciousMoments
//
//  Created by LingYun on 12-10-6.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "TextDescriptionViewController.h"
#import "MainViewController.h"

#define  MAXCHAR  80

@interface TextDescriptionViewController ()
- (void)initUI;
@end

@implementation TextDescriptionViewController
@synthesize textDescriptionView,takePhotoImage,fileName;
@synthesize albumName,viewTag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    UIView *selfView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view=selfView;
    self.view.backgroundColor=[UIColor whiteColor];
    [selfView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [UIApplication sharedApplication].statusBarHidden=NO;
    [self initUI];
}

- (void)loadToolbar {
    UIToolbar *topToolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    topToolbar.tintColor=[UIColor grayColor];
    
    UIBarButtonItem *backBarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonDidPressed:)];
    UIBarButtonItem *flexBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *saveBarButton=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveBarButtonDidPressed:)];
    NSArray *itemsArray=[[NSArray alloc] initWithObjects:backBarButton,flexBarButton,saveBarButton, nil];
    topToolbar.items=itemsArray;
    [backBarButton release];[flexBarButton release];[saveBarButton release];
    [itemsArray release];
    
    [self.view addSubview:topToolbar];
}

- (void)loadTextDescriptionView {
    textDescriptionView=[[UITextView alloc] initWithFrame:CGRectMake(8, 50, 304, 170)];
    textDescriptionView.delegate=self;
    textDescriptionView.textColor=[UIColor darkGrayColor];
    textDescriptionView.font=[UIFont systemFontOfSize:16];
    textDescriptionView.scrollEnabled=YES;
    textDescriptionView.pagingEnabled=NO;
    textDescriptionView.layer.masksToBounds=YES;
    textDescriptionView.layer.cornerRadius=8;
    textDescriptionView.layer.borderWidth=1.0;
    textDescriptionView.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.view addSubview:textDescriptionView];
}

- (void)loadTextField {
    textField=[[UITextField alloc] initWithFrame:CGRectMake(8, 6, 200, 26)];
    textField.borderStyle=UITextBorderStyleNone;
    textField.backgroundColor=[UIColor clearColor];
    textField.enabled=NO;
    textField.placeholder=@"说一说这个珍贵时刻";
    [textDescriptionView addSubview:textField];
}

- (void)initUI {
    [self loadToolbar];
    [self loadTextDescriptionView];
    [self loadTextField];
}

#pragma mark-
#pragma mark---------Private Methods-----------
- (BOOL)saveInfomation {
    NSString *filePath=[NSString stringWithFormat:@"%@/%@.png",[GlobalDefine createImageFileDirectoryAndReturnPath],fileName];
    NSData *imageDataForPNG=UIImagePNGRepresentation(takePhotoImage);
    return [imageDataForPNG writeToFile:filePath atomically:YES];
}

//----- 保存图片信息到数据库中 -----
- (void)saveImageInformationToDatabase {
    ImageInformation *imageInfo=[[ImageInformation alloc] init];
    imageInfo.imageFileName=fileName;
    imageInfo.viewTag=viewTag;
    imageInfo.imageAlbumName=albumName;
    imageInfo.imagePath=[NSString stringWithFormat:@"%@/%@.png",[GlobalDefine createImageFileDirectoryAndReturnPath],fileName];
    imageInfo.audioPathOfImage=[NSString stringWithFormat:@"%@/%@.caf",[GlobalDefine createImageFileDirectoryAndReturnPath],fileName];
    NSString *currentMonth=[fileName substringWithRange:NSMakeRange(5, 2)];//---取出文件的月份,如文件的名字为:2012-10-11_09-44-30.png,currentMonth=10----
    imageInfo.currentMonth=currentMonth;
    imageInfo.imageTextDescription=[textDescriptionView text];
    [[DatabaseOperator shareDatabaseOperator] insertIntoTableWithImageInformation:imageInfo];
    [imageInfo release];
}

- (void)postNotification {
    NSDictionary *userInfo=[NSDictionary dictionaryWithObjectsAndKeys:takePhotoImage,@"takePhotoImage", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationTakePhotoDidFinish object:nil userInfo:userInfo];
}


#pragma mark-
#pragma mark---------UIBarButtonItem Event------------
- (void)backBarButtonDidPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBarButtonDidPressed:(id)sender {
    if([[textDescriptionView text] length]==0){
        [GlobalDefine showAlertWithTitle:@"温馨提示" andMessage:@"您好像忘记说一说这个珍贵时刻了？" andCancelButton:@"现在去说"];
        return;
    }
    if(![self saveInfomation]) {//---保存图片到本地目录下----
        [GlobalDefine showAlertWithTitle:@"温馨提示" andMessage:@"图片文件保存失败" andCancelButton:@"好"];
        return;
    }
    [self saveImageInformationToDatabase];
    [self postNotification];
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationDismissModelVC object:nil userInfo:nil];
}


#pragma mark-
#pragma mark---------UITextViewDelegate--------------
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(range.location>MAXCHAR)
        return NO;
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    if([textView.text length]==0)
        textField.hidden=NO;
    else 
        textField.hidden=YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [textDescriptionView release];
    [textField release];
    [takePhotoImage release];
    [fileName release];
    [albumName release];
    [viewTag release];
    [super dealloc];
}

@end
