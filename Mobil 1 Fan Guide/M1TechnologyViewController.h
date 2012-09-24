//
//  M1TechnologyViewController.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/24/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M1TechnologyViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic) CGPoint carsTextOrigin;
@property (nonatomic) CGPoint driversTextOrigin;
@property (nonatomic) CGPoint driversOrigin;
@property (nonatomic) CGPoint fanFestTextOrigin;
@property (nonatomic) CGPoint trackTextOrigin;
@property (nonatomic) CGPoint trackOrigin;
@property (nonatomic) CGPoint tourOrigin;

@property (strong, nonatomic) IBOutlet UIScrollView *technologyScroller;
@property (strong, nonatomic) IBOutlet UIButton *carsText;
@property (strong, nonatomic) IBOutlet UIButton *driversText;
@property (strong, nonatomic) IBOutlet UIButton *driversButton;
@property (strong, nonatomic) IBOutlet UIButton *fanFestText;
@property (strong, nonatomic) IBOutlet UIButton *trackText;
@property (strong, nonatomic) IBOutlet UIButton *trackButton;
@property (strong, nonatomic) IBOutlet UIButton *tourButton;

@end