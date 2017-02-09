//
//  LocalNotification+CoreDataClass.m
//  Record
//
//  Created by fengdongsheng on 17/2/9.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "LocalNotification+CoreDataClass.h"
#import "DataManagement.h"

@implementation LocalNotification

+ (LocalNotification*)searchItemByWithKeyword:(NSString*)keyword{
    NSArray *arrItem = [LocalNotification searchLocalNotificationWithKeyword:keyword];
    if (arrItem && arrItem.count == 1) {
        LocalNotification *item = [arrItem firstObject];
        return item;
    }else{
        return nil;
    }
}

+ (NSArray*)searchLocalNotificationWithKeyword:(NSString* _Nullable)keyword{
    // 建立获取数据的请求对象，指明对Language实体进行删除操作
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"LocalNotification"];
    
    if (keyword && keyword.length > 0) {
        // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"keyword = %@",keyword];
        request.predicate = predicate;
    }
    
    // 执行获取操作，找到要删除的对象
    NSError *error = nil;
    NSArray *arrtemp = [[DataManagement sharedDataManagement].managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        return nil;
    }
    
    return arrtemp;
}

+ (BOOL)deleteObjectKeyword:(NSString* _Nonnull)keyword{
    // 先执行查询操作，如果已存在则执行更新操作
    NSArray *arrTemp = [self searchLocalNotificationWithKeyword:keyword];
    if (arrTemp && arrTemp.count > 0) {
        [arrTemp enumerateObjectsUsingBlock:^(LocalNotification * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[DataManagement sharedDataManagement].managedObjectContext deleteObject:obj];
        }];
    }
    
    // 通过上下文保存对象，并在保存前判断是否有更改
    NSError *error = nil;
    if ([DataManagement sharedDataManagement].managedObjectContext.hasChanges) {
        [[DataManagement sharedDataManagement].managedObjectContext save:&error];
    }
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Insert Data Error : %@", error);
        return NO;
    }
    return YES;
}

+ (BOOL)addObjectWithKeyword:(NSString*)keyword andTime:(NSString*)fireTime andContent:(NSString*)strContent{
    // 先执行查询操作，如果已存在则执行更新操作
    NSArray *arrTemp = [self searchLocalNotificationWithKeyword:keyword];
    if (arrTemp && arrTemp.count > 0) {
        [arrTemp enumerateObjectsUsingBlock:^(LocalNotification * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.fireTime = fireTime;
            obj.alertContent = strContent;
        }];
    }else{
        
        // 创建托管对象，并指明创建的托管对象所属实体名
        LocalNotification *emp = [NSEntityDescription insertNewObjectForEntityForName:@"LocalNotification" inManagedObjectContext:[DataManagement sharedDataManagement].managedObjectContext];
        emp.keyword = keyword;
        emp.fireTime = fireTime;
        emp.alertContent = strContent;
    }
    
    // 通过上下文保存对象，并在保存前判断是否有更改
    NSError *error = nil;
    if ([DataManagement sharedDataManagement].managedObjectContext.hasChanges) {
        [[DataManagement sharedDataManagement].managedObjectContext save:&error];
    }
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Insert Data Error : %@", error);
        return NO;
    }
    return YES;
}

+ (void)scheduleLocalNotifications{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSArray *arrTemp = [LocalNotification searchLocalNotificationWithKeyword:@""];
    NSMutableArray *arrNotification = [NSMutableArray new];
    for (LocalNotification *noti in arrTemp) {
        UILocalNotification *localNotifi = [UILocalNotification new];
        localNotifi.fireDate = [NSDate dateWithString:[[R_Utils getShortStringDate:nil] stringByAppendingFormat:@" %@",noti.fireTime]
                                               format:@"yyyy-MM-dd HH:mm"];
        localNotifi.repeatInterval = kCFCalendarUnitDay;
        localNotifi.alertTitle = @"Record";
        localNotifi.alertBody = noti.alertContent;
        localNotifi.applicationIconBadgeNumber = 1;
        localNotifi.userInfo = @{@"keyword":noti.keyword};
        [arrNotification addObject:localNotifi];
    }
    [[UIApplication sharedApplication] setScheduledLocalNotifications:arrNotification];
}

+ (void)cancelNotification:(LocalNotification*)noti{
    NSArray *arrTemp = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *localNoti in arrTemp) {
        NSDictionary *dict = localNoti.userInfo;
        if ([[dict objectForKey:@"keyword"] isEqualToString:noti.keyword]) {
            [[UIApplication sharedApplication] cancelLocalNotification:localNoti];
            return;
        }
    }
}
@end
