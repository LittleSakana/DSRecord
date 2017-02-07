//
//  LanguageItemListVC.h
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "BaseVC.h"
#import "LanguageItem+CoreDataClass.h"

@protocol LanguageItemDelegate <NSObject>

- (void)selectLanguageItem:(LanguageItem*)languageItem;

@end

@interface LanguageItemListVC : BaseVC

@property (nonatomic, weak  ) id<LanguageItemDelegate> delegate;

@end
