//
//  M1TechnologyViewController.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/24/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class M1WallpaperView, FDCurlViewControl;

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

@property (nonatomic) BOOL didHighlightWallpaper;
@property (nonatomic, retain) M1WallpaperView *wallpaperView;
@property (nonatomic, retain) FDCurlViewControl *curlButton;

- (IBAction)showTechInfo:(id)sender;
- (IBAction)showWallpapers:(id)sender;
- (void)performSegueWithSpoofedSenderTag:(int)tag;

@end
