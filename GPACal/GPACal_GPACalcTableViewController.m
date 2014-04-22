//
//  GPACal_GPACalcTableViewController.m
//  GPACal
//
//  Created by Andrew Robinson on 4/19/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "GPACal_GPACalcTableViewController.h"
#import "GPACal_GPAItem.h"
#import "GPACal_AddGPAItemViewController.h"
#import "GPACal_ClassCellTableViewCell.h"

@interface GPACal_GPACalcTableViewController ()

@property NSMutableArray *GPAItemName;

@end

@implementation GPACal_GPACalcTableViewController

- (void)loadInitialData {
    GPACal_GPAItem *item1 = [[GPACal_GPAItem alloc] init];
    item1.className = @"Testing";
    item1.grade = [NSNumber numberWithFloat:3.14];
    [self.GPAItemName addObject:item1];
    
    GPACal_GPAItem *item2 = [[GPACal_GPAItem alloc] init];
    item2.className = @"Testing2";
    item2.grade = [NSNumber numberWithFloat:3.33];
    [self.GPAItemName addObject:item2];
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    
    GPACal_AddGPAItemViewController *source = [segue sourceViewController];
    GPACal_GPAItem *item = source.GPAItem;
    if (item != nil) {
        [self.GPAItemName addObject:item];
//        [self.GPAItemNum addObject:item];
        [self.tableView reloadData];
    }
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.GPAItemName = [[NSMutableArray alloc] init];
//    self.GPAItemNum = [[NSMutableArray alloc] init];
    [self loadInitialData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.GPAItemName count];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        cell.backgroundColor = altCellColor;
    }
}



- (GPACal_ClassCellTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ClassCell";
    GPACal_ClassCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    GPACal_GPAItem *GPAItem = [self.GPAItemName objectAtIndex:indexPath.row];
//    GPACal_GPAItem *GPASubItem = [self.GPAItemNum objectAtIndex:indexPath.row];
    
    cell.className.text = GPAItem.className;
    cell.creditsGrade.text = [NSString stringWithFormat:@"%@ - %@", GPAItem.credit, GPAItem.grade];
    cell.GPA.text = [NSString stringWithFormat:@"%.2f", [GPAItem.grade floatValue]];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
