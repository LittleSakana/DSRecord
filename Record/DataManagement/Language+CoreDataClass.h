//
//  Language+CoreDataClass.h
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Language : NSManagedObject

+ (BOOL)addObjectWithTime:(NSString*)time andKeyword:(NSString*)keyword andCount:(int16_t)count;

+ (BOOL)deleteObjectWithTime:(NSString*)time andKeyword:(NSString*)keyword;

+ (BOOL)modifyObejectByTime:(NSString*)time andKeyword:(NSString*)keyword andSports:(Language*)sport;

+ (NSArray*)searchLanguageWithKeyword:(NSString*)keyword andTime:(NSString*)time;

@end

NS_ASSUME_NONNULL_END

#import "Language+CoreDataProperties.h"
