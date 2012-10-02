//
//  M1FirstViewController.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface M1FirstViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *newsTable;
@property (strong, nonatomic) NSDictionary *newsFeed;

@end
