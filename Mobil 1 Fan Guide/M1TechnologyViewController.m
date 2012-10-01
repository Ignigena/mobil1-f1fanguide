//
//  M1TechnologyViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/24/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "M1TechnologyViewController.h"
#import "M1TechnologyStoryViewController.h"

@interface M1TechnologyViewController ()

@end

@implementation M1TechnologyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _technologyScroller.contentSize = CGSizeMake(self.technologyScroller.frame.size.width*2.9, self.technologyScroller.contentSize.height);
    _carsTextOrigin = self.carsText.frame.origin;
    _driversOrigin = self.driversButton.frame.origin;
    _driversTextOrigin = self.driversText.frame.origin;
    _fanFestTextOrigin = self.fanFestText.frame.origin;
    _trackTextOrigin = self.trackText.frame.origin;
    _trackOrigin = self.trackButton.frame.origin;
    _tourOrigin = self.tourButton.frame.origin;
	
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHue:0.583 saturation:0.583 brightness:0.188 alpha:1.000] CGColor], (id)[[UIColor colorWithHue:0.595 saturation:0.269 brightness:0.102 alpha:1.000] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offset = 0-scrollView.contentOffset.x;
    
    self.carsText.frame = CGRectMake(self.carsTextOrigin.x+(self.carsTextOrigin.x*(0-offset/50)), self.carsText.frame.origin.y, self.carsText.frame.size.width, self.carsText.frame.size.height);
    self.driversButton.frame = CGRectMake(self.driversOrigin.x+(self.driversOrigin.x*(offset/450)), self.driversButton.frame.origin.y, self.driversButton.frame.size.width, self.driversButton.frame.size.height);
    self.driversText.frame = CGRectMake(self.driversTextOrigin.x+(self.driversTextOrigin.x*(offset/500)), self.driversText.frame.origin.y, self.driversText.frame.size.width, self.driversText.frame.size.height);
    self.fanFestText.frame = CGRectMake(self.fanFestTextOrigin.x+(self.fanFestTextOrigin.x*(offset/2000)), self.fanFestText.frame.origin.y, self.fanFestText.frame.size.width, self.fanFestText.frame.size.height);
    self.trackButton.frame = CGRectMake(self.trackOrigin.x+(self.trackOrigin.x*(offset/2000)), self.trackButton.frame.origin.y, self.trackButton.frame.size.width, self.trackButton.frame.size.height);
    self.trackText.frame = CGRectMake(self.trackTextOrigin.x+(self.trackTextOrigin.x*(0-offset/12000)), self.trackText.frame.origin.y, self.trackText.frame.size.width, self.trackText.frame.size.height);
    self.tourButton.frame = CGRectMake(self.tourOrigin.x+(self.tourOrigin.x*(offset/8000)), self.tourButton.frame.origin.y, self.tourButton.frame.size.width, self.tourButton.frame.size.height);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    M1TechnologyStoryViewController *destination = [segue destinationViewController];
    
    if ([sender tag]==1) {
        destination.navigationItem.title = @"F1 Cars";
    } else if ([sender tag]==2) {
        destination.navigationItem.title = @"Drivers";
        destination.infoSectionContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Driver-Jenson" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
        
        destination.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Lewis" style:UIBarButtonItemStyleBordered target:destination action:@selector(toggleDriver:)];
    } else if ([sender tag]==3) {
        destination.navigationItem.title = @"Fan Fest";
    } else if ([sender tag]==4) {
        destination.navigationItem.title = @"Track";
    } else if ([sender tag]==5) {
        destination.navigationItem.title = @"Tour";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
