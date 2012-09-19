//
//  M1CountdownViewController.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/7/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class M1MapViewController;

@protocol M1CountdownViewDelegate <UITabBarControllerDelegate>
- (UIView *)getCountdownView;
@end

@interface M1CountdownViewController : UITabBarController {
	UIView *countdownView;
	UIView *container;
	CGRect countdownFrame;
	CGRect containerFrame;
	id <M1CountdownViewDelegate> delegate;
}

@property (nonatomic, strong) UIView *countdownView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic) CGRect countdownFrame;
@property (nonatomic) CGRect containerFrame;
@property (nonatomic, assign) id <M1CountdownViewDelegate> delegate;

@property (nonatomic) BOOL shouldAutoRotateInterface;

- (void)showCountdownView;
- (void)hideCountdownView;

@end