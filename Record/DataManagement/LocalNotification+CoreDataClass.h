//
//  LocalNotification+CoreDataClass.h
//  Record
//
//  Created by fengdongsheng on 17/2/9.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalNotification : NSManagedObject

+ (LocalNotification*)searchItemByWithKeyword:(NSString*)keyword;

+ (NSArray*)searchLocalNotificationWithKeyword:(NSString* _Nullable)keyword;

+ (BOOL)deleteObjectKeyword:(NSString* _Nonnull)keyword;

+ (BOOL)addObjectWithKeyword:(NSString*)keyword andTime:(NSString*)fireTime andContent:(NSString*)strContent;

@end

NS_ASSUME_NONNULL_END

#import "LocalNotification+CoreDataProperties.h"
