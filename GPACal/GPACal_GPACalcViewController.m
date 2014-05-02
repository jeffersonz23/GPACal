//
//  GPACal_GPACalcTableViewController.m
//  GPACal
//
//  Created by Andrew Robinson on 4/19/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "GPACal_GPACalcViewController.h"
#import "GPACal_GPAItem.h"
#import "GPACal_AddGPAItemViewController.h"
#import "GPACal_ClassCellTableViewCell.h"
#import "GPACal_AboutViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface GPACal_GPACalcViewController ()

@property NSMutableArray *nameClass;
@property NSMutableArray *credits;
@property NSMutableArray *gpa;
@property NSMutableArray *grade;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *noData;
@property (strong, nonatomic) UILabel *addItemView;
@property (weak, nonatomic) IBOutlet UITableView *tableMain;

@end

@implementation GPACal_GPACalcViewController

- (void)loadInitialData {
    // Getting previous data
    NSMutableArray *array = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"nameClass"] mutableCopy];
    NSMutableArray *array2 = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"credits"] mutableCopy];
    NSMutableArray *array3 = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"grade"] mutableCopy];
    NSMutableArray *array4 = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"gpa"] mutableCopy];
    
    if (array && array2 && array3 && array4) {
        for( int i = 0; i < [array count]; i++) {
            [self.nameClass addObject:[array objectAtIndex:i]];
            [self.credits addObject:[array2 objectAtIndex:i]];
            [self.grade addObject:[array3 objectAtIndex:i]];
            [self.gpa addObject:[array4 objectAtIndex:i]];
        }
    }
    
//    GPACal_GPAItem *item1 = [[GPACal_GPAItem alloc] init];
//    item1.className = @"Testing";
//    item1.grade = @"3.14";
//    item1.credit = [NSNumber numberWithInteger:1];
//    [self.GPAItemName addObject:item1];
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    
    GPACal_AddGPAItemViewController *source = [segue sourceViewController];
    GPACal_GPAItem *item = source.GPAItem;
    if (item != nil) {
        [self.credits addObject:item.credit];
        [self.nameClass addObject:item.className];
        [self.gpa addObject:item.gpa];
        [self.grade addObject:item.grade];
        
        // Saving user defaults
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.nameClass forKey:@"nameClass"];
        [userDefaults setObject:self.credits forKey:@"credits"];
        [userDefaults setObject:self.grade forKey:@"grade"];
        [userDefaults setObject:self.gpa forKey:@"gpa"];
        [userDefaults synchronize];
        
        [self.tableView reloadData];
        [self.addItemView removeFromSuperview];
    } else {
        NSLog(@"Unwound.");
    }
    [super setEditing:NO animated:NO];
    [self.tableView setEditing:NO animated:NO];
    [self.tableView reloadData];
    [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Color change
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x4A4A4A);
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x4A4A4A);
    self.navigationController.navigationBar.translucent = NO;
    
    self.credits = [[NSMutableArray alloc] init];
    self.nameClass = [[NSMutableArray alloc] init];
    self.gpa = [[NSMutableArray alloc] init];
    self.grade = [[NSMutableArray alloc] init];
    [self loadInitialData];
    
    if ([self.nameClass count] != 0) {
        NSLog(@"Cell not showing...");
        self.tableView.separatorColor = UIColorFromRGB(0x2B2B2B);
        [self.addItemView removeFromSuperview];
    } else {
        
        [CATransaction setCompletionBlock: ^{
            NSLog(@"Cell showing...");
            
            self.addItemView = [[UILabel alloc] initWithFrame:CGRectMake( self.tableView.frame.size.width, self.tableView.frame.size.height/2, self.tableView.frame.size.width, 50.0f)]; //notice this is ON screen!
            self.addItemView.text = @"Click the + to add courses!";
            self.addItemView.font = [UIFont systemFontOfSize:24.0f];
            self.addItemView.textColor = UIColorFromRGB(0x34AADC);
            self.addItemView.textAlignment = NSTextAlignmentCenter;
            
            [UIView transitionWithView:self.view duration:0.5
                               options:UIViewAnimationOptionCurveLinear //change to whatever animation you like
                            animations:^ {
                                self.tableView.separatorColor = UIColorFromRGB(0x4A4A4A);
                                self.addItemView.frame = CGRectMake( 0.0f, self.tableView.frame.size.height/2, self.tableView.frame.size.width, 50.0f); //notice this is ON screen!
                                [self.view addSubview:self.addItemView];
                            }
                            completion:nil];
            
            [self.view addSubview:self.addItemView];
        }];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    CGFloat gpa = 0;
    int total_credits = 0;

    for( int i = 0; i < [self.nameClass count]; i++) {
        gpa += [[self.gpa objectAtIndex:i] floatValue] * [[self.credits objectAtIndex:i] integerValue];
        total_credits += [[self.credits objectAtIndex:i] integerValue];
    }
    
    if ([self.nameClass count]) {
        self.gradeLabel.text = [NSString stringWithFormat:@"GPA: %.2f", gpa / total_credits];
    } else {
        self.gradeLabel.text = @"GPA: ----";
    }
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
    return [self.nameClass count];
}

