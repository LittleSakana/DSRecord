//
//  Language+CoreDataProperties.m
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Language+CoreDataProperties.h"

@implementation Language (CoreDataProperties)

+ (NSFetchRequest<Language *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Language"];
}

@dynamic language_count;
@dynamic language_keyword;
@dynamic language_name;
@dynamic language_time;

@end
