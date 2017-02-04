//
//  Sports+CoreDataClass.h
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sports : NSManagedObject

+ (BOOL)addObjectWithTime:(NSString*)time andKeyword:(NSString*)keyword andCount:(int16_t)count;

+ (BOOL)deleteObjectWithTime:(NSString*)time andKeyword:(NSString*)keyword;

+ (BOOL)modifyObejectByTime:(NSString*)time andKeyword:(NSString*)keyword andSports:(Sports*)sport;

+ (NSArray*)searchSportsWithKeyword:(NSString*)keyword andTime:(NSString*)time;

@end

NS_ASSUME_NONNULL_END

#import "Sports+CoreDataProperties.h"
