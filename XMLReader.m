//
//  XMLReader.m
//  HWforgeekHub3
//
//  Created by Roma on 01.11.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//


#import "Defines.h"
#import "XMLReader.h"
#import "PodcastItem.h"
#import "Podcast.h"
#import "Utilities.h"

@implementation XMLReader

- (id)init {
    self = [super init];
    if (self) {
        _podcast = [[Podcast alloc]init];
        countTegsIm = 0;
        countTegsWithImage = 0;
        _arrayWithContentLists = [[NSMutableArray alloc]init];
        flagPodcastMain = NO;
        flagMainImg = NO;
        flagDescr = NO;
        firstDescr = YES;
        flagTitle = NO;
        firstTitle = YES;
        flagLink = NO;
    }
    return self;
}

- (void)parseXMLFileAtURL:(NSURL *)URL parseXMLFile:(NSData *)fileData parseError:(NSError **)error
{
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];

	[parser setDelegate:self];

	[parser parse];
	
	NSError *parserError = [parser parserError];
	if(parserError && error)
	{
		*error = parserError;
	}
}

- (Podcast*)parseXMLwithData:(NSData*)data {
    if (!_arrayWithURLs) {
        _arrayWithURLs = [[NSMutableArray alloc]init];
    }
    else [_arrayWithURLs removeAllObjects];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    
    [parser parse];

    _podcast.arrayPodcastItems = [NSMutableArray arrayWithArray:_arrayWithContentLists];
    if (_podcast.arrayPodcastItems.count) {
        PodcastItem *item = [_podcast.arrayPodcastItems objectAtIndex:0];
        _podcast.podcastTitle = item.title;
        _podcast.podcastImage = mainImgStr;
        _podcast.podcastDescription = item.itemDescription;
        _podcast.link = _currentLink;
        
        [_podcast.arrayPodcastItems removeObjectAtIndex:0];
    }
    
    return _podcast;
}

- (NSMutableArray*)getArrayWithURLs {
    return _arrayWithURLs;
}

#pragma mark - Parsing

- (void)parser:(NSXMLParser *)parser
            didStartElement:(NSString *)elementName
            namespaceURI:(NSString *)namespaceURI
            qualifiedName:(NSString *)qualifiedName
            attributes:(NSDictionary *)attributeDict  {
    
    _currentElement = elementName;
    if ([elementName isEqualToString:PODCAST_ICON_] && !flagImage) {
        flagImage = YES;
        _currentImageStr = [attributeDict objectForKey:@"href"];
    }
    if ([elementName isEqual:AUDIO_TRACK_] && !flagAudioTrack)
    {
        if (!_currentAudioTrackAr) _currentAudioTrackAr = [[NSMutableArray alloc]init];
        flagAudioTrack = YES;
        [_currentAudioTrackAr addObject:[attributeDict objectForKey:@"url"]];
    }
    if ([elementName isEqualToString:IMAGE_] && !flagImage) {
        flagImage = YES;
        _currentImageStr = [attributeDict objectForKey:@"href"];
    }
    flagAudioTrack = NO;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([_currentElement isEqualToString:LINK_] && !flagLink) {
        flagLink = YES;
        if (!_currentLink) {
            _currentLink = [[NSMutableString alloc]init];
        }
        [_currentLink appendString:string];
    }
    if ([_currentElement isEqualToString:GUID_]) {
        if (!_currentGuid) {
            _currentGuid = [[NSMutableString alloc]init];
        }
        [_currentGuid appendString:string];
    }
    if ([_currentElement isEqualToString:TITLE_]) {
        if (!_currentTitle) {
            _currentTitle = [[NSMutableString alloc]init];
        }
        if (!flagTitle) {
            [_currentTitle appendString:string];
            flagTitle  = YES;
        }
        else {
            if (!firstTitle){
                [_currentTitle appendString:string];
            }
        }
	}
    else if ([_currentElement isEqualToString:PUBDATE_]) {
        if (!_currentPubDate) {
            _currentPubDate = [[NSMutableString alloc]init];
        }
        
        NSRange range = [string rangeOfString:@"\n"];
        
        if (range.location == 0) {
            return;
        }
		[_currentPubDate appendString:string];
    }
    else if ([_currentElement isEqualToString:DESCRIPTION_]) {
        if (!_currentDescription) {
            _currentDescription = [[NSMutableString alloc]init];
        }
        if (!flagDescr) {
            [_currentDescription appendString:string];
            flagDescr = YES;
        }
        else {
            if (!firstDescr) {
                [_currentDescription appendString:string];
            }
        }
    
    }
    else if ([_currentElement isEqualToString:AUTHOR_]) {
        if (!_currentAuthor) {
            _currentAuthor = [[NSMutableString alloc]init];
        }
        [_currentAuthor appendString:string];
    }
    else if ([_currentElement isEqualToString:DURATION_]) {
        if (!_currentDuration) {
            _currentDuration = [[NSMutableString alloc]init];
        }
        [_currentDuration appendString:string];
    }
    else if ([_currentElement isEqualToString:@"url"] && !flagMainImg) {
        if (!_currentImageStr) {
            mainImgStr = string;
            flagMainImg = YES;
        }
    }
}

- (void)parser:(NSXMLParser *)parser
                didEndElement:(NSString *)elementName
                namespaceURI:(NSString *)namespaceURI
                qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:ITEM_]) {
        
        firstTitle = NO;
        firstDescr = NO;
        
        PodcastItem *contentList = [[PodcastItem alloc]init];
        
        contentList.title = _currentTitle;
        
        NSString *format = @"ccc, d MMM yyyy H:m:s zzz";
        
        
        NSLog(@"pub date -> %@",_currentPubDate);
        // Thu, 12 Sep 2013 12:51:00 GMT
        NSDate *date = [Utilities dateFromString:_currentPubDate withFormat:format];
        NSLog(@"---Date -> %@", date);
        contentList.pubDate = date;
        
        contentList.itemDescription = _currentDescription;
        contentList.imageStr = _currentImageStr;
        contentList.urlOfImage = _currentURL;
        contentList.durationPodcast = _currentDuration;
        contentList.audioFilePathArray = _currentAudioTrackAr;
        contentList.autor = _currentAuthor;
        contentList.guid = _currentGuid;
        
        if (!_arrayWithContentLists) {
            _arrayWithContentLists = [[NSMutableArray alloc]init];
        }
        [_arrayWithContentLists addObject:contentList];

        _currentElement = nil;
        _currentImageStr = nil;
        _currentTitle = nil;
        _currentDescription = nil;
        _currentPubDate = nil;
        _currentURL = nil;
        _currentDuration = nil;
        _currentAudioTrackAr = nil;
        _currentGuid = nil;
        
        flagAudioTrack = NO;
        flagImage = NO;
    }
}

@end
