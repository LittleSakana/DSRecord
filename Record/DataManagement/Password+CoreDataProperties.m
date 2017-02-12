//
//  Password+CoreDataProperties.m
//  Record
//
//  Created by fengdongsheng on 17/2/12.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Password+CoreDataProperties.h"

@implementation Password (CoreDataProperties)

+ (NSFetchRequest<Password *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Password"];
}

@dynamic keyword;
@dynamic detailDes;
@dynamic account;

@end
