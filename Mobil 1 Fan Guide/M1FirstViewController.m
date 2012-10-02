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
    [self refreshInitiated:self];
    
    self.tableView.rowHeight = 92.0;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshInitiated:) forControlEvents:UIControlEventValueChanged];
}

-(void)refreshInitiated:(id)sender
{    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] init];
    
    MKNetworkOperation *raceResults = [engine operationWithURLString:@"https://www.ilovetheory.com/apps/mobil1/f1/iphone" params:nil httpMethod:@"GET"];
    
    [raceResults onCompletion:^(MKNetworkOperation *completedOperation) {
        _newsFeed = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:kNilOptions error:nil];
        [self.newsTable reloadData];
        [self.refreshControl endRefreshing];
    } onError:^(NSError *error) { NSLog(@"%@", error); }];
    
    [engine enqueueOperation:raceResults];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self.newsFeed objectForKey:@"articles"] count] <=4) {
        return 4;
    } else {
        return [[self.newsFeed objectForKey:@"articles"] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"M1NewsRowIdentifier"];
                             
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"M1NewsRowIdentifier"];
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableGradient"]];
    }
    
    if ([[self.newsFeed objectForKey:@"articles"] count] >= indexPath.row+1) {
        NSDictionary *cellValue = [[self.newsFeed objectForKey:@"articles"] objectAtIndex:indexPath.row];
    
        cell.textLabel.text = [cellValue objectForKey:@"title"];
        cell.detailTextLabel.text = [cellValue objectForKey:@"subtitle"];
        
        MKNetworkEngine *engine = [[MKNetworkEngine alloc] init];
        
        MKNetworkOperation *articleImage = [engine operationWithURLString:[cellValue objectForKey:@"image"] params:nil httpMethod:@"GET"];
        
        [articleImage onCompletion:^(MKNetworkOperation *completedOperation) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[completedOperation responseData]]];
            imageView.frame = cell.frame;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview: imageView];
        } onError:^(NSError *error) { NSLog(@"%@", error); }];
        
        [engine enqueueOperation:articleImage];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
