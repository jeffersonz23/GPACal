//
//  GPACal_GPACalcTableViewController.h
//  GPACal
//
//  Created by Andrew Robinson on 4/19/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPACal_GPACalcViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

- (IBAction)startEditing:(id)sender;


@end
