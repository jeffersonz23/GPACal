//
//  GPACal_AddGPAItemViewController.m
//  GPACal
//
//  Created by Andrew Robinson on 4/19/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "GPACal_AddGPAItemViewController.h"

@interface GPACal_AddGPAItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *numField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation GPACal_AddGPAItemViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (sender != self.doneButton) return;
    if ((self.textField.text.length > 0) && (self.numField.text.length > 0)) {
        self.GPAItem = [[GPACal_GPAItem alloc] init];
        //if (self.numField.text > 0) {
        
        // Changed GPAItem class so it won't work anymore
//        self.GPAItem.itemName = self.textField.text;
//        self.GPAItem.completed = NO;
        
        self.GPAItem.className = self.textField.text;
        // Add other controls to get this working in addItem view
        //self.GPAItem.credit
        self.GPAItem.grade = [NSNumber numberWithFloat:[self.numField.text floatValue]];
        //}
    }
}

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
