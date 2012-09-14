//
//  M1FirstViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1FirstViewController.h"

@interface M1FirstViewController ()

@end

@implementation M1FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 92.0;
    self.view.superview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Linen"]];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshInitiated:) forControlEvents:UIControlEventValueChanged];
}

-(void)refreshInitiated:(id)sender
{
    #warning Implement refreshing of table view.
    [self.refreshControl endRefreshing];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"M1NewsRowIdentifier"];
                             
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"M1NewsRowIdentifier"];
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableGradient"]];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
