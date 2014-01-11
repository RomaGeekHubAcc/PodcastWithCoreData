//
//  AddPodcastVC.h
//  HWforgeekHub3
//
//  Created by Roma on 02.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Podcast;
@class Downloader;

@interface AddPodcastVC : UIViewController <UITextFieldDelegate>
{
    Downloader *downloader;
    NSData *rssData;
    Podcast *toAddPodcast;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView
;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;


- (IBAction)search:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)addThisPokcast:(id)sender;

@end
