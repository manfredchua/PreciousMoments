//
//  ShareViewController.m
//  PreciousMoments
//
//  Created by FOX on 12-10-10.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

@synthesize shareType;
@synthesize shareImage,shareText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initUI {
    if(!keyboardToolbar) {
        keyboardToolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *spaceBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *saveBarButton=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(saveBarButtonDidPressed:)];
        NSArray *barButtonItems=[NSArray arrayWithObjects:spaceBarButton,saveBarButton,nil];
        [spaceBarButton release];[saveBarButton release];
        keyboardToolbar.items=barButtonItems;
    }
    
    textView=[[UITextView alloc] initWithFrame:CGRectMake(8, 10, 304, 100)];
    textView.delegate=self;
    textView.textColor=[UIColor darkGrayColor];
    textView.font=[UIFont systemFontOfSize:16];
    textView.scrollEnabled=YES;
    textView.pagingEnabled=NO;
    textView.layer.masksToBounds=YES;
    textView.layer.cornerRadius=8;
    textView.layer.borderWidth=1.0;
    textView.layer.borderColor = [[UIColor grayColor] CGColor];
    textView.text=shareText;
    textView.inputAccessoryView=(UIView *)keyboardToolbar;
    [self.view addSubview:textView];
    [textView release];
}

- (void)loadView {
    UIView *selfView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view=selfView;
    self.view.backgroundColor=[UIColor blackColor];
    [selfView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initUI];
    switch (shareType) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)saveBarButtonDidPressed:(id)sender {
    [textView resignFirstResponder];
}

#pragma mark-
#pragma mark--------UITextViewDelegate---------
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(range.location>255)
        return NO;
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [keyboardToolbar release];
    [shareImage release];
    [shareText release];
    [super dealloc];
}

@end
