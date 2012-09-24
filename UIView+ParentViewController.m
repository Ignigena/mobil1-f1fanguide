//
//  UIView+ParentViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/24/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "UIView+ParentViewController.h"

@implementation UIView (ParentViewController)

- (UIViewController *)viewController;
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder viewController];
    } else {
        return nil;
    }
}

- (UITabBarController *)tabBarController;
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
        return [nextResponder tabBarController];
    } else {
        return nil;
    }
}

@end
