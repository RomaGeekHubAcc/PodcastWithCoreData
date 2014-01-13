//
//  DB.m
//  HWforgeekHub3
//
//  Created by Roma on 10.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "Defines.h"
#import "Podcast.h"


static FMDatabase *dataBase;

@implementation DBManager

- (id)init {
    self = [super init];
    if (self) {
        dbFileName = @"Player.sqlite";
        databasePath = [self getPathToDataBase];
        [self openDataBase];
        
    }
    return self;
}

- (void)openDataBase {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL dataBaseExist = [fileManager fileExistsAtPath:databasePath];
    if (!dataBaseExist) {
        NSString *defaultDatabasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbFileName];
        [fileManager copyItemAtPath:defaultDatabasePath toPath:databasePath error:nil];
    }
    dataBase = [FMDatabase databaseWithPath:databasePath];
    if (![dataBase open]) {
        dataBase = nil;
        NSLog(@"Error! Failed to open data base");
    }
}

- (void)closeDatabase {
    [dataBase close];
}

- (NSString*)getPathToDataBase {
    
    NSString *documentDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    return [documentDirectoryPath stringByAppendingPathComponent:dbFileName];
}

- (FMDatabase*)getDatabase {
    return dataBase;
}



@end
