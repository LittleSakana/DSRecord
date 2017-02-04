//
//  Language+CoreDataProperties.m
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Language+CoreDataProperties.h"

@implementation Language (CoreDataProperties)

+ (NSFetchRequest<Language *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Language"];
}

@dynamic language_time;
@dynamic language_count;
@dynamic language_name;
@dynamic language_keyword;

@end
