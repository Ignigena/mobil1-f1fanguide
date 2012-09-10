//
//  AMCountdownModel.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "AMCountdownModel.h"

@implementation AMCountdownModel

@synthesize countdown,
            calendar,
            components,
            currentDate,
            targetDate;

- (id)init {
    self = [super init];
    
    self.calendar = [NSCalendar currentCalendar];
    self.targetDate = [NSDate date];
    
    return self;
}

- (id)initWithTargetDate:(NSDate *)target {
    self = [self init];
    
    self.targetDate = target;
    
    return self;
}

- (void)logDifferenceInTime {
    NSLog(@"%@", [NSString stringWithFormat:@"%i Days %i Hours %i Minutes %i Seconds", self.components.day, self.components.hour, self.components.minute, self.components.second]);
}

- (void)run {
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
}

- (void)update {
    self.components = [calendar components:(NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date] toDate:targetDate options:0];
    
    NSDictionary *countdownComponents = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithInt: self.components.day], @"Days",
                                            [NSNumber numberWithInt: self.components.hour], @"Hours",
                                            [NSNumber numberWithInt: self.components.minute], @"Minutes",
                                            [NSNumber numberWithInt: self.components.second], @"Seconds",
                                            nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AMCountdownDidChangeNotification" object:nil userInfo:countdownComponents];
}

@end
