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
#import "M1WallpaperView.h"
#import "FDCurlViewControl.h"

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

- (void)loadView {
	[super loadView];
    
    _wallpaperView = [[M1WallpaperView alloc] initWithFrame:self.view.bounds];
	[_wallpaperView setPaddingTop:225];
	[_wallpaperView setDelegate:self];
	[_wallpaperView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	[self.view insertSubview:self.wallpaperView belowSubview:self.technologyScroller];
    
    _curlButton = [[FDCurlViewControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
	[_curlButton setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	[_curlButton setHidesWhenAnimating:NO];
	[_curlButton setTargetView:self.technologyScroller];
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
    gradient.frame = CGRectMake(self.technologyScroller.frame.origin.x-100, self.technologyScroller.frame.origin.y, self.technologyScroller.frame.size.width*2.9+200, self.technologyScroller.frame.size.height);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHue:0.583 saturation:0.583 brightness:0.188 alpha:1.000] CGColor], (id)[[UIColor colorWithHue:0.595 saturation:0.269 brightness:0.102 alpha:1.000] CGColor], nil];
    [self.technologyScroller.layer insertSublayer:gradient atIndex:0];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!self.didHighlightWallpaper) {
        [self.curlButton curlViewUp];
        _didHighlightWallpaper = YES;
    }
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
    self.tourButton.frame = CGRectMake(self.tourOrigin.x+(self.tourOrigin.x*(offset/7000)), self.tourButton.frame.origin.y, self.tourButton.frame.size.width, self.tourButton.frame.size.height);
}

- (IBAction)showTechInfo:(id)sender {
    [self performSegueWithIdentifier:@"showStoryView" sender:sender];
}

- (void)performSegueWithSpoofedSenderTag:(int)tag
{
    UIButton *spoofButton = [[UIButton alloc] init];
    spoofButton.tag = tag;
    [self performSegueWithIdentifier:@"showStoryView" sender:spoofButton];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    M1TechnologyStoryViewController *destination = [segue destinationViewController];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([sender tag]==1) {
        destination.navigationItem.title = @"MP4-27";
        destination.infoSectionContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MP4-27" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
        [defaults setObject:@"UNLOCKED" forKey:@"Wallpaper1"];
    } else if ([sender tag]==2) {
        destination.navigationItem.title = @"Drivers";
        destination.infoSectionContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Driver-Jenson" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
        
        destination.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Lewis" style:UIBarButtonItemStyleBordered target:destination action:@selector(toggleDriver:)];
        [defaults setObject:@"UNLOCKED" forKey:@"Wallpaper2"];
    } else if ([sender tag]==3) {
        destination.navigationItem.title = @"Fan Fest";
        destination.infoSectionContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FanFest" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
        [defaults setObject:@"UNLOCKED" forKey:@"Wallpaper3"];
    } else if ([sender tag]==4) {
        destination.navigationItem.title = @"Track";
        destination.infoSectionContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Track" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
        [defaults setObject:@"UNLOCKED" forKey:@"Wallpaper4"];
    } else if ([sender tag]==5) {
        destination.navigationItem.title = @"Tour";
        destination.infoSectionContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Tour" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
        [defaults setObject:@"UNLOCKED" forKey:@"Wallpaper5"];
    }
    
    [defaults synchronize];
}

- (void)didCaptureTouchOnPaddingRegion:(M1WallpaperView *)wallpaperView {
	[self.curlButton curlViewDown];
}

@end
