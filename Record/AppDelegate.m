//
//  AppDelegate.m
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabVC.h"
#import "Sports+CoreDataClass.h"
#import "HealthManagement.h"
#import "SportsItem+CoreDataClass.h"
#import "LocalNotification+CoreDataClass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [SportsItem addObjectWithKeyword:@"sportsItem4093" andName:@"步数"];
    [self registerLocalNotification];
    application.applicationIconBadgeNumber = 1;
    application.applicationIconBadgeNumber = 0;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainTabVC *vcMainTab = [[MainTabVC alloc] init];
    self.window.rootViewController = vcMainTab;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[HealthManagement shareInstance] authorizeHealthKit:^(BOOL success, NSError *error) {
        if (success) {
            [[HealthManagement shareInstance] getStepCount:^(double value, NSError *error) {
                [Sports addObjectWithTime:[R_Utils getShortStringDate:nil] andKeyword:@"sportsItem4093" andCount:value];
            }];
        }
    }];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)registerLocalNotification{
    // 请求用户授权
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    NSLog(@"本地通知注册成功");
    [LocalNotification scheduleLocalNotifications];
}
@end
