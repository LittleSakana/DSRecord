//
//  LocalNotification+CoreDataProperties.m
//  Record
//
//  Created by fengdongsheng on 17/2/9.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "LocalNotification+CoreDataProperties.h"

@implementation LocalNotification (CoreDataProperties)

+ (NSFetchRequest<LocalNotification *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LocalNotification"];
}

@dynamic fireTime;
@dynamic alertContent;
@dynamic keyword;

@end
