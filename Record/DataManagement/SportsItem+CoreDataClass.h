//
//  SportsItem+CoreDataClass.h
//  Record
//
//  Created by fengdongsheng on 17/2/4.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface SportsItem : NSManagedObject

+ (NSArray*)searchSportsWithName:(NSString*)name;

+ (NSArray*)searchSportsWithKeyword:(NSString* _Nullable)keyword;

+ (BOOL)deleteObjectKeyword:(NSString* _Nonnull)keyword;

+ (BOOL)addObjectWithKeyword:(NSString*)keyword andName:(NSString*)name;

@end

NS_ASSUME_NONNULL_END

#import "SportsItem+CoreDataProperties.h"
