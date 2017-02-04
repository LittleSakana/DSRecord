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

+ (BOOL)insertSports:(Sports*)sport;

+ (BOOL)deleteSports:(Sports*)sport;

+ (BOOL)modifySports:(Sports*)sport;

+ (NSArray*)searchSportsWithKeyword:(NSString*)keyword andTime:(NSString*)time;

@end

NS_ASSUME_NONNULL_END

#import "Sports+CoreDataProperties.h"
