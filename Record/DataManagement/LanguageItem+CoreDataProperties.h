//
//  LanguageItem+CoreDataProperties.h
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "LanguageItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LanguageItem (CoreDataProperties)

+ (NSFetchRequest<LanguageItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *keyword;
@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
