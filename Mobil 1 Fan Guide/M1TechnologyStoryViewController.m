//
//  M1TechnologyStoryViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/25/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "M1TechnologyStoryViewController.h"

@interface M1TechnologyStoryViewController ()

@end

@implementation M1TechnologyStoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHue:0.583 saturation:0.583 brightness:0.188 alpha:1.000] CGColor], (id)[[UIColor colorWithHue:0.595 saturation:0.269 brightness:0.102 alpha:1.000] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    _infoSection.opaque = NO;
    _infoSection.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_infoSection loadHTMLString:self.infoSectionContent baseURL:[[NSBundle mainBundle] bundleURL]];
}

- (void)toggleDriver:(UIBarButtonItem *)sender
{
    if ([sender title]==@"Lewis") {
        [_infoSection loadHTMLString:[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Driver-Lewis" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil] baseURL:[[NSBundle mainBundle] bundleURL]];
        
        sender.title = @"Jenson";
    } else {
        [_infoSection loadHTMLString:[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Driver-Jenson" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil] baseURL:[[NSBundle mainBundle] bundleURL]];
        
        sender.title = @"Lewis";
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return false;
    }
    return true;
}

@end
