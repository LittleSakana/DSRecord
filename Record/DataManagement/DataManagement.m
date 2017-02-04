//
//  DataManagement.m
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "DataManagement.h"

@implementation DataManagement

+ (instancetype)sharedDataManagement{
    static DataManagement *management;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        management = [[DataManagement alloc] init];
    });
    return management;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initMOC];
    }
    return self;
}

- (void)initMOC{
    
    // 创建上下文对象，并发队列设置为主队列
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 创建托管对象模型，并使用Company.momd路径当做初始化参数
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    // 创建持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", @"Model"];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    // 上下文对象设置属性为持久化存储器
    self.managedObjectContext.persistentStoreCoordinator = coordinator;
}

@end
