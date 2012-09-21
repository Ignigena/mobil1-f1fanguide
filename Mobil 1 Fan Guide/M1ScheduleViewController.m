//
//  M1SecondViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1ScheduleViewController.h"
#import "NSString+RelativeDate.h"
#import "JHWebBrowser.h"

@interface M1ScheduleViewController ()

@end

@implementation M1ScheduleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dateFormatter = [[NSDateFormatter alloc]init];
    [_dateFormatter setDateFormat:@"d-M-yyy H:m"];
    [_dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CST"]];
    
    NSDate *today = [NSDate date];
    NSDate *raceDate = [self.dateFormatter dateFromString:@"16-11-2012 18:00"];
    NSDate *raceFinishedDate = [self.dateFormatter dateFromString:@"16-11-2012 20:00"];
    
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
    
    self.scheduleTabTable.separatorColor = [UIColor blackColor];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat width = CGRectGetWidth(tableView.bounds);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ScheduleHeader"]];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 2, width, 20)];
    headerLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:19];
    headerLabel.shadowOffset = CGSizeMake(0, -1);
    headerLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    headerLabel.shadowColor = [UIColor blackColor];
    
    [headerView addSubview:headerLabel];
    
    if (section != 0) {
        UIButton *whatsThisButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        whatsThisButton.frame = CGRectMake(290, 4, 15, 15);
        whatsThisButton.tag = section;
        [whatsThisButton addTarget:self action:@selector(whatsThisButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
        [headerView addSubview:whatsThisButton];
    }
    
    return headerView;
}

- (IBAction)whatsThisButtonClicked:(id)sender
{
    NSString *infoURL = [sender tag] == 1 ? @"http://austinfanfest.com/" : @"http://apple.com";
    
    JHWebBrowser *modalBrowser = [JHWebBrowser new];
    modalBrowser.showDoneButton = YES;
    modalBrowser.url = [NSURL URLWithString:infoURL];
    [self presentViewController:modalBrowser animated:YES completion:nil];
    
    modalBrowser.showAddressBar = NO;
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
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [NSString formattedDateRelativeToNow: [self.dateFormatter dateFromString: [cellValue objectForKey:@"date"]]];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

@end
