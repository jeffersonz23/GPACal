
//
//  GPACal_AddGPAItemViewController.m
//  GPACal
//
//  Created by Andrew Robinson on 4/19/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "GPACal_AddGPAItemViewController.h"

@interface GPACal_AddGPAItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *classField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *creditAmount;
@property (weak, nonatomic) IBOutlet UISlider *gradeSlider;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;

@property (nonatomic) int stepValue;
@property (nonatomic) int lastStep;

@end

@implementation GPACal_AddGPAItemViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender != self.doneButton) return;
    if (self.classField.text.length > 0) {
        self.GPAItem = [[GPACal_GPAItem alloc] init];
        
        // class name
        self.GPAItem.className = self.classField.text;
        
        // credit amount
        NSNumber *myNum = [NSNumber numberWithInteger:self.creditAmount.selectedSegmentIndex];
        self.GPAItem.credit = myNum;
        
        // Grade and GPA
        
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
    
    // Slider
    self.stepValue = 1.0f;
    self.lastStep = (self.gradeSlider.value) /self.stepValue;
    
    // Textfield keyboard hide
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChanged:(id)sender {
    
    // Used for slider "stepping"
    float newStep = roundf((_gradeSlider.value) / self.stepValue);
    self.gradeSlider.value = newStep * self.stepValue;
    
    // Grade Value change    
    if (self.gradeSlider.value == 0) {
        self.gradeLabel.text = @"A";
        
    } else if (self.gradeSlider.value == 1
               ) {
        self.gradeLabel.text = @"A-";
        
    } else if (self.gradeSlider.value == 2) {
        self.gradeLabel.text = @"B";
        
    } else if (self.gradeSlider.value == 3) {
        self.gradeLabel.text = @"B-";
        
    } else if (self.gradeSlider.value == 4) {
        self.gradeLabel.text = @"C";
        
    } else if (self.gradeSlider.value == 5) {
        self.gradeLabel.text = @"C-";
        
    } else if (self.gradeSlider.value == 6) {
        self.gradeLabel.text = @"D";
        
    } else if (self.gradeSlider.value == 7) {
        self.gradeLabel.text = @"D-";
        
    } else if (self.gradeSlider.value == 8) {
        self.gradeLabel.text = @"F";
    }
}

- (void)dismissKeyboard {
    [_classField resignFirstResponder];
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
