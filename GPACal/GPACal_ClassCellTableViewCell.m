//
//  GPACal_ClassCellTableViewCell.m
//  GPACal
//
//  Created by Andrew Robinson on 4/20/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "GPACal_ClassCellTableViewCell.h"

@implementation GPACal_ClassCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
