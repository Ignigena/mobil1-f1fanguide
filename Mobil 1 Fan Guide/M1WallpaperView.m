//
//  M1WallpaperViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 10/4/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1WallpaperView.h"
#import "AGMedallionView.h"
#import "M1TechnologyViewController.h"

static CGFloat const kOffset = 10.0f;

@implementation M1WallpaperView

@synthesize paddingTop = _paddingTop;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	CGFloat height = self.paddingTop;
	
	
	NSString *text = NSLocalizedString(@"Explore Technology to Unlock Wallpapers!", nil);
	UIFont *textFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
	CGRect textRect = CGRectMake(kOffset, height + kOffset, CGRectGetWidth(self.frame) - 2 * kOffset, MAXFLOAT);
	CGSize textSize = [text sizeWithFont:textFont
					   constrainedToSize:textRect.size
						   lineBreakMode:NSLineBreakByWordWrapping];
	textRect.size.height = textSize.height;
	[text drawInRect:textRect
			withFont:textFont
	   lineBreakMode:NSLineBreakByWordWrapping
		   alignment:NSTextAlignmentCenter];
    
    UITapGestureRecognizer *singleTapCar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unlockWallpaper:)];
    [singleTapCar setNumberOfTapsRequired:1];
	
    AGMedallionView *wallpaperCar = [[AGMedallionView alloc] initWithFrame:CGRectMake(kOffset-20, height+35, 90, 90)];
    wallpaperCar.image = [UIImage imageNamed:@"Wallpaper-Car-Thumb"];
    wallpaperCar.borderWidth = wallpaperCar.borderWidth/2;
    wallpaperCar.tag = 1;
    
    [wallpaperCar addGestureRecognizer:singleTapCar];
    
    UITapGestureRecognizer *singleTapDrivers = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unlockWallpaper:)];
    [singleTapDrivers setNumberOfTapsRequired:1];
    
    AGMedallionView *wallpaperDrivers = [[AGMedallionView alloc] initWithFrame:CGRectMake(kOffset+42, height+35, 90, 90)];
    wallpaperDrivers.image = [UIImage imageNamed:@"Wallpaper-Drivers-Thumb"];
    wallpaperDrivers.borderWidth = wallpaperCar.borderWidth;
    wallpaperDrivers.tag = 2;
    
    [wallpaperDrivers addGestureRecognizer:singleTapDrivers];
    
    UITapGestureRecognizer *singleTapFanFest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unlockWallpaper:)];
    [singleTapFanFest setNumberOfTapsRequired:1];
    
    AGMedallionView *wallpaperFanFest = [[AGMedallionView alloc] initWithFrame:CGRectMake(kOffset+104, height+35, 90, 90)];
    wallpaperFanFest.image = [UIImage imageNamed:@"Wallpaper-FanFest-Thumb"];
    wallpaperFanFest.borderWidth = wallpaperCar.borderWidth;
    wallpaperFanFest.tag = 3;
    
    [wallpaperFanFest addGestureRecognizer:singleTapFanFest];
    
    UITapGestureRecognizer *singleTapTrack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unlockWallpaper:)];
    [singleTapTrack setNumberOfTapsRequired:1];
    
    AGMedallionView *wallpaperTrack = [[AGMedallionView alloc] initWithFrame:CGRectMake(kOffset+166, height+35, 90, 90)];
    wallpaperTrack.image = [UIImage imageNamed:@"Wallpaper-Track-Thumb"];
    wallpaperTrack.borderWidth = wallpaperCar.borderWidth;
    wallpaperTrack.tag = 4;
    
    [wallpaperTrack addGestureRecognizer:singleTapTrack];
    
    UITapGestureRecognizer *singleTapTour = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unlockWallpaper:)];
    [singleTapTour setNumberOfTapsRequired:1];
    
    AGMedallionView *wallpaperTour = [[AGMedallionView alloc] initWithFrame:CGRectMake(kOffset+228, height+35, 90, 90)];
    wallpaperTour.image = [UIImage imageNamed:@"Wallpaper-Tour-Thumb"];
    wallpaperTour.borderWidth = wallpaperCar.borderWidth;
    wallpaperTour.tag = 5;
    
    [wallpaperTour addGestureRecognizer:singleTapTour];
    
    [self addSubview:wallpaperCar];
    [self addSubview:wallpaperDrivers];
    [self addSubview:wallpaperFanFest];
    [self addSubview:wallpaperTrack];
    [self addSubview:wallpaperTour];
    
	height = CGRectGetMaxY(textRect);
}

- (void)unlockWallpaper:(UITapGestureRecognizer *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sectionToUnlock;
    
    if (sender.view.tag == 1) { sectionToUnlock = @"MP4-27"; }
    else if (sender.view.tag == 2) { sectionToUnlock = @"Drivers"; }
    else if (sender.view.tag == 3) { sectionToUnlock = @"Fan Fest"; }
    else if (sender.view.tag == 4) { sectionToUnlock = @"Track"; }
    else if (sender.view.tag == 5) { sectionToUnlock = @"Tour"; }
    
    if ([defaults objectForKey:[NSString stringWithFormat:@"Wallpaper%i", sender.view.tag]]) {
        if ([sectionToUnlock isEqualToString:@"MP4-27"]) { sectionToUnlock = @"Car"; }
        UIImageWriteToSavedPhotosAlbum([UIImage imageNamed:[NSString stringWithFormat:@"Wallpaper-%@", [sectionToUnlock stringByReplacingOccurrencesOfString:@" " withString:@""]]], self, nil, nil);
        
        UIAlertView *unlockStatus = [[UIAlertView alloc] initWithTitle:@"Wallpaper Unlocked" message:@"Congratulations! This wallpaper has been saved to your camera roll. From there you can set this image as your lock screen or wallpaper." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [unlockStatus show];
    } else {
        UIAlertView *unlockStatus = [[UIAlertView alloc] initWithTitle:@"Wallpaper Locked" message:[NSString stringWithFormat:@"In order to unlock this wallpaper, read the %@ section in the Technology tab.", sectionToUnlock] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [unlockStatus show];
        
        if ([self.delegate respondsToSelector:@selector(didCaptureTouchOnPaddingRegion:)])
            [self.delegate didCaptureTouchOnPaddingRegion:self];
    }
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	for (UITouch *touch in touches) {
		CGPoint point = [touch locationInView:self];
		if (point.y < self.paddingTop) {
			if ([self.delegate respondsToSelector:@selector(didCaptureTouchOnPaddingRegion:)]) {
				[self.delegate didCaptureTouchOnPaddingRegion:self];
			}
		}
	}
}

@end
