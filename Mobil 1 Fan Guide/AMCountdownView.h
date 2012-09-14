//
//  AMCountdownView.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/7/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBTickerView;

@interface AMCountdownView : UIView

@property (strong, nonatomic) NSString *days;
@property (strong, nonatomic) NSString *hours;
@property (strong, nonatomic) NSString *minutes;
@property (strong, nonatomic) NSString *seconds;

@property (strong, nonatomic) SBTickerView *countdownDays;
@property (strong, nonatomic) SBTickerView *countdownHours;
@property (strong, nonatomic) SBTickerView *countdownMinutes;
@property (strong, nonatomic) SBTickerView *countdownSeconds;

@property (nonatomic) int cachedTabBarSelectedIndex;

@end
