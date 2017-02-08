//
//  Run+CoreDataClass.h
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Run : NSManagedObject

+ (BOOL)addObjectWithTime:(NSString*)time andTimeInterval:(NSNumber*)timeInterval andDistance:(CGFloat)distance;

+ (BOOL)deleteObjectWithTime:(NSString*)time;

+ (BOOL)modifyObejectByTime:(NSString*)time andSports:(Run*)runRecord;

+ (NSArray*)searchRunRecordWithTime:(NSString*)time;

@end

NS_ASSUME_NONNULL_END

#import "Run+CoreDataProperties.h"
