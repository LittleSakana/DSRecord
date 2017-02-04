//
//  UITools.h
//  StudentLoan
//
//  Created by fengdongsheng on 16/11/8.
//  Copyright © 2016年 nonobank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITools : NSObject

/**
 *  生成UILabel
 *
 *  @param frame     位置
 *  @param style     样式
 *  @param delegate  代理
 *
 *  @return UITableView
 */
+ (UITableView*)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)delegate;

/**
 *  生成UILabel
 *
 *  @param frame     位置
 *  @param text      文字
 *  @param font      字体大小
 *  @param textColor 字体颜色
 *  @param alignment 文字排布
 *  @param superView 父视图
 *
 *  @return UILabel
 */
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView;

/**
 *  生成UIButton
 *
 *  @param frame          位置
 *  @param title          标题
 *  @param imgName        图片名字
 *  @param imgBgName      背景图片名字
 *  @param font           字体大小
 *  @param titleColor     字体颜色
 *  @param bgColor        背景颜色
 *  @param superView      父视图
 *
 *  @return UIButton
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title setImage:(NSString *)imgName setBgImg:(NSString *)imgBgName font:(UIFont *)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)bgColor SuperView:(UIView *)superView;

/**
 *  生成UIView
 *
 *  @param frame          位置
 *  @param bgColor        背景颜色
 *  @param superView      父视图
 *
 *  @return UIView
 */
+ (UIView *)createViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor superView:(UIView *)superView;

/**
 *  生成UIImageView
 *
 *  @param frame          位置
 *  @param imageName      图片名字
 *  @param superView      父视图
 *
 *  @return UIImageView
 */
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName superView:(UIView *)superView;

@end
