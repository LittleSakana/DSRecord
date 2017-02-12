//
//  Password+CoreDataProperties.h
//  Record
//
//  Created by fengdongsheng on 17/2/12.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Password+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Password (CoreDataProperties)

+ (NSFetchRequest<Password *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *keyword;
@property (nullable, nonatomic, copy) NSString *detailDes;
@property (nullable, nonatomic, copy) NSString *account;

@end

NS_ASSUME_NONNULL_END
