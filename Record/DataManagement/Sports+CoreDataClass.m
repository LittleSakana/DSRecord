//
//  Sports+CoreDataClass.m
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Sports+CoreDataClass.h"
#import "DataManagement.h"
#import <NSDate+YYAdd.h>

@implementation Sports

+ (BOOL)insertSports:(Sports*)sport{
    
//    if (!sport) {
//        return NO;
//    }
    
    // 创建托管对象，并指明创建的托管对象所属实体名
    Sports *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Sports" inManagedObjectContext:[DataManagement sharedDataManagement].managedObjectContext];
    emp.sports_count = 30;
    emp.sports_keyword = @"Squats";
    emp.sports_name = @"深蹲";
    emp.sports_time = [[[NSDate date] stringWithISOFormat] substringToIndex:9];
    
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

+ (BOOL)deleteSports:(Sports*)sport{
    
    if (!sport) {
        return NO;
    }
    
    // 建立获取数据的请求对象，指明对Sports实体进行删除操作
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Sports"];
    
    // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sports_time = %@ & sports_keyword = %@", sport.sports_time,sport.sports_keyword];
    request.predicate = predicate;
    
    // 执行获取操作，找到要删除的对象
    NSError *error = nil;
    NSArray *employees = [[DataManagement sharedDataManagement].managedObjectContext executeFetchRequest:request error:&error];
    
    // 遍历符合删除要求的对象数组，执行删除操作
    [employees enumerateObjectsUsingBlock:^(Sports * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[DataManagement sharedDataManagement].managedObjectContext deleteObject:obj];
    }];
    
    // 保存上下文
    if ([DataManagement sharedDataManagement].managedObjectContext.hasChanges) {
        [[DataManagement sharedDataManagement].managedObjectContext save:nil];
    }
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Delete Data Error : %@", error);
        return NO;
    }
    return YES;
}

+ (BOOL)modifySports:(Sports*)sport{
    
    if (!sport) {
        return NO;
    }
    
    // 建立获取数据的请求对象，指明对Sports实体进行删除操作
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Sports"];
    
    // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sports_time = %@ & sports_keyword = %@", sport.sports_time,sport.sports_keyword];
    request.predicate = predicate;
    
    // 执行获取操作，找到要删除的对象
    NSError *error = nil;
    NSArray *employees = [[DataManagement sharedDataManagement].managedObjectContext executeFetchRequest:request error:&error];
    
    // 遍历符合删除要求的对象数组，执行删除操作
    [employees enumerateObjectsUsingBlock:^(Sports * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.sports_count = sport.sports_count;
    }];
    
    // 保存上下文
    if ([DataManagement sharedDataManagement].managedObjectContext.hasChanges) {
        [[DataManagement sharedDataManagement].managedObjectContext save:nil];
    }
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Delete Data Error : %@", error);
        return NO;
    }
    return YES;
}

+ (NSArray*)searchSportsWithKeyword:(NSString*)keyword andTime:(NSString*)time{
    if (!keyword || !time) {
        return nil;
    }
    // 建立获取数据的请求对象，指明对Sports实体进行删除操作
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Sports"];
    
    // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sports_time = %@ & sports_keyword = %@", time,keyword];
    request.predicate = predicate;
    
    // 执行获取操作，找到要删除的对象
    NSError *error = nil;
    NSArray *employees = [[DataManagement sharedDataManagement].managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        return nil;
    }
    
    return employees;
}

@end
