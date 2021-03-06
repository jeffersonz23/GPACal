//
//  GPACal_AppDelegate.m
//  GPACal
//
//  Created by Andrew Robinson on 4/18/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "GPACal_AppDelegate.h"
#import "Flurry.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation GPACal_AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    // Navigation bar title color
//    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowColor = UIColorFromRGB(0x4A4A4A);
//    shadow.shadowOffset = CGSizeMake(0, 1);
//    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
//                                                           UIColorFromRGB(0x34AADC), NSForegroundColorAttributeName,
//                                                           shadow, NSShadowAttributeName,
//                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           UIColorFromRGB(0x34AADC), NSForegroundColorAttributeName,
                                                           nil, nil,
                                                           [UIFont fontWithName:@"System" size:21.0], NSFontAttributeName, nil]];

    // This may come in handy one day.
//    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    
    // Hiding API key
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Keys" ofType:@"plist"];
    NSDictionary *plistData = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *key = [plistData objectForKey:@"FlurryAPI"];
    
    // Enabling Flurry
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:key];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
