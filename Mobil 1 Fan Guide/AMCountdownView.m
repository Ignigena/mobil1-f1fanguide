//
//  AMCountdownView.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/7/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "AMCountdownView.h"
#import "SBTickerView.h"
#import "AMNumberView.h"

@implementation AMCountdownView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countdownUpdated:) name:@"AMCountdownDidChangeNotification" object:nil];
        
        UIImageView *countdownDaysFrame = [[UIImageView alloc] initWithFrame:CGRectMake(8, 31, 76, 70)];
        countdownDaysFrame.image = [UIImage imageNamed:@"TickerFrame"];
        [self addSubview:countdownDaysFrame];
        
        _countdownDays = [[SBTickerView alloc] initWithFrame:CGRectMake(15,35,62,52)];
        _countdownDays.frontView = [AMNumberView tickViewWithTitle:@"00" fontSize:40.0];
        [self addSubview:_countdownDays];
        
        UIImageView *countdownHoursFrame = [[UIImageView alloc] initWithFrame:CGRectMake(84, 31, 76, 70)];
        countdownHoursFrame.image = [UIImage imageNamed:@"TickerFrame"];
        [self addSubview:countdownHoursFrame];
        
        _countdownHours = [[SBTickerView alloc] initWithFrame:CGRectMake(91,35,62,52)];
        _countdownHours.frontView = [AMNumberView tickViewWithTitle:@"00" fontSize:40.0];
        [self addSubview:_countdownHours];
        
        UIImageView *countdownMinutesFrame = [[UIImageView alloc] initWithFrame:CGRectMake(160, 31, 76, 70)];
        countdownMinutesFrame.image = [UIImage imageNamed:@"TickerFrame"];
        [self addSubview:countdownMinutesFrame];
        
        _countdownMinutes = [[SBTickerView alloc] initWithFrame:CGRectMake(167,35,62,52)];
        _countdownMinutes.frontView = [AMNumberView tickViewWithTitle:@"00" fontSize:40.0];
        [self addSubview:_countdownMinutes];
        
        UIImageView *countdownSecondsFrame = [[UIImageView alloc] initWithFrame:CGRectMake(236, 31, 76, 70)];
        countdownSecondsFrame.image = [UIImage imageNamed:@"TickerFrame"];
        [self addSubview:countdownSecondsFrame];
        
        _countdownSeconds = [[SBTickerView alloc] initWithFrame:CGRectMake(243,35,62,52)];
        _countdownSeconds.frontView = [AMNumberView tickViewWithTitle:@"00" fontSize:40.0];
        [self addSubview:_countdownSeconds];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFullSchedule:)];
        [singleTap setNumberOfTapsRequired:1];
        [self addGestureRecognizer:singleTap];
        
        _winBanner = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12, 320, 94)];
        _winBanner.contentMode = UIViewContentModeTop;
        _winBanner.clipsToBounds = YES;
        _winBanner.hidden = YES;
        [self addSubview:self.winBanner];
    }
    return self;
}

- (void)countdownUpdated:(NSNotification *)notification
{
    NSDictionary *dictionary = [notification userInfo];
    
    if (![self.days isEqualToString: [NSString stringWithFormat:@"%02d", [[dictionary valueForKey:@"Days"] intValue]]]) {
        _days = [NSString stringWithFormat:@"%02d", [[dictionary valueForKey:@"Days"] intValue]];
        [_countdownDays setBackView: [AMNumberView tickViewWithTitle:_days fontSize:40.0]];
        [_countdownDays tick:SBTickerViewTickDirectionDown animated:YES completion:nil];
    }
    
    if (![self.hours isEqualToString: [NSString stringWithFormat:@"%02d", [[dictionary valueForKey:@"Hours"] intValue]]]) {
        _hours = [NSString stringWithFormat:@"%02d", [[dictionary valueForKey:@"Hours"] intValue]];
        [_countdownHours setBackView: [AMNumberView tickViewWithTitle:_hours fontSize:40.0]];
        [_countdownHours tick:SBTickerViewTickDirectionDown animated:YES completion:nil];
    }
    
    if (![self.minutes isEqualToString: [NSString stringWithFormat:@"%02d", [[dictionary valueForKey:@"Minutes"] intValue]]]) {
        _minutes = [NSString stringWithFormat:@"%02d", [[dictionary valueForKey:@"Minutes"] intValue]];
        [_countdownMinutes setBackView: [AMNumberView tickViewWithTitle:_minutes fontSize:40.0]];
        [_countdownMinutes tick:SBTickerViewTickDirectionDown animated:YES completion:nil];
    }
    
    if (![self.seconds isEqualToString: [NSString stringWithFormat:@"%02d", [[dictionary valueForKey:@"Seconds"] intValue]]]) {
        _seconds = [NSString stringWithFormat:@"%02d", [[dictionary valueForKey:@"Seconds"] intValue]];
        [_countdownSeconds setBackView: [AMNumberView tickViewWithTitle:_seconds fontSize:40.0]];
        [_countdownSeconds tick:SBTickerViewTickDirectionDown animated:YES completion:nil];
    }
    
    // Check if the countdown has finished running
    if ([self isCountdownFinished]) {
        // The countdown is over, check to see if we're within the race window
        if ([self isRaceWindow]) {
            // Race is happening, display Live Now graphic
            _winBanner.image = [UIImage imageNamed:@"Win-Jenson"];
            _winBanner.hidden = NO;
        } else {
            // Race is over, display results and win banner if applicable
            #warning Need to fetch win banner state from results JSON file.
            _winBanner.image = [UIImage imageNamed:@"Win-Jenson"];
            _winBanner.hidden = NO;
        }
    }
}

- (BOOL)isCountdownFinished
{
    // If all values are below zero the countdown has finished
    if ([self.days floatValue] <= 0 && [self.hours floatValue] <= 0 && [self.minutes floatValue] <= 0 && [self.seconds floatValue] <= 0) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isRaceWindow
{
    // We're within the race window if the current time is within three hours of the race start
    if ([self.days floatValue] == 0 && [self.hours floatValue] >= -3) {
        return YES;
    } else {
        return NO;
    }
}

- (void)showFullSchedule:(id)sender
{
    int currentSelectedIndex = [(UITabBarController *)[[UIApplication sharedApplication] delegate].window.rootViewController selectedIndex];
    
    if (currentSelectedIndex != 1) {
        _cachedTabBarSelectedIndex = currentSelectedIndex;
        [(UITabBarController *)[[UIApplication sharedApplication] delegate].window.rootViewController setSelectedIndex:1];
    } else {
        [(UITabBarController *)[[UIApplication sharedApplication] delegate].window.rootViewController setSelectedIndex:self.cachedTabBarSelectedIndex];
    }
}

@end
