//
//  DatabaseOperator.h
//  PreciousMoments
//
//  Created by FOX on 12-10-9.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "ImageInformation.h"

@interface DatabaseOperator : NSObject
{
    
}

+(DatabaseOperator *)shareDatabaseOperator;


-(void)openDBAndCreateTable;

-(BOOL)insertIntoTableWithImageInformation:(ImageInformation *)imageInfo;

-(ImageInformation *)selectImageInformationFromTableWithFileName:(NSString *)fileName;

-(NSMutableArray *)selectAllImageInformationWithViewTagFromTable:(NSString *)viewTag;

-(void)updateTableWithAlbumName:(NSString *)albumName andNewAlbumName:(NSString *)newAlbumName;
@end
