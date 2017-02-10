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
    [application setApplicationIconBadgeNumber:0];
    [[HealthManagement shareInstance] authorizeHealthKit:^(BOOL success, NSError *error) {
        if (success) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                //第一次加载应用读取最近30天的步数，否则同步最近三天的数据，防止用户三天不打开应用程序导致步数丢失
                int count = 30;
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstTime"] isEqualToString:@"YES"]) {
                    count = 3;
                }
                for (int i = 0; i < count; i++) {
                    NSDate *date = [[NSDate date] dateByAddingDays:-i];
                    [[HealthManagement shareInstance] getStepCountWithDate:date andCompletion:^(double value, NSError *error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Sports addObjectWithTime:[R_Utils getShortStringDate:date] andKeyword:@"sportsItem4093" andCount:value];
                        });
                    }];
                }
                [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isFirstTime"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            });
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
