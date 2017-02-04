//
//  Sports+CoreDataProperties.m
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Sports+CoreDataProperties.h"

@implementation Sports (CoreDataProperties)

+ (NSFetchRequest<Sports *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Sports"];
}

@dynamic sports_time;
@dynamic sports_count;
@dynamic sports_name;
@dynamic sports_keyword;

@end
