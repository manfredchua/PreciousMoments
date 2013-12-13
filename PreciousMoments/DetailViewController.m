//
//  DetailViewController.m
//  PreciousMoments
//
//  Created by FOX on 12-10-10.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()
- (void)getImageFromDatabaseWithFileName:(NSString *)fileName;
@end

@implementation DetailViewController

@synthesize fileName;
@synthesize weiboEngine;

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
    detailView=[[DetailView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    detailView.delegate=self;
    [self.view addSubview:detailView];
    
    [self getImageFromDatabaseWithFileName:fileName];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


#pragma mark-
#pragma mark----------Private Methods-------
- (void)getImageFromDatabaseWithFileName:(NSString *)fn {
    imageInfo=[[DatabaseOperator shareDatabaseOperator] selectImageInformationFromTableWithFileName:fn];
    if(imageInfo){
        NSString *filePath=[imageInfo imagePath];
        [[detailView imageView] setImage:[UIImage imageWithContentsOfFile:filePath]];
        [[detailView textDescriptionLabel] setText:[imageInfo imageTextDescription]];
    }
}


#pragma mark-
#pragma mark-------DetailViewDelegate---------

- (void)facebookButtonDidTapped:(id)sender {
    
}

- (void)sinaButtonDidTapped:(id)sender {
    WBEngine *engine=[[WBEngine alloc] initWithAppKey:sinaWeiBo_appKey appSecret:sinaWeiBo_appSecret];
    [engine setRootViewController:self];
    [engine setDelegate:self];
    [engine setRedirectURI:@""];
    [engine setIsUserExclusive:NO];
    self.weiboEngine=engine;
    [engine release];
    if(![weiboEngine isLoggedIn])
        [weiboEngine logIn];
}

- (void)emailButtonDidTapped:(id)sender {
    
}

- (void)playButtonDidTapped:(id)sender {
    
}

- (void)forwardButtonDidTapped:(id)sender {
    
}

- (void)backwardButtonDidTapped:(id)sender {
    
}

- (void)backBarButtonDidTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionBarButtonDidTapped:(id)sender {
    
}


#pragma mark-
#pragma mark----------WBEngineDelegate----------
- (void)engineDidLogIn:(WBEngine *)engine {
    UIImage *shareImage=nil;
    [engine sendWeiBoWithText:@"" image:shareImage];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [detailView release];
    [weiboEngine release];
    [super dealloc];
}

@end
