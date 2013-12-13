//
//  SettingViewController.m
//  PreciousMoments
//
//  Created by LingYun on 12-9-28.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadMyTableView {
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 390) style:UITableViewStyleGrouped];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadMyTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark--
#pragma mark--------UITableViewDataSource-------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0)
        return 5;
    else
        return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"CellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    }
    
    if(indexPath.section==0){
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *leftLabel=[[UILabel alloc] initWithFrame:CGRectMake(8, 8, 100, 28)];
        leftLabel.backgroundColor=[UIColor clearColor];
        leftLabel.textColor=[UIColor blackColor];
        [[cell contentView] addSubview:leftLabel];
        [leftLabel release];
        
        UILabel *rightLabel=[[UILabel alloc] initWithFrame:CGRectMake(200, 8, 100, 28)];
        rightLabel.backgroundColor=[UIColor clearColor];
        rightLabel.textColor=[UIColor blueColor];
        [[cell contentView] addSubview:rightLabel];
        [rightLabel release];
        
        switch (indexPath.row) {
            case 0:
                leftLabel.text=@"平日提醒";
                break;
            case 1:
                leftLabel.text=@"存储备份";
                break;
            case 2:
                leftLabel.text=@"相册名称";
                break;
            case 3:
                leftLabel.text=@"Facebook";
                break;
            case 4:
                leftLabel.text=@"新浪微博";
                break;
        }
    }
    else {
        UILabel *leftLabel=[[UILabel alloc] initWithFrame:CGRectMake(2, 8, 300, 28)];
        leftLabel.backgroundColor=[UIColor clearColor];
        leftLabel.textColor=[UIColor blackColor];
//        leftLabel.textAlignment=NSTextAlignmentCenter;
        [[cell contentView] addSubview:leftLabel];
        [leftLabel release];
        
        switch (indexPath.row) {
            case 0:
                leftLabel.text=@"退出";
                break;
            case 1:
                leftLabel.text=@"注册";
                break;
        }
    }
    
    return  cell;
}

@end
