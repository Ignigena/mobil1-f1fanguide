//
//  AMCountdownModel.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMCountdownModel : NSObject

@property NSTimer *countdown;

@property NSCalendar *calendar;
@property NSDateComponents *components;

@property NSDate *currentDate;
@property NSDate *targetDate;

- (id)initWithTargetDate:(NSDate *)target;
- (void)logDifferenceInTime;

- (void)run;

@end
