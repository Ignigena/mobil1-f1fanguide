//
//  M1CountdownViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/7/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//


#import "M1CountdownViewController.h"
#import "AMCountdownView.h"
#import "AMCountdownModel.h"

@implementation M1CountdownViewController

@synthesize countdownView;
@synthesize container;
@synthesize containerFrame;
@synthesize countdownFrame;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.countdownView = [[AMCountdownView alloc] initWithFrame:CGRectMake(0, 0, 320, 94)];
	self.countdownFrame = countdownView.frame;
    
	// A UITabBarController's view has two subviews: the UITabBar and a container UITransitionView that is
	// used to hold the child views. Save a reference to the container.
	for (UIView *view in self.view.subviews) {
		if (![view isKindOfClass:[UITabBar class]]) {
			self.container = view;
			self.containerFrame = view.frame;
		}
	}
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"d-M-yyy"];
    
    AMCountdownModel *countdown = [[AMCountdownModel alloc] initWithTargetDate:[dateFormatter dateFromString:@"22-9-2012"]];
    [countdown run];
    
    [self showCountdownView];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerDidEnterFullscreen:)
                                                 name:@"UIMoviePlayerControllerDidEnterFullscreenNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerDidExitFullscreen:)
                                                 name:@"UIMoviePlayerControllerDidExitFullscreenNotification"
                                               object:nil];
}

- (void)playerDidEnterFullscreen:(NSNotification *)notification
{
    _shouldAutoRotateInterface = NO;
}

- (void)playerDidExitFullscreen:(NSNotification *)notification
{
    _shouldAutoRotateInterface = YES;
}

-(void) orientationChanged:(NSNotification*)notification
{
    if (!self.shouldAutoRotateInterface)
        return;
    
    UIDeviceOrientation interfaceOrientation = [[UIDevice currentDevice] orientation];
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self performSegueWithIdentifier:@"map" sender: self];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)showCountdownView {
	CGFloat containerHeight = containerFrame.size.height;
	CGFloat countdownHeight = countdownView.frame.size.height;
    
	// Resize the frame of the container to add space for the ad banner
	container.frame = CGRectMake(0.0,countdownHeight,320.0,containerHeight - countdownHeight);
    
	// Place the ad banner above the tab bar but below the container
	countdownView.frame = CGRectMake(0.0,8.0,320.0,countdownHeight);
    self.view.backgroundColor = [UIColor colorWithWhite:0.16 alpha:1.0];
    
    UIImageView *tickerGradient = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,20,320.0,94)];
    tickerGradient.image = [UIImage imageNamed:@"TickerGradient"];
    [self.view addSubview:tickerGradient];
    
    UIImageView *tickerLabels = [[UIImageView alloc] initWithFrame:CGRectMake(26,20,268.0,30)];
    tickerLabels.image = [UIImage imageNamed:@"CountdownTitle"];
    tickerLabels.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:tickerLabels];
    
	[self.view addSubview:countdownView];
}

- (void)hideCountdownView {
	// Resize the frame of the container to take up all available space
	container.frame = CGRectMake(0.0,0.0,320.0,containerFrame.size.height);
    
	// Remove the ad banner
	[countdownView removeFromSuperview];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end