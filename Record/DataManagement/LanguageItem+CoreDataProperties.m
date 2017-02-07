//
//  LanguageItem+CoreDataProperties.m
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "LanguageItem+CoreDataProperties.h"

@implementation LanguageItem (CoreDataProperties)

+ (NSFetchRequest<LanguageItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LanguageItem"];
}

@dynamic keyword;
@dynamic name;

@end
