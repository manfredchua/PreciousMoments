//
//  DatabaseOperator.m
//  PreciousMoments
//
//  Created by FOX on 12-10-9.
//  Copyright (c) 2012年 LingYun. All rights reserved.
//

#import "DatabaseOperator.h"

static DatabaseOperator *dbOperator=nil;


@implementation DatabaseOperator

+(DatabaseOperator *)shareDatabaseOperator {
    @synchronized(self){
        if(dbOperator==nil){
            dbOperator=[[DatabaseOperator alloc] init];
        }
    }
    return dbOperator;
}


-(void)openDBAndCreateTable{
    sqlite3 *database=nil;
    //---create database---
	if(sqlite3_open([[GlobalDefine createDBAtHomeDirectoryAndReturnPath] UTF8String], &database)!= SQLITE_OK){
		sqlite3_close(database);
		NSAssert(0,@"Database failed to open.");
	}
    
    //---create table and field---
	char *err;
    const char *createTable = "CREATE TABLE IF NOT EXISTS ImageInformation"
    "( imageFileName           TEXT PRIMARY KEY, "
    "  viewTag       TEXT NOT NULL, "
    "  imageAlbumName       TEXT NOT NULL, "
    "  imagePath         TEXT NOT NULL, "
    "  audioPathOfImage     TEXT NOT NULL, "
    "  currentMonth       TEXT NOT NULL, "
    "  imageTextDescription  TEXT NOT NULL)";
	if(sqlite3_exec(database,createTable,NULL,NULL,&err)!=SQLITE_OK)
	{
        NSLog(@"error:%@",[NSString stringWithUTF8String:err]);
		NSAssert(0,@"Tabled failed to create!");
	}
    sqlite3_close(database);
}

-(BOOL)insertIntoTableWithImageInformation:(ImageInformation *)imageInfo {
    sqlite3 *database=nil;
//    sqlite3_stmt *stmt=nil;
    //---insert a record---
    NSString *insertSQL=[NSString stringWithFormat:@"INSERT INTO '%@' VALUES('%@','%@','%@','%@','%@','%@','%@')",TableName,imageInfo.imageFileName,imageInfo.viewTag,imageInfo.imageAlbumName,imageInfo.imagePath,imageInfo.audioPathOfImage,imageInfo.currentMonth,imageInfo.imageTextDescription];
    char *err;
    if(sqlite3_open([[GlobalDefine createDBAtHomeDirectoryAndReturnPath] UTF8String], &database)==SQLITE_OK){
        if(sqlite3_exec(database, [insertSQL UTF8String], NULL, NULL, &err)!=SQLITE_OK)
        {
            NSLog(@"error:%@",[NSString stringWithUTF8String:err]);
            return NO;
        }
        sqlite3_close(database);
    }
    return YES;
}

-(NSMutableArray *)selectAllImageInformationWithViewTagFromTable:(NSString *)viewTag
{
    sqlite3 *database=nil;
    sqlite3_stmt *stmt;
	NSMutableArray *imageInfoArray=[[NSMutableArray alloc] init];
	NSString *selectSQL=[NSString stringWithFormat:@"SELECT * FROM ImageInformation WHERE viewTag='%@'",viewTag];
    if(sqlite3_open([[GlobalDefine createDBAtHomeDirectoryAndReturnPath] UTF8String], &database)==SQLITE_OK) {
        if((sqlite3_prepare_v2(database,[selectSQL UTF8String],-1,&stmt,nil)==SQLITE_OK)){
            while((sqlite3_step(stmt)==SQLITE_ROW)){
                ImageInformation *imageInfo=[[ImageInformation alloc] init];
                imageInfo.imageFileName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt,0)];
                imageInfo.viewTag=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
                imageInfo.imageAlbumName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
                imageInfo.imagePath=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
                imageInfo.audioPathOfImage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
                imageInfo.currentMonth=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
                imageInfo.imageTextDescription=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
                [imageInfoArray addObject:imageInfo];
                [imageInfo release];
            }
            sqlite3_finalize(stmt);
        }
    }
    sqlite3_close(database);
    return [imageInfoArray autorelease];
}
              

-(ImageInformation *)selectImageInformationFromTableWithFileName:(NSString *)fileName{
    sqlite3 *database=nil;
    sqlite3_stmt *stmt=nil;
    //---select fileName record---
    ImageInformation *imageInfo=[[ImageInformation alloc] init];
    NSString *selectSQL=[NSString stringWithFormat:@"SELECT * FROM '%@' WHERE imageFileName='%@'",TableName,fileName];
    if(sqlite3_open([[GlobalDefine createDBAtHomeDirectoryAndReturnPath] UTF8String], &database)==SQLITE_OK) {
        if(sqlite3_prepare_v2(database, [selectSQL UTF8String], -1, &stmt, nil)==SQLITE_OK){
            while (sqlite3_step(stmt)==SQLITE_ROW) {
                imageInfo.imageFileName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
                imageInfo.viewTag=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
                imageInfo.imageAlbumName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
                imageInfo.imagePath=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
                imageInfo.audioPathOfImage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
                imageInfo.currentMonth=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
                imageInfo.imageTextDescription=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
            }
            sqlite3_finalize(stmt);
        }
        else{
            [imageInfo release];
            return nil;
        }
        sqlite3_close(database);
    }
    return [imageInfo autorelease];
}


-(void)updateTableWithAlbumName:(NSString *)albumName andNewAlbumName:(NSString *)newAlbumName{
    sqlite3_stmt *stmt=nil;
    sqlite3 *database=nil;
    //---update imageAlbumName with newAlbumName---
    NSString *updateSQL=[NSString stringWithFormat:@"UPDATE ImageInformation SET imageAlbumName='%@' WHERE imageAlbumName='%@'",newAlbumName,albumName];
    if(sqlite3_open([[GlobalDefine createDBAtHomeDirectoryAndReturnPath] UTF8String], &database)==SQLITE_OK) {
        if(sqlite3_prepare_v2(database, [updateSQL UTF8String], -1, &stmt, nil)==SQLITE_OK){
            while (sqlite3_step(stmt)==SQLITE_ROW) {
                NSLog(@"Update table...");
            }
            sqlite3_finalize(stmt);
        }
    }
    sqlite3_close(database);
}



@end
