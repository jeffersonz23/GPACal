//
//  GPACal_AboutViewController.m
//  GPACal
//
//  Created by Andrew Robinson on 4/28/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "GPACal_AboutViewController.h"
#import <QuartzCore/QuartzCore.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface GPACal_AboutViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation GPACal_AboutViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender == self.cancel) return;
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
    
    // Rounded image
    NSString *mainpath = [[NSBundle mainBundle] bundlePath];
    self.profileImage.image = [UIImage imageWithContentsOfFile:[mainpath stringByAppendingString:@"/402-Faceit-SirArkimedes.jpg"]];
    self.profileImage.layer.cornerRadius = 30.0;
    self.profileImage.layer.masksToBounds = YES;
    self.profileImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImage.layer.borderWidth = 7.0;
    CGRect frame = self.profileImage.frame;
    frame.size.width = 100;
    frame.size.height = 100;
    self.profileImage.frame = frame;
    
    // Bordered view
    self.scrollView.layer.borderColor = UIColorFromRGB(0x34AADC).CGColor;
    self.scrollView.layer.borderWidth = 1.0;
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
