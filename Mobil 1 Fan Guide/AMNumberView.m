//
//  AMNumberView.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "AMNumberView.h"

@implementation AMNumberView
@synthesize title = _title;
@synthesize fontSize = _fontSize;
@synthesize backColor = _backColor;
@synthesize titleColor = _titleColor;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor colorWithWhite:0.8 alpha:1.000]];
        [self setFontSize:50.];
    }
    return self;
}

+ (id)tickViewWithTitle:(NSString *)title fontSize:(CGFloat)fontSize {
    AMNumberView *view = [[AMNumberView alloc] initWithFrame:CGRectZero];
    [view setTitle:title];
    [view setFontSize:fontSize];
    return view;
}
- (void)drawRect:(CGRect)rect {
    //UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 1., 1.)
    //[self.backColor set];
    //[path fill];
    
    [[UIImage imageNamed:@"TickerBackground"] drawInRect:self.frame];
    
    [self.titleColor set];
    [self.title drawInRect:CGRectMake(self.bounds.origin.x,self.bounds.origin.y-1,self.bounds.size.width,self.bounds.size.height) withFont:[UIFont fontWithName:@"Novecentowide-DemiBold" size:_fontSize]
             lineBreakMode:NSLineBreakByClipping
                 alignment:NSTextAlignmentCenter];
    
    UIBezierPath *line = [UIBezierPath bezierPath];
    [[UIColor blackColor] setStroke];
    line.lineWidth = 0.5;
    [line moveToPoint:CGPointMake(2, round((self.bounds.size.height / 2))+1 )];
    [line addLineToPoint:CGPointMake(self.bounds.size.width-2, round((self.bounds.size.height / 2))+1)];
    [line closePath];
    [line stroke];
}

@end
