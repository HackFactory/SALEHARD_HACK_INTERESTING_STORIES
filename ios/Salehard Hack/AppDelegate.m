//
//  AppDelegate.m
//  Salehard Hack
//
//  Created by Vladislav Shakhray on 22.10.2019.
//  Copyright © 2019 Vladislav Shakhray. All rights reserved.
//

#import "AppDelegate.h"
#import "AchievmentManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    AchievmentManager *mgr = [AchievmentManager new];
    
    [mgr setupAchievments:@[[NSMutableDictionary dictionaryWithObjects:@[@"first_open", @"Первооткрыватель", @"first_open.png"] forKeys:@[@"id", @"name", @"image"]],
    [NSMutableDictionary dictionaryWithObjects:@[@"social_lyft", @"Социальный лифт", @"social_lyft.png"] forKeys:@[@"id", @"name", @"image"]]
    ]];
    
    return YES;
    return YES;
    
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
