//
//  Language+CoreDataProperties.h
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Language+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Language (CoreDataProperties)

+ (NSFetchRequest<Language *> *)fetchRequest;

@property (nonatomic) int16_t language_count;
@property (nullable, nonatomic, copy) NSString *language_keyword;
@property (nullable, nonatomic, copy) NSString *language_name;
@property (nullable, nonatomic, copy) NSString *language_time;

@end

NS_ASSUME_NONNULL_END
