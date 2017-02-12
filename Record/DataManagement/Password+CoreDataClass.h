//
//  Password+CoreDataClass.h
//  Record
//
//  Created by fengdongsheng on 17/2/12.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Password : NSManagedObject

+ (NSArray*)searchPasswordWithKeyword:(NSString* _Nullable)keyword;

+ (BOOL)deleteObjectKeyword:(NSString* _Nonnull)keyword;

+ (BOOL)addObjectWithKeyword:(NSString*)keyword andAccount:(NSString*)account andDetail:(NSString*)detail;

@end

NS_ASSUME_NONNULL_END

#import "Password+CoreDataProperties.h"
