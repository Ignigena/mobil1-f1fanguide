//
//  M1FirstViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1TechnologyViewController.h"
#import "M1FirstViewController.h"
#import "NSString+HTML.h"

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
    
    [[self parentViewController].view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ScrollBackground"]]];
    [self.navigationItem setBackBarButtonItem: [[UIBarButtonItem alloc]
                                                initWithTitle: @"News"
                                                style: UIBarButtonItemStyleBordered
                                                target: nil action: nil]];
    
    _popup = [[SNPopupView alloc] initWithString:@"Unlock exclusive wallpapers!" withFontOfSize:12];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.popup showAtPoint:CGPointMake(200,self.view.frame.size.height+2) inView:self.view animated:YES];
    
    [self performSelector:@selector(dismissPopup) withObject:nil afterDelay:3.0];
}

- (void)dismissPopup
{
    [self.popup dismiss:YES];
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
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 92)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 2;
        [cell addSubview: imageView];
    }
    
    if ([[self.newsFeed objectForKey:@"articles"] count] >= indexPath.row+1) {
        NSDictionary *cellValue = [[self.newsFeed objectForKey:@"articles"] objectAtIndex:indexPath.row];
    
        cell.textLabel.text = [cellValue objectForKey:@"title"];
        cell.detailTextLabel.text = [cellValue objectForKey:@"subtitle"];
        
        MKNetworkEngine *engine = [[MKNetworkEngine alloc] init];
        
        MKNetworkOperation *articleImage = [engine operationWithURLString:[cellValue objectForKey:@"image"] params:nil httpMethod:@"GET"];
        
        [articleImage onCompletion:^(MKNetworkOperation *completedOperation) {
            ((UIImageView *)[cell viewWithTag:2]).image = [UIImage imageWithData:[completedOperation responseData]];
        } onError:^(NSError *error) { NSLog(@"%@", error); }];
        
        [engine enqueueOperation:articleImage];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellValue = [[self.newsFeed objectForKey:@"articles"] objectAtIndex:indexPath.row];
    
    if ([[cellValue objectForKey:@"performTechnologySegue"] isEqualToString:@"YES"]) {
        [(UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController setSelectedIndex: 2];
        M1TechnologyViewController *techViewController = (M1TechnologyViewController *)[((UINavigationController *)[((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController) selectedViewController]).viewControllers objectAtIndex:0] ;
        
        [techViewController performSegueWithSpoofedSenderTag:[[cellValue objectForKey:@"technologySegueID"] intValue]];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];        
        [self performSegueWithIdentifier:@"showNewsStory" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destination = [segue destinationViewController];
    NSDictionary *cellValue = [[self.newsFeed objectForKey:@"articles"] objectAtIndex:self.newsTable.indexPathForSelectedRow.row];
    
    [destination.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ScrollBackground"]]];
    
    destination.navigationItem.title = [cellValue objectForKey:@"title"];
    [(UIWebView *)destination.view loadHTMLString:[[cellValue objectForKey:@"body"] stringByDecodingHTMLEntities] baseURL:[NSURL URLWithString: @"http://ilovetheory.com/apps/mobil1/f1"]];
}

@end