- (GPACal_ClassCellTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ClassCell";
    GPACal_ClassCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    GPACal_GPAItem *GPAItem = [[GPACal_GPAItem alloc] init];
    GPAItem.className = [self.nameClass objectAtIndex:indexPath.row];
    GPAItem.credit = [self.credits objectAtIndex:indexPath.row];
    GPAItem.grade = [self.grade objectAtIndex:indexPath.row];
    GPAItem.gpa = [self.gpa objectAtIndex:indexPath.row];
    
    cell.className.text = GPAItem.className;
    cell.creditsGrade.text = [NSString stringWithFormat:@"Credits: %@ Grade: %@", GPAItem.credit, GPAItem.grade];
    cell.GPA.text = [NSString stringWithFormat:@"%.2f", [GPAItem.gpa floatValue]];
    
    // Configure the cell...
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


// Removing tableview entry with swipe button
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [CATransaction begin];
        [tableView beginUpdates];
        
        // Removing from user defaults
        [self.nameClass removeObjectAtIndex:indexPath.row];
        [self.credits removeObjectAtIndex:indexPath.row];
        [self.grade removeObjectAtIndex:indexPath.row];
        [self.gpa removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"nameClass"];
        [userDefaults removeObjectForKey:@"credits"];
        [userDefaults removeObjectForKey:@"grade"];
        [userDefaults removeObjectForKey:@"gpa"];
        
        // Hide table and animate instruction
        if ([self.nameClass count] != 0) {
            NSLog(@"Cell not showing...");
            self.tableView.separatorColor = UIColorFromRGB(0x2B2B2B);
            [self.addItemView removeFromSuperview];
        } else {
            
            [CATransaction setCompletionBlock: ^{
                NSLog(@"Cell showing...");
                
                self.addItemView = [[UILabel alloc] initWithFrame:CGRectMake( self.tableView.frame.size.width, self.tableView.frame.size.height/2, self.tableView.frame.size.width, 50.0f)]; //notice this is ON screen!
                self.addItemView.text = @"Click the + to add courses!";
                self.addItemView.font = [UIFont systemFontOfSize:24.0f];
                self.addItemView.textColor = UIColorFromRGB(0x34AADC);
                self.addItemView.textAlignment = NSTextAlignmentCenter;
                
                [UIView transitionWithView:self.view duration:0.5
                                   options:UIViewAnimationOptionCurveLinear //change to whatever animation you like
                                animations:^ {
                                    self.tableView.separatorColor = UIColorFromRGB(0x4A4A4A);
                                    self.addItemView.frame = CGRectMake( 0.0f, self.tableView.frame.size.height/2, self.tableView.frame.size.width, 50.0f); //notice this is ON screen!
                                    [self.view addSubview:self.addItemView];
                                }
                                completion:nil];
                
                [self.view addSubview:self.addItemView];
            }];
        }
        
        // Recaculate GPA
        CGFloat gpa = 0;
        int total_credits = 0;
        
        for( int i = 0; i < [self.nameClass count]; i++) {
            gpa += [[self.gpa objectAtIndex:i] floatValue] * [[self.credits objectAtIndex:i] integerValue];
            total_credits += [[self.credits objectAtIndex:i] integerValue];
        }
        if ([self.nameClass count]) {
            self.gradeLabel.text = [NSString stringWithFormat:@"GPA: %.2f", gpa / total_credits];
        } else {
            self.gradeLabel.text = @"GPA: ----";
        }

        [tableView endUpdates];
        
        [CATransaction commit];
    }
}

- (IBAction)startEditing:(id)sender {
    
    if (self.editing || [self.nameClass count] == 0)
	{
		[super setEditing:NO animated:NO];
		[self.tableView setEditing:NO animated:NO];
		[self.tableView reloadData];
		[self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
	}
	else
	{
		[super setEditing:YES animated:YES];
		[self.tableView setEditing:YES animated:YES];
		[self.tableView reloadData];
		[self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
	}
    
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSString *stringToMove = self.nameClass[sourceIndexPath.row];
    [self.nameClass removeObjectAtIndex:sourceIndexPath.row];
    [self.nameClass insertObject:stringToMove atIndex:destinationIndexPath.row];
    
    NSString *stringToMove2 = self.credits[sourceIndexPath.row];
    [self.credits removeObjectAtIndex:sourceIndexPath.row];
    [self.credits insertObject:stringToMove2 atIndex:destinationIndexPath.row];
    
    NSString *stringToMove3 = self.grade[sourceIndexPath.row];
    [self.grade removeObjectAtIndex:sourceIndexPath.row];
    [self.grade insertObject:stringToMove3 atIndex:destinationIndexPath.row];
    
    NSString *stringToMove4 = self.gpa[sourceIndexPath.row];
    [self.gpa removeObjectAtIndex:sourceIndexPath.row];
    [self.gpa insertObject:stringToMove4 atIndex:destinationIndexPath.row];
}

@end
