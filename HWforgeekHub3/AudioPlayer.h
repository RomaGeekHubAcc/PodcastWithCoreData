//
//  AudioPlayer.h
//  HWforgeekHub3
//
//  Created by Roma on 18.11.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioPlayer : NSObject

+ (void)playAudioTrackWithName:(NSString*)trackName;
+ (void)stop;
+ (BOOL)isPlaying;
+ (NSString*)trackNamePlaying;
+ (void)setVolume:(float)vol;
+ (float)getVolume;
+ (void)pause;
+ (NSTimeInterval)pausedTime;
+ (void)playAudioTrackWithName:(NSString*)trackName atTime:(NSTimeInterval)currenTime;

@end
