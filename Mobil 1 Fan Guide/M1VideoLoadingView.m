//
//  M1VideoLoadingView.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/14/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1VideoLoadingView.h"

@implementation M1VideoLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.animationImages = [NSArray arrayWithObjects:
                            [UIImage imageNamed:@"VideoLoading-1"],
                            [UIImage imageNamed:@"VideoLoading-2"],
                            [UIImage imageNamed:@"VideoLoading-3"],
                            [UIImage imageNamed:@"VideoLoading-4"], nil];
        self.tag = 69;
        
        self.animationDuration = 2.0;
        self.animationRepeatCount = 0;
        [self startAnimating];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
