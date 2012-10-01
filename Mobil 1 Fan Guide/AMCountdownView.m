//
//  AMCountdownView.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/7/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "UIView+ParentViewController.h"
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
        UITabBarItem *scheduleTabBar = [self.tabBarController.tabBar.items objectAtIndex:1];
        // The countdown is over, check to see if we're within the race window
        if ([self isRaceWindow]) {
            // Race is happening, display Live Now graphic
            _winBanner.image = [UIImage imageNamed:@"Live-Now"];
            _winBanner.hidden = NO;
            scheduleTabBar.title = @"Live Now!";
        } else {
            // Race is over, display results and win banner if applicable
            // Flood control
            if (self.checkInterval>=1) {
                _checkInterval--;
            } else {
                // Set check interval to every 4 minutes until results are posted
                _checkInterval = 240;
                
                // Fetch results file if no first place name or if we're showing the temporary results file.
                if (!self.firstPlace || self.firstPlace == @"Results coming soon!") {
                    MKNetworkEngine *engine = [[MKNetworkEngine alloc] init];
                    
                    MKNetworkOperation *raceResults = [engine operationWithURLString:@"https://www.ilovetheory.com/sites/com.apps.mobil1.f1/files/Results.json" params:nil httpMethod:@"GET"];
                    
                    [raceResults onCompletion:^(MKNetworkOperation *completedOperation) {
                        _resultsJSON = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:kNilOptions error:nil];
                        
                        // Fetch the first row from the results to check who won
                        NSString *firstPlaceFinisher = [[[[self.resultsJSON objectAtIndex:0] valueForKey:@"section"] objectAtIndex:0] valueForKey:@"title"];
                        _firstPlace = firstPlaceFinisher;
                        
                        // Make sure we display the correct win banner, if appropriate
                        if ([firstPlaceFinisher isEqualToString: @"Jenson Button"]) {
                            // Show Jenson win banner
                            _winBanner.image = [UIImage imageNamed:@"Win-Jenson"];
                        } else if ([firstPlaceFinisher isEqualToString: @"Lewis Hamilton"]) {
                            // Show Lewis win banner
                            _winBanner.image = [UIImage imageNamed:@"Win-Lewis"];
                        } else {
                            // Show generic banner
                            _winBanner.image = [UIImage imageNamed:@"Win-Generic"];
                        }
                        
                        _winBanner.hidden = NO;
                    } onError:^(NSError *error) { NSLog(@"%@", error); }];
                    
                    [engine enqueueOperation:raceResults];
                }
                
                scheduleTabBar.title = @"Results";
            }
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
