//
//  M1SecondViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1SecondViewController.h"

@interface M1SecondViewController ()

@end

@implementation M1SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSInteger ordinalDay = 37;
    NSInteger year = 2010;
	
    NSDateComponents *components = [[NSDateComponents alloc] init];
	
    [components setDay:ordinalDay];
    [components setYear:year];
	
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //NSDate *date = [gregorian dateFromComponents:components];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CST"]];
	
    // You could keep the formatter and calendar around in an ivar/property
    // if you're doing this a lot.
	
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
	
    NSLog(@"formattedDateString for locale %@: %@",
		  [[dateFormatter locale] localeIdentifier], formattedDateString);
    
    // output is 'formattedDateString for locale en_US: 2/6/10'
    
    //if  ([[Na] timeIntervalSinceNow] <= 0) {
    //    NSLog(@"Before Race!");
    //}
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
