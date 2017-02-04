//
//  UITools.m
//  StudentLoan
//
//  Created by fengdongsheng on 16/11/8.
//  Copyright © 2016年 nonobank. All rights reserved.
//

#import "UITools.h"

@implementation UITools

+ (UITableView*)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)delegate{
    UITableView *tbv = [[UITableView alloc] initWithFrame:frame style:style];
    tbv.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbv.delegate = delegate;
    tbv.dataSource = delegate;
    tbv.backgroundColor = [UIColor clearColor];
    return tbv;
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = alignment;
    [superView addSubview:label];
    return label;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title setImage:(NSString *)imgName setBgImg:(NSString *)imgBgName font:(UIFont *)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)bgColor SuperView:(UIView *)superView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.backgroundColor = bgColor;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setBackgroundImage:[UIImage imageNamed:imgBgName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [superView addSubview:btn];
    return btn;
}

+ (UIView *)createViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor superView:(UIView *)superView{
    UIView *myView = [[UIView alloc]initWithFrame:frame];
    myView.backgroundColor = bgColor;
    [superView addSubview:myView];
    return  myView;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName superView:(UIView *)superView{
    UIImageView *imv = [[UIImageView alloc]initWithFrame:frame];
    [imv setImage:[UIImage imageNamed:imageName]];
    [superView addSubview:imv];
    return imv;
}
@end
