//
//  AppDelegate.m
//  Example
//
//  Created by Raimundas Sakalauskas on 02/07/2018.
//  Copyright © 2018 Particle Inc. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@import UIKit;
@import Firebase;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    return YES;
}


@end
