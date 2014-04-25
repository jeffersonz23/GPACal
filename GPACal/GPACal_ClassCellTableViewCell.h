//
//  GPACal_ClassCellTableViewCell.h
//  GPACal
//
//  Created by Andrew Robinson on 4/20/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPACal_ClassCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *creditsGrade;
@property (weak, nonatomic) IBOutlet UILabel *GPA;
@property (weak, nonatomic) IBOutlet UILabel *className;

@end
