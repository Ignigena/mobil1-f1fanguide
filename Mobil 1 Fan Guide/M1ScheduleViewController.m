//
//  M1SecondViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1ScheduleViewController.h"

@interface M1ScheduleViewController ()

@end

@implementation M1ScheduleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"d-M-yyy H:m"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CST"]];
    
    NSDate *today = [NSDate date];
    NSDate *raceDate = [dateFormatter dateFromString:@"16-11-2012 18:00"];
    NSDate *raceFinishedDate = [dateFormatter dateFromString:@"16-11-2012 20:00"];
    
    // If the current time is during the race window (2hrs) change to Live Now
    if ([today compare:raceDate]==NSOrderedSame && [today compare:raceFinishedDate]==NSOrderedAscending) {
        self.scheduleTabTitle.hidden = YES;
    }
    
    // If the current time is after the race change to Results
    if ([today compare:raceFinishedDate]==NSOrderedDescending) {
        self.scheduleTabTitle.text = @"Race Results";
    }

    self.schedule = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Schedule.json"]] options:kNilOptions error:nil];
    NSLog(@"%@", [self.schedule objectAtIndex:0]);

    [self.scheduleTabTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.schedule count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dictionary = [self.schedule objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"section"];
    return [array count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.schedule objectAtIndex:section] objectForKey:@"title"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScheduleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *selectedSection = [self.schedule objectAtIndex:indexPath.section];
    NSArray *selectedRow = [selectedSection objectForKey:@"section"];
    NSDictionary *cellValue = [selectedRow objectAtIndex:indexPath.row];
    cell.textLabel.text = [cellValue objectForKey:@"title"];
    cell.detailTextLabel.text = [cellValue objectForKey:@"date"];
    
    return cell;
}

@end
