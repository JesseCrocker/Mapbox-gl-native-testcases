//
//  AppDelegate.m
//  MapboxTest
//
//  Created by Jesse Crocker on 11/8/16.
//  Copyright © 2016 Trailbehind inc. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
  ViewController *viewController = [[ViewController alloc] init];
  [self.window setRootViewController:viewController];
  [self.window makeKeyAndVisible];
  return YES;
}


@end
