//
//  Utilities.h
//  HWforgeekHub3
//
//  Created by comonitos on 1/11/14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+ (NSDate*)dateFromString:(NSString*)string withFormat:(NSString*)format;
+ (NSString*)stringFromDate:(NSDate*)date withFormat:(NSString*)format;
+ (NSString*)humanReadableFromDate:(NSDate*)date;
@end
