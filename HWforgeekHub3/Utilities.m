//
//  Utilities.m
//  HWforgeekHub3
//
//  Created by comonitos on 1/11/14.
//  Copyright (c) 2014 Roma. All rights reserved.
//



#import "Utilities.h"

@implementation Utilities

+ (NSDateFormatter*)sharedDF {
    static NSDateFormatter *__dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __dateFormatter = [[NSDateFormatter alloc]init];
    });
    return __dateFormatter;
}

+ (NSDate*)dateFromString:(NSString*)string withFormat:(NSString*)format {
    [[Utilities sharedDF] setDateFormat:format];
    return [[Utilities sharedDF] dateFromString:string];
}

+ (NSString*)stringFromDate:(NSDate*)date withFormat:(NSString*)format {
    [[Utilities sharedDF] setDateFormat:format];
    return [[Utilities sharedDF] stringFromDate:date];
}

+ (NSString*)humanReadableFromDate:(NSDate*)date {
    NSTimeInterval timeInterval = [date timeIntervalSinceNow];
    int days = timeInterval / (3600 * 24);
    days = abs(days);
    return [NSString stringWithFormat:@"%i days ago", days];
}
@end
