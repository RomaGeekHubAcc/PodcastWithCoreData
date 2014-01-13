//
//  AudioPlayer.m
//  HWforgeekHub3
//
//  Created by Roma on 18.11.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import "AudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

static AVAudioPlayer*avPlayer;
static NSString *playingTrackName;

@implementation AudioPlayer

+ (void)playAudioTrackWithName:(NSString*)trackName {
    playingTrackName = trackName;
    trackName = [[NSBundle mainBundle] pathForResource:trackName ofType:@"mp3"];
    avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:trackName] error:NULL];
    [self setVolume:[self getVolume]];
    [avPlayer setNumberOfLoops:1];
    [avPlayer play];
}

+ (void)playAudioTrackWithName:(NSString*)trackName
                        atTime:(NSTimeInterval)currenTime {
    playingTrackName = trackName;
    trackName = [[NSBundle mainBundle] pathForResource:trackName ofType:@"mp3"];
    avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:trackName] error:NULL];
    [self setVolume:[self getVolume]];
    [avPlayer prepareToPlay];
    [avPlayer playAtTime:currenTime];

}

+ (void)stop {
    [avPlayer stop];
    avPlayer = nil;
}

+ (void)pause {
    [avPlayer pause];
}

+ (NSTimeInterval)pausedTime {
    return avPlayer.deviceCurrentTime;
}

+ (BOOL)isPlaying {
    return avPlayer.isPlaying ? YES : NO;
}

+ (NSString*)trackNamePlaying {
    if ([self isPlaying]) {
        return playingTrackName;
    }
    return 0;
}

+ (void)setVolume:(float)vol {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:vol] forKey:@"MusicVolume"];
    [avPlayer setVolume:vol];
}

+ (float)getVolume {
    NSNumber *num = [[NSUserDefaults standardUserDefaults] objectForKey:@"MusicVolume"];
    return num ? num.floatValue: 0.5;
}

@end
