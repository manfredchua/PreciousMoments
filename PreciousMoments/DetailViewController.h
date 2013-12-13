//
//  DetailViewController.h
//  PreciousMoments
//
//  Created by FOX on 12-10-10.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"
#import "WBEngine.h"

@interface DetailViewController : UIViewController<DetailViewDelegate,WBEngineDelegate>
{
    NSString *fileName;
    DetailView *detailView;
    
    WBEngine *weiboEngine;
    
    ImageInformation *imageInfo;
}
@property(nonatomic,retain)NSString *fileName;
@property(nonatomic,retain)WBEngine *weiboEngine;
@end
