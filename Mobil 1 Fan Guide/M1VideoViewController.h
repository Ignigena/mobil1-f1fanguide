//
//  M1VideoViewController.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/14/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBYouTubePlayerViewController.h"


@interface M1VideoViewController : UIViewController <LBYouTubePlayerControllerDelegate>

@property (strong, nonatomic) LBYouTubePlayerViewController *heroVideoView;
@property (strong, nonatomic) IBOutlet UIScrollView *videoScrollView;

- (IBAction)videoThumbnailSelect:(id)sender;

@end
