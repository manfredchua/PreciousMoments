//
//  PMRootViewController.m
//  PreciousMoments
//
//  Created by LingYun on 12-9-21.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "PMRootViewController.h"
#import "MainViewController.h"


@interface PMRootViewController ()

@end

@implementation PMRootViewController

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
    self.view.backgroundColor=[UIColor blackColor];
    [selfView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MainViewController *mainVC=[[MainViewController alloc] init];
    nav=[[UINavigationController alloc] initWithRootViewController:mainVC];
    nav.navigationBarHidden=YES;
    [mainVC release];
    [self.view addSubview:nav.view];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [nav release];
    [super dealloc];
}

@end
