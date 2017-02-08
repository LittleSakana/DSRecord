//
//  Run+CoreDataClass.m
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Run+CoreDataClass.h"
#import "DataManagement.h"

@implementation Run

+ (BOOL)addObjectWithTime:(NSString*)time andTimeInterval:(NSNumber*)timeInterval andDistance:(CGFloat)distance{
    
    // 先执行查询操作，如果已存在则执行更新操作
    NSArray *arrTemp = [self searchRunRecordWithTime:time];
    if (arrTemp && arrTemp.count > 0) {
        [arrTemp enumerateObjectsUsingBlock:^(Run * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.run_distance = distance;
        }];
    }else{
        
        // 创建托管对象，并指明创建的托管对象所属实体名
        Run *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Run" inManagedObjectContext:[DataManagement sharedDataManagement].managedObjectContext];
        emp.run_distance = distance;
        emp.run_time = time;
        emp.run_time_interval = timeInterval;
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

+ (BOOL)deleteObjectWithTime:(NSString*)time{
    
    NSArray *arrTemp = [self searchRunRecordWithTime:time];
    if (!arrTemp || arrTemp.count == 0) {
        return NO;
    }
    
    // 遍历符合删除要求的对象数组，执行删除操作
    [arrTemp enumerateObjectsUsingBlock:^(Run * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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

+ (BOOL)modifyObejectByTime:(NSString*)time andSports:(Run*)runRecord{
    
    // 先执行删除操作
    [self deleteObjectWithTime:time];
    
    // 再执行插入操作
    return [self addObjectWithTime:runRecord.run_time andTimeInterval:runRecord.run_time_interval andDistance:runRecord.run_distance];
}

+ (NSArray*)searchRunRecordWithTime:(NSString*)time{
    if (!time) {
        return nil;
    }
    // 建立获取数据的请求对象，指明对Sports实体进行删除操作
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Run"];
    
    // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
    NSMutableArray *preDicateArr = [NSMutableArray array];
    [preDicateArr addObject:[NSPredicate predicateWithFormat:@"run_time CONTAINS[cd] %@",time]];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:preDicateArr];
    request.predicate = predicate;
    
    NSSortDescriptor *sdSortDate = [NSSortDescriptor sortDescriptorWithKey:@"run_time" ascending:NO];
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
