
//
//  GPACal_AddGPAItemViewController.m
//  GPACal
//
//  Created by Andrew Robinson on 4/19/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "GPACal_AddGPAItemViewController.h"
#import "Flurry.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (sender != self.doneButton) return YES;
    if (self.classField.text.length > 0) {
        
        self.GPAItem = [[GPACal_GPAItem alloc] init];
        
        // class name
        self.GPAItem.className = self.classField.text;
        
        // credit amount
        NSNumber *myNum = [NSNumber numberWithInteger:self.creditAmount.selectedSegmentIndex + 1];
        self.GPAItem.credit = myNum;
        
        // Grade and GPA
        self.GPAItem.grade = self.gradeLabel.text;
        if ([self.gradeLabel.text isEqual: @"A"]) {
            self.GPAItem.gpa = [NSNumber numberWithDouble:4.00];
            
        } else if ([self.gradeLabel.text isEqual:@"A-"]) {
            self.GPAItem.gpa = [NSNumber numberWithDouble:3.75];
            
        } else if ([self.gradeLabel.text isEqual:@"B+"]) {
            self.GPAItem.gpa = [NSNumber numberWithDouble:3.25];
            
        } else if ([self.gradeLabel.text isEqual:@"B"]) {
            self.GPAItem.gpa = [NSNumber numberWithDouble:3.0];
            
        } else if ([self.gradeLabel.text isEqual:@"B-"]) {
            self.GPAItem.gpa = [NSNumber numberWithDouble:2.75];
            
        } else if ([self.gradeLabel.text isEqual:@"C+"]) {
            self.GPAItem.gpa = [NSNumber numberWithDouble:2.25];
            
        } else if ([self.gradeLabel.text isEqual:@"C"]) {
            self.GPAItem.gpa = [NSNumber numberWithDouble:2.0];
            
        } else if ([self.gradeLabel.text isEqual:@"C-"]) {
            self.GPAItem.gpa = [NSNumber numberWithDouble:1.75];
            
        } else if ([self.gradeLabel.text isEqual:@"D+"]) {
            self.GPAItem.gpa = [NSNumber numberWithDouble:1.5];
            
        } else if ([self.gradeLabel.text isEqual:@"D"]) {
            self.GPAItem.gpa = [NSNumber numberWithDouble:1.0];
            
        } else {
            self.GPAItem.gpa = [NSNumber numberWithDouble:0.0];
        }
        
        // Record and report class added
        NSDictionary *classParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSString stringWithFormat:@"%@", self.classField.text], @"Class",
                                     [NSString stringWithFormat:@"%d", self.creditAmount.selectedSegmentIndex + 1], @"Credit",
                                     [NSString stringWithFormat:@"%@", self.gradeLabel.text], @"Grade",
                                     nil];
        [Flurry logEvent:@"Classes_Added" withParameters:classParams];
        
        return YES;
        
    } else {
        
        // Shake the textfield and cancel the segue
        [self shake:self.classField];
        return NO;
    }
}

-(void)shake:(UIView *)field
{
    const int reset = 5;
    const int maxShakes = 6;
    
    static int shakes = 0;
    static int translate = reset;
    
    [UIView animateWithDuration: 0.09 - (shakes * .01) // reduce duration every shake from .09 to .04
                          delay: 0.01f //edge wait delay
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{field.transform = CGAffineTransformMakeTranslation(translate, 0);}
                     completion: ^(BOOL finished) {
                         if (shakes < maxShakes) {
                             shakes++;
                             
                             //throttle down movement
                             if (translate > 0)
                                 translate--;
                             
                             //change direction
                             translate *= -1;
                             [self shake:field];
                         } else {
                             field.transform = CGAffineTransformIdentity;
                             shakes = 0; //ready for next time
                             translate = reset; //ready for next time
                             return;
                         }
                     }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Navigation bar
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x4A4A4A);
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x4A4A4A);
    self.navigationController.navigationBar.translucent = NO;
    
    // Capitlizing first letter of textfields
    self.classField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    
    // Slider
    self.stepValue = 1.0f;
    self.lastStep = (self.gradeSlider.value) /self.stepValue;
    
    // Textfield keyboard hide
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    // Listening for Segment value change
    [self.creditAmount addTarget:self action:@selector(action) forControlEvents:UIControlEventValueChanged];
    
    // Textfield border color
    self.classField.layer.borderColor = [UIColorFromRGB(0x34AADC)CGColor];
    self.classField.layer.borderWidth = 1.0;
    self.classField.layer.cornerRadius = 4;
    
    // Placeholder classField color
    [self.classField setValue: UIColorFromRGB(0x34AADC) forKeyPath:@"_placeholderLabel.textColor"];
}

// Sliding away keyboard when Segment value changes
- (void)action {
    [self dismissKeyboard];
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
        
    } else if (self.gradeSlider.value == 1) {
        self.gradeLabel.text = @"A-";
        
    } else if (self.gradeSlider.value == 2) {
        self.gradeLabel.text = @"B+";
        
    } else if (self.gradeSlider.value == 3) {
        self.gradeLabel.text = @"B";
        
    } else if (self.gradeSlider.value == 4) {
        self.gradeLabel.text = @"B-";
        
    } else if (self.gradeSlider.value == 5) {
        self.gradeLabel.text = @"C+";
        
    } else if (self.gradeSlider.value == 6) {
        self.gradeLabel.text = @"C";
        
    } else if (self.gradeSlider.value == 7) {
        self.gradeLabel.text = @"C-";
        
    } else if (self.gradeSlider.value == 8) {
        self.gradeLabel.text = @"D+";
        
    } else if (self.gradeSlider.value == 9) {
        self.gradeLabel.text = @"D";
        
    } else if (self.gradeSlider.value == 10) {
        self.gradeLabel.text = @"F";
    }
    
}

- (void)dismissKeyboard {
    [_classField resignFirstResponder];
}

@end
