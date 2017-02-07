//
//  LanguageItem+CoreDataClass.h
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanguageItem : NSManagedObject

+ (LanguageItem*)searchItemByWithKeyword:(NSString*)keyword;

+ (NSArray*)searchLanguageItemWithName:(NSString*)name;

+ (NSArray*)searchLanguageItemWithKeyword:(NSString* _Nullable)keyword;

+ (BOOL)deleteObjectKeyword:(NSString* _Nonnull)keyword;

+ (BOOL)addObjectWithKeyword:(NSString*)keyword andName:(NSString*)name;

@end

NS_ASSUME_NONNULL_END

#import "LanguageItem+CoreDataProperties.h"
