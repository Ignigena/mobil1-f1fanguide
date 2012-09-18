//
//  LBYouTubePlayerController.h
//  LBYouTubeView
//
//  Created by Laurin Brandner on 29.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "LBYouTubeMoviePlayerController.h"

@interface LBYouTubePlayerController : UIView {
    LBYouTubeMoviePlayerController* controller;
    UIImageView *thumbnailFrame;
    UIButton *playButton;
    BOOL autoplayOnLoad;
}

@property (nonatomic, strong, readonly) MPMoviePlayerController* controller;
@property (nonatomic, strong, readonly) UIImageView* thumbnailFrame;
@property (nonatomic, strong, readonly) UIButton* playButton;
@property (nonatomic) BOOL autoplayOnLoad;

- (void)loadYouTubeVideo:(NSURL *)URL withID:(NSString *)id;
- (IBAction)play:(id)sender;
- (void)playerDidFinishPlayback:(id)sender;

@end
