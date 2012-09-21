//
//  M1SecondViewController.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M1ScheduleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSArray *schedule;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (strong, nonatomic) IBOutlet UILabel *scheduleTabTitle;
@property (strong, nonatomic) IBOutlet UITableView *scheduleTabTable;

@end
