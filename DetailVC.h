//
//  DetailVC.h
//  HWforgeekHub3
//
//  Created by Roma on 27.10.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDPodcastItem;

@interface DetailVC : UIViewController <UITextViewDelegate>
{
    NSMutableDictionary *dict;
}

@property (nonatomic) CDPodcastItem *list;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UITextView *textViewDescription;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *playerLabel;

- (IBAction)player:(id)sender;

@end
