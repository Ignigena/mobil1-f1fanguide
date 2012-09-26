//
//  M1SecondViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <EventKit/EventKit.h>
#import <Social/Social.h>
#import "AMCountdownView.h"
#import "M1CountdownViewController.h"
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
    
    self.scheduleTabTable.separatorColor = [UIColor blackColor];
    
    self.schedule = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Schedule.json"]] options:kNilOptions error:nil];
    _isResults = NO;
    [self.scheduleTabTable reloadData];
    
    [self countdownUpdated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countdownUpdated) name:@"AMCountdownDidChangeNotification" object:nil];
}

- (void)countdownUpdated
{
    M1CountdownViewController *countdownController = (M1CountdownViewController *)self.tabBarController;
    
    if ([countdownController.countdownView isCountdownFinished]) {
        self.scheduleTabTitle.hidden = YES;
        self.scheduleTabTable.frame = CGRectMake(0, 0, self.scheduleTabTable.frame.size.width, self.view.frame.size.height);
        
        if (!self.isResults) {
            #warning Replace with internet fetched Results.json file
            self.schedule = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Results.json"]] options:kNilOptions error:nil];
            _isResults = YES;
            [self.scheduleTabTable reloadData];
        }
    }
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
    cell.detailTextLabel.text = self.isResults ? [cellValue objectForKey:@"time"] : [NSString formattedDateRelativeToNow: [self.dateFormatter dateFromString: [cellValue objectForKey:@"date"]]];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = cell.selectedBackgroundView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHue:0.58 saturation:0.53 brightness:0.33 alpha:1.0] CGColor], (id)[[UIColor colorWithHue:0.58 saturation:0.78 brightness:0.25 alpha:1.0] CGColor], nil];
    [cell.selectedBackgroundView.layer insertSublayer:gradient atIndex:0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isResults)
        return;
    
    NSDictionary *selectedSection = [self.schedule objectAtIndex:indexPath.section];
    NSArray *selectedRow = [selectedSection objectForKey:@"section"];
    NSDictionary *cellValue = [selectedRow objectAtIndex:indexPath.row];
    
    NSString *sheetTitle = [NSString stringWithFormat:@"%@ - %@", [cellValue objectForKey:@"title"], [NSString formattedDateRelativeToNow: [self.dateFormatter dateFromString: [cellValue objectForKey:@"date"]]]];
    
    UIActionSheet *scheduleSelection = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add to iCal", @"Directions", @"Share on Facebook", nil];
    
    [scheduleSelection showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
        [self registerEventInCalendar];
    else if (buttonIndex==1)
        [self getDirectionsToEvent];
    else if (buttonIndex==2)
        [self shareEventOnFacebook];
    
    [self.scheduleTabTable deselectRowAtIndexPath:[self.scheduleTabTable indexPathForSelectedRow] animated:YES];
}

- (void)registerEventInCalendar
{
    NSDictionary *selectedSection = [self.schedule objectAtIndex:[self.scheduleTabTable indexPathForSelectedRow].section];
    NSArray *selectedRow = [selectedSection objectForKey:@"section"];
    NSDictionary *cellValue = [selectedRow objectAtIndex:[self.scheduleTabTable indexPathForSelectedRow].row];
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error){
        if (!granted) return;
        EKEvent *eventToAdd     = [EKEvent eventWithEventStore:eventStore];
        eventToAdd.title        = [NSString stringWithFormat:@"Austin F1: %@", [cellValue objectForKey:@"title"]];
        eventToAdd.startDate    = [self.dateFormatter dateFromString:[cellValue objectForKey:@"date"]];
        eventToAdd.endDate      = [self.dateFormatter dateFromString:[cellValue objectForKey:@"end"]];
        eventToAdd.location     = [cellValue objectForKey:@"location"];
        eventToAdd.notes        = @"Austin Fan Fest powered by Mobil 1";
        eventToAdd.alarms       = [NSArray arrayWithObject:[EKAlarm alarmWithRelativeOffset:-86400]];
        
        [eventToAdd setCalendar:[eventStore defaultCalendarForNewEvents]];
        [eventStore saveEvent:eventToAdd span:EKSpanThisEvent error:nil];
    }];
}

- (void)getDirectionsToEvent
{
    NSDictionary *selectedSection = [self.schedule objectAtIndex:[self.scheduleTabTable indexPathForSelectedRow].section];
    NSArray *selectedRow = [selectedSection objectForKey:@"section"];
    NSDictionary *cellValue = [selectedRow objectAtIndex:[self.scheduleTabTable indexPathForSelectedRow].row];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/maps?daddr=%@", [cellValue objectForKey:@"maps"]]]];
}

- (void)shareEventOnFacebook
{
    NSDictionary *selectedSection = [self.schedule objectAtIndex:[self.scheduleTabTable indexPathForSelectedRow].section];
    NSArray *selectedRow = [selectedSection objectForKey:@"section"];
    NSDictionary *cellValue = [selectedRow objectAtIndex:[self.scheduleTabTable indexPathForSelectedRow].row];
    SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result) {
            [fbController dismissViewControllerAnimated:YES completion:nil];
            
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default: {
                    NSLog(@"Cancelled...");
                }
                    break;
                case SLComposeViewControllerResultDone: {
                    NSLog(@"Posted...");
                }
                    break;
            }};
        
        [fbController addImage:[UIImage imageNamed:@"AppIcon@2x"]];
        [fbController setInitialText:[NSString stringWithFormat:@"I'm attending the Austin F1: %@ at %@", [cellValue objectForKey:@"title"], [cellValue objectForKey:@"date"]]];
        [fbController addURL:[NSURL URLWithString:@"http://austinfanfest.com/"]];
        [fbController setCompletionHandler:completionHandler];
        [self presentViewController:fbController animated:YES completion:nil];
    }
}

@end
