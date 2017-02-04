//
//  BaseVC.h
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController

- (void)showMessage:(NSString *)msg;

- (void)popVC;

- (void)dsPushViewController:(UIViewController*)vc animated:(BOOL)animated;

@end
