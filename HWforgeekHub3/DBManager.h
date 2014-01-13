//
//  DB.h
//  HWforgeekHub3
//
//  Created by Roma on 10.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;

@interface DBManager : NSObject
{
    NSString *dbFileName;
    NSString *databasePath;
}

- (FMDatabase*)getDatabase;

@end
