//
//  XMLReader.h
//  HWforgeekHub3
//
//  Created by Roma on 01.11.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PodcastItem.h"
@class Podcast;

@interface XMLReader : NSObject <NSXMLParserDelegate>
{
    int countTegsWithImage;
    int countTegsIm;
    BOOL flagAudioTrack;
    BOOL flagImage;
    BOOL flagPodcastMain;
    
    BOOL flagTitle;
    BOOL firstTitle;
    
    BOOL flagDescr;
    BOOL firstDescr;
    
    BOOL flagLink;
    
    BOOL flagMainImg;
    NSString *mainImgStr;
}

@property (nonatomic) Podcast *podcast;

@property (nonatomic) NSMutableArray *arrayWithContentLists;

@property (nonatomic, retain) NSString * currentElement;

@property (nonatomic) NSMutableString *currentTitle;
@property (nonatomic) NSMutableString *currentPubDate;
@property (nonatomic) NSMutableString *currentDescription;
@property (nonatomic) NSMutableString *currentImageStr;
@property (nonatomic) NSURL *currentURL;
@property (nonatomic) NSMutableArray *currentAudioTrackAr;
@property (nonatomic) NSMutableString *currentDuration;
@property (nonatomic) NSMutableString *currentAuthor;
@property (nonatomic) NSMutableString *currentLink;
@property (nonatomic) NSMutableString *currentGuid;


@property (nonatomic) NSMutableArray *arrayWithURLs;

-(void)parseXMLFileAtURL:(NSURL *)URL parseXMLFile:(NSData *)fileData parseError:(NSError **)error;
- (NSMutableArray*)parseXMLwithData:(NSData*)data;
- (NSMutableArray*)getArrayWithURLs;

@end
