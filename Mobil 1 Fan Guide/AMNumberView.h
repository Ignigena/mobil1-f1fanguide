//
//  AMNumberView.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AMNumberView : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, strong) UIColor *titleColor;
+ (id)tickViewWithTitle:(NSString *)title fontSize:(CGFloat)fontSize;
@end
