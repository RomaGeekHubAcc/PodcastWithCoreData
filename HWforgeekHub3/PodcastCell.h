//
//  PodcastCell.h
//  HWforgeekHub3
//
//  Created by Roma on 13.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PodcastCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewPodcast;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelPodcastLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionPodcastLabel;

@end
