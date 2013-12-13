//
//  DetailView.m
//  PreciousMoments
//
//  Created by FOX on 12-10-10.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "DetailView.h"

#define imageView_height            416

#define textDescriptionLabel_x      20
#define textDescriptionLabel_y      360
#define textDescriptionLabel_width  280
#define textDescriptionLabel_height 48

#define facebookButton_x            260
#define facebookButton_y            94
#define facebookButton_width        40
#define facebookButton_height       30

#define sinaButton_x                facebookButton_x
#define sinaButton_y                facebookButton_y+facebookButton_height+30
#define sinaButton_width            facebookButton_width
#define sinaButton_height           facebookButton_height

#define emailButton_x               sinaButton_x
#define emailButton_y               sinaButton_y+sinaButton_height+30
#define emailButton_width           sinaButton_width
#define emailButton_height          sinaButton_height

#define playButton_x                emailButton_x
#define playButton_y                emailButton_y+emailButton_height+60
#define playButton_width            emailButton_width+10
#define playButton_height           emailButton_height

#define forwardButton_x             80
#define forwardButton_y             12
#define forwardButton_width         60
#define forwardButton_height        20

#define backwardButton_x            180
#define backwardButton_y            12
#define backwardButton_width        60
#define backwardButton_height       20

@implementation DetailView
@synthesize delegate;
@synthesize imageView,textDescriptionLabel;

-(void)loadImageView {
    imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, imageView_height)];
    [self addSubview:imageView];
}

-(void)loadTextDescriptionView {
    textDescriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(textDescriptionLabel_x, textDescriptionLabel_y, textDescriptionLabel_width, textDescriptionLabel_height)];
    textDescriptionLabel.backgroundColor=[UIColor clearColor];
    textDescriptionLabel.textColor=[UIColor whiteColor];
    textDescriptionLabel.font=[UIFont systemFontOfSize:16];
    [self addSubview:textDescriptionLabel];
}

-(void)loadTopToolbar {
    topToolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    topToolbar.barStyle=UIBarStyleBlackTranslucent;
    UIBarButtonItem *backBarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonDidPressed:)];
    UIBarButtonItem *flexBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *actionBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionBarButtonDidPressed:)];
    NSArray *barButtonItemArray=[[NSArray alloc] initWithObjects:backBarButton,flexBarButton,actionBarButton, nil];
    topToolbar.items=barButtonItemArray;
    [self addSubview:topToolbar];
    [backBarButton release];[flexBarButton release];
    [actionBarButton release];[barButtonItemArray release];
}

-(void)loadFacebookButton {
    facebookButton=[UIButton buttonWithType:UIButtonTypeCustom];
    facebookButton.frame=CGRectMake(facebookButton_x, facebookButton_y, facebookButton_width, facebookButton_height);
    [facebookButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [facebookButton addTarget:self action:@selector(facebookButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:facebookButton];
}

- (void)loadSinaButton {
    sinaButton=[UIButton buttonWithType:UIButtonTypeCustom];
    sinaButton.frame=CGRectMake(sinaButton_x, sinaButton_y, sinaButton_width, sinaButton_height);
    [sinaButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [sinaButton addTarget:self action:@selector(sinaButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sinaButton];
}

- (void)loadEmailButton {
    emailButton=[UIButton buttonWithType:UIButtonTypeCustom];
    emailButton.frame=CGRectMake(emailButton_x, emailButton_y, emailButton_width, emailButton_height);
    [emailButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [emailButton addTarget:self action:@selector(emailButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:emailButton];
}

- (void)loadPlayButton {
    playButton=[UIButton buttonWithType:UIButtonTypeCustom];
    playButton.frame=CGRectMake(playButton_x, playButton_y, playButton_width, playButton_height);
    [playButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:playButton];
}

- (void)loadBottomView {
    UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, imageView_height, 320, 44)];
    bottomView.backgroundColor=[UIColor blackColor];
    [self addSubview:bottomView];
    [bottomView release];
    
    UIButton *forwardButton=[UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.frame=CGRectMake(forwardButton_x, forwardButton_y, forwardButton_width, forwardButton_height);
    [forwardButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(forwardButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:forwardButton];
    
    UIButton *backwardButton=[UIButton buttonWithType:UIButtonTypeCustom];
    backwardButton.frame=CGRectMake(backwardButton_x, backwardButton_y, backwardButton_width, backwardButton_height);
    [backwardButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [backwardButton addTarget:self action:@selector(backwardButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:backwardButton];
}
- (void)initUI {
    [self loadImageView];
    [self loadTextDescriptionView];
    [self loadTopToolbar];
    [self loadFacebookButton];
    [self loadSinaButton];
    [self loadEmailButton];
    [self loadPlayButton];
    [self loadBottomView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initUI];
    }
    return self;
}


#pragma mark-
#pragma mark-------UIButton Event-----------
- (void)facebookButtonDidPressed:(id)sender{
    if(self.delegate&&[delegate respondsToSelector:@selector(facebookButtonDidTapped:)])
        [delegate facebookButtonDidTapped:sender];
}

- (void)sinaButtonDidPressed:(id)sender {
    if(self.delegate&&[delegate respondsToSelector:@selector(sinaButtonDidTapped:)])
        [delegate sinaButtonDidTapped:sender];
}

- (void)emailButtonDidPressed:(id)sender {
    if(self.delegate&&[delegate respondsToSelector:@selector(emailButtonDidTapped:)])
        [delegate emailButtonDidTapped:sender];
}

- (void)playButtonDidPressed:(id)sender {
    if(self.delegate&&[delegate respondsToSelector:@selector(playButtonDidTapped:)])
        [delegate playButtonDidTapped:sender];
}

- (void)forwardButtonDidPressed:(id)sender {
    if(self.delegate&&[delegate respondsToSelector:@selector(forwardButtonDidTapped:)])
        [delegate forwardButtonDidTapped:sender];
}

- (void)backwardButtonDidPressed:(id)sender {
    if(self.delegate&&[delegate respondsToSelector:@selector(backBarButtonDidTapped:)])
        [delegate backwardButtonDidTapped:sender];
}


#pragma mark-
#pragma mark-------UIBarButton Event--------

- (void)backBarButtonDidPressed:(id)sender {
    if(self.delegate&&[delegate respondsToSelector:@selector(backBarButtonDidTapped:)])
        [delegate backBarButtonDidTapped:sender];
}

- (void)actionBarButtonDidPressed:(id)sender {
    if(self.delegate&&[delegate respondsToSelector:@selector(actionBarButtonDidTapped:)])
        [delegate actionBarButtonDidTapped:sender];
}



#pragma mark-
#pragma mark-------Memory manager-------

- (void)dealloc {
    [imageView release];
    [textDescriptionLabel release];
    [topToolbar release];
    [super dealloc];
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
