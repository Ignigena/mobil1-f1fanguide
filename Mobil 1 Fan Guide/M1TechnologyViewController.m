//
//  M1TechnologyViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/24/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "M1TechnologyViewController.h"

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
    
    _technologyScroller.contentSize = CGSizeMake(self.technologyScroller.frame.size.width*2, self.technologyScroller.contentSize.height);
    _driversOrigin = self.driversButton.frame.origin;
	
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHue:0.583 saturation:0.583 brightness:0.188 alpha:1.000] CGColor], (id)[[UIColor colorWithHue:0.595 saturation:0.269 brightness:0.102 alpha:1.000] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offset = 0-scrollView.contentOffset.x;
    
    self.driversButton.frame = CGRectMake(self.driversOrigin.x+(self.driversOrigin.x*(offset/400)), self.driversButton.frame.origin.y, self.driversButton.frame.size.width, self.driversButton.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
