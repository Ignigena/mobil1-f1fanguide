//
//  M1TechnologyViewController.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/24/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M1TechnologyViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic) CGPoint driversOrigin;

@property (strong, nonatomic) IBOutlet UIScrollView *technologyScroller;
@property (strong, nonatomic) IBOutlet UIButton *driversButton;

@end
