//
//  Language+CoreDataClass.m
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Language+CoreDataClass.h"
#import "DataManagement.h"
#import "LanguageItem+CoreDataClass.h"

@implementation Language

+ (BOOL)addObjectWithTime:(NSString*)time andKeyword:(NSString*)keyword andCount:(int16_t)count{
    
    // 先执行查询操作，如果已存在则执行更新操作
    NSArray *arrTemp = [self searchLanguageWithKeyword:keyword andTime:time];
    if (arrTemp && arrTemp.count > 0) {
        [arrTemp enumerateObjectsUsingBlock:^(Language * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.language_count = count;
        }];
    }else{
        
        // 创建托管对象，并指明创建的托管对象所属实体名
        Language *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Language" inManagedObjectContext:[DataManagement sharedDataManagement].managedObjectContext];
        
        NSArray *arrItem = [LanguageItem searchLanguageItemWithKeyword:keyword];
        if (arrItem && arrItem.count == 1) {
            LanguageItem *item = [arrItem firstObject];
            emp.language_name = item.name;
        }else{
            return NO;
        }
        emp.language_count = count;
        emp.language_keyword = keyword;
        emp.language_time = time;
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

+ (BOOL)deleteObjectWithTime:(NSString*)time andKeyword:(NSString*)keyword{
    
    NSArray *arrTemp = [self searchLanguageWithKeyword:keyword andTime:time];
    if (!arrTemp || arrTemp.count == 0) {
        return NO;
    }
    
    // 遍历符合删除要求的对象数组，执行删除操作
    [arrTemp enumerateObjectsUsingBlock:^(Language * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[DataManagement sharedDataManagement].managedObjectContext deleteObject:obj];
    }];
    
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

+ (BOOL)modifyObejectByTime:(NSString*)time andKeyword:(NSString*)keyword andSports:(Language*)language{
    
    // 先执行删除操作
    [self deleteObjectWithTime:time andKeyword:keyword];
    
    // 再执行插入操作
    return [self addObjectWithTime:language.language_time andKeyword:language.language_keyword andCount:language.language_count];
}

+ (NSArray*)searchLanguageWithKeyword:(NSString*)keyword andTime:(NSString*)time{
    if (!keyword || !time) {
        return nil;
    }
    // 建立获取数据的请求对象，指明对Sports实体进行删除操作
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Language"];
    
    // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
    NSMutableArray *preDicateArr = [NSMutableArray array];
    [preDicateArr addObject:[NSPredicate predicateWithFormat:@"language_time CONTAINS[cd] %@",time]];
    [preDicateArr addObject:[NSPredicate predicateWithFormat:@"language_keyword = %@",keyword]];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:preDicateArr];
    request.predicate = predicate;
    
    NSSortDescriptor *sdSortDate = [NSSortDescriptor sortDescriptorWithKey:@"language_time" ascending:NO];
    request.sortDescriptors = @[sdSortDate];
    
    // 执行获取操作，找到要删除的对象
    NSError *error = nil;
    NSArray *employees = [[DataManagement sharedDataManagement].managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        return nil;
    }
    
    return employees;
}

@end
