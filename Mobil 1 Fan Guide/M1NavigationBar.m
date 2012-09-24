//
//  M1NavigationBar.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/10/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1NavigationBar.h"

@implementation M1NavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    [self setBackgroundImage:[UIImage imageNamed:@"NavBar"] forBarMetrics:UIBarMetricsDefault];
}

@end
