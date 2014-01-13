//
//  DetailVC.m
//  HWforgeekHub3
//
//  Created by Roma on 27.10.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import "Defines.h"
#import "DetailVC.h"
#import "CDPodcastItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PodcastsPlayerVC.h"

@interface DetailVC ()

@end

@implementation DetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Podcast Title";
    
    _titleLabel.text = _list.itemTitle;
    _authorLabel.text = _list.itemAuthhor;
//    _updatedLabel.text = _list.itemPubDate;
    [_imageView setImageWithURL: [NSURL URLWithString:_list.itemImage]];
//    _list.image = _imageView.image;
    
    _textViewDescription.delegate = self;
    _textViewDescription.text = _list.itemDescription;
    
//    if (_list.audioFilePathArray.count > 1) {
//         NSLog(@"---height = %f",_scrollView.frame.size.height);
//        _scrollView.frame = CGRectMake(0,0,screenSize.size.width, screenSize.size.height+(labelPodcastHeight*_list.audioFilePathArray.count));
//        NSLog(@"---height = %f",_scrollView.frame.size.height);
//    }
    _scrollView.pagingEnabled = YES;
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, 800)];
//    [self createLabelsAndButtonsForDownload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Actions
- (IBAction)player:(id)sender {
    PodcastsPlayerVC *playerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PodcastsPlayerVC"];
    playerVC.podcastItem = _list;
    [self.navigationController pushViewController:playerVC animated:YES];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return NO;
}

#pragma mark - Custom

//- (void)createLabelsAndButtonsForDownload {
//    for (int i = 0; i < _list.audioFilePathArray.count; i++) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 432+(i*labelPodcastHeight), 150, 26)];
//        label.tag = i;
//        label.backgroundColor = [UIColor clearColor];
//        label.textColor=[UIColor blackColor];
//        label.numberOfLines=1;
//        label.text = [NSString stringWithFormat:@"Podcast %i", i+1 ];
//        [_scrollView addSubview:label];
//        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        button.tag = i;
//        [button addTarget:self
//                   action:@selector(downloadPodcast)
//                    forControlEvents:UIControlEventTouchDown];
//        [button setTitle:@"Download" forState:UIControlStateNormal];
//        button.frame = CGRectMake(180, 432+(i*labelPodcastHeight), 96, 26);
//        [_scrollView addSubview:button];
//    }
//}
//
//- (void)createFolderForDownloadAudio {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
//    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"MyNewFolder"];
//    NSError *error;
//    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
//        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
//        //Create folder if it doesn't already exist
//    }
//}

- (void)downloadPodcast {
#warning зробити можливо, щоб цей метод повертав BOOL (завантижився успішно чи ні)
}

@end
