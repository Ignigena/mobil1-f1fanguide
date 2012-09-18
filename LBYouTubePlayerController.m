//
//  LBYouTubePlayerController.m
//  LBYouTubeView
//
//  Created by Laurin Brandner on 29.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBYouTubePlayerController.h"

@interface LBYouTubePlayerController () 

@property (nonatomic, strong) LBYouTubeMoviePlayerController* controller;

-(void)_setup;

@end
@implementation LBYouTubePlayerController

@synthesize playButton = _playButton;
@synthesize autoplayOnLoad = _autoplayOnLoad;
@synthesize thumbnailFrame = _thumbnailFrame;
@synthesize controller;

#pragma mark Initialization

-(id)init {
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _setup];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _setup];
    }
    return self;
}

-(void)_setup {
    self.backgroundColor = [UIColor blackColor];
}

#pragma mark -
#pragma mark Other Methods

-(void)loadYouTubeVideo:(NSURL *)URL withID:(NSString *)id {
    if (self.controller) {
        [self.controller.view removeFromSuperview];
    }
    
    self.controller = [[MPMoviePlayerController alloc] initWithContentURL:URL];
    if (!self.autoplayOnLoad)
        [self.controller setShouldAutoplay:NO];
    [self.controller prepareToPlay];
    self.controller.view.frame = self.bounds;
    self.controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _thumbnailFrame = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg", id]]]]];
    _thumbnailFrame.contentMode = UIViewContentModeScaleAspectFill;
    _thumbnailFrame.frame = CGRectMake(0,0,self.controller.view.bounds.size.width,self.controller.view.bounds.size.height);
    _thumbnailFrame.clipsToBounds = YES;
    
    [self.controller.view addSubview: self.thumbnailFrame];
    
    if (self.autoplayOnLoad) self.thumbnailFrame.hidden = YES;
    
    _playButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.controller.view.bounds.size.width*.30,self.controller.view.bounds.size.width*.30)];
    [_playButton setImage:[UIImage imageNamed:@"VideoPlayButton"] forState:UIControlStateNormal];
    _playButton.center = self.controller.view.center;
    [_playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.controller.view addSubview: self.playButton];
    
    if (self.autoplayOnLoad) self.playButton.hidden = YES;
    
    [self addSubview:self.controller.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidFinishPlayback) name:@"MPMoviePlayerPlaybackDidFinishNotification" object:self];
}

- (void)printViewHierarchy:(UIView *)view
{
	if (view == nil)
		return;
    
	NSLog(@"%@", view);
    
	for (UIView *subview in [view subviews])
	{
		[self printViewHierarchy: subview];
	}
}

#pragma mark -

- (IBAction)play:(id)sender
{
    _thumbnailFrame.hidden = YES;
    _playButton.hidden = YES;
    [self.controller play];
}

- (void)playerDidFinishPlayback:(id)sender
{
    NSLog(@"playerDidFinishPlayback");
    _thumbnailFrame.hidden = NO;
    _playButton.hidden = NO;
}

@end
