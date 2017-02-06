//
//  Sports+CoreDataProperties.m
//  Record
//
//  Created by fengdongsheng on 17/2/6.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Sports+CoreDataProperties.h"

@implementation Sports (CoreDataProperties)

+ (NSFetchRequest<Sports *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Sports"];
}

@dynamic sports_count;
@dynamic sports_keyword;
@dynamic sports_name;
@dynamic sports_time;

@end
