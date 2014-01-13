//
//  List.h
//  HWGeekHub3
//
//  Created by Roma on 25.10.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PodcastItem : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSDate *pubDate;
@property (nonatomic) NSString *itemDescription;
@property (nonatomic) NSString *autor;
@property (nonatomic) NSString *imageStr;
@property (nonatomic) NSString *guid;
@property (nonatomic) NSMutableArray *audioFilePathArray;
@property (nonatomic) NSString *durationPodcast;
@property (nonatomic) NSURL *urlOfImage;
@property (nonatomic) UIImage *image;

- (id)init;

@end
