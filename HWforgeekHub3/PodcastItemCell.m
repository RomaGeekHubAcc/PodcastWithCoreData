//
//  MyCell.m
//  HWforgeekHub3
//
//  Created by Roma on 27.10.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import "PodcastItemCell.h"

@implementation PodcastItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
