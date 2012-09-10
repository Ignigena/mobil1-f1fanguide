//
//  AMCountdownBar.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/7/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "AMCountdownBar.h"

@implementation AMCountdownBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    int i = 0;
    for (UIView *view in self.subviews) {
        NSLog(@"%i. %@", i++, [view description]);
        if ([view isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            view.frame = CGRectMake(0, 0, 100, 200);
        }
    }
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
