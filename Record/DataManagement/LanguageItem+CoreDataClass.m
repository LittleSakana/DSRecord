//
//  LanguageItem+CoreDataClass.m
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "LanguageItem+CoreDataClass.h"
#import "DataManagement.h"

@implementation LanguageItem

+ (BOOL)addObjectWithKeyword:(NSString*)keyword andName:(NSString*)name{
    
    // 先执行查询操作，如果已存在则执行更新操作
    NSArray *arrTemp = [self searchLanguageItemWithKeyword:keyword];
    if (arrTemp && arrTemp.count > 0) {
        [arrTemp enumerateObjectsUsingBlock:^(LanguageItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.name = name;
        }];
    }else{
        
        // 创建托管对象，并指明创建的托管对象所属实体名
        LanguageItem *emp = [NSEntityDescription insertNewObjectForEntityForName:@"LanguageItem" inManagedObjectContext:[DataManagement sharedDataManagement].managedObjectContext];
        emp.keyword = keyword;
        emp.name = name;
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

+ (BOOL)deleteObjectKeyword:(NSString*)keyword{
    
    // 先执行查询操作，如果已存在则执行更新操作
    NSArray *arrTemp = [self searchLanguageItemWithKeyword:keyword];
    if (arrTemp && arrTemp.count > 0) {
        [arrTemp enumerateObjectsUsingBlock:^(LanguageItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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

+ (NSArray*)searchLanguageItemWithKeyword:(NSString*)keyword{
    
    // 建立获取数据的请求对象，指明对Language实体进行删除操作
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"LanguageItem"];
    
    if (keyword && keyword.length > 0) {
        // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"keyword = %@",keyword];
        request.predicate = predicate;
    }
    
    // 执行获取操作，找到要删除的对象
    NSError *error = nil;
    NSArray *employees = [[DataManagement sharedDataManagement].managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        return nil;
    }
    
    return employees;
}

+ (NSArray*)searchLanguageItemWithName:(NSString*)name{
    
    // 建立获取数据的请求对象，指明对Language实体进行删除操作
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"LanguageItem"];
    
    if (name && name.length > 0) {
        // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",name];
        request.predicate = predicate;
    }
    
    // 执行获取操作，找到要删除的对象
    NSError *error = nil;
    NSArray *employees = [[DataManagement sharedDataManagement].managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        return nil;
    }
    
    return employees;
}

@end
