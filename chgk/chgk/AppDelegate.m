//
//  AppDelegate.m
//  chgk
//
//  Created by Admin on 28/07/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuVC.h"
#import <Parse/Parse.h>
#import "DB.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [Parse setApplicationId:@"xY2YIiOHIscOXOHkGUgLOsI5BNTHpKk3FAVfneOc"
                  clientKey:@"Hd3KObGIFrksILNLF5eaGw0AFkA7WbGym42OZ9j2"];
    
    MenuVC *menu = [[MenuVC alloc]init];
    menu.navigationItem.title = @"Меню";
    
    UINavigationController *mainNC = [[UINavigationController alloc]
                                      initWithRootViewController:menu];
    mainNC.navigationBar.translucent = NO;
    self.window.rootViewController = mainNC;

    return YES;
}

@end
