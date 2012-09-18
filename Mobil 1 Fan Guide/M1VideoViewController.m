//
//  M1VideoViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/14/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1VideoViewController.h"
#import "M1VideoLoadingView.h"
#import "LBYouTubePlayerViewController.h"
#import "LBYouTubePlayerController.h"

@interface M1VideoViewController ()

@end

@implementation M1VideoViewController

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _videoScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _videoScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"VideoThumbnailFrame"]];
    
    self.heroVideoView = [[LBYouTubePlayerViewController alloc] initWithYouTubeURL:[NSURL URLWithString:@"http://www.ilovetheory.com/apps/mobil1/f1/iphone/video/hero"]];
    self.heroVideoView.delegate = self;
    self.heroVideoView.quality = LBYouTubePlayerQualityLarge;
    self.heroVideoView.view.frame = CGRectMake(0.0f, 44.0f, 320.0f, 180.0f);
    [self.view addSubview:self.heroVideoView.view];
    
    [[(UIButton *)[_videoScrollView viewWithTag:1] imageView] setContentMode:UIViewContentModeScaleAspectFill];
    [(UIButton *)[_videoScrollView viewWithTag:1] setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/1/thumbnail"]]] forState:UIControlStateNormal];
    
    [[(UIButton *)[_videoScrollView viewWithTag:2] imageView] setContentMode:UIViewContentModeScaleAspectFill];
    [(UIButton *)[_videoScrollView viewWithTag:2] setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/2/thumbnail"]]] forState:UIControlStateNormal];

    [[(UIButton *)[_videoScrollView viewWithTag:3] imageView] setContentMode:UIViewContentModeScaleAspectFill];
    [(UIButton *)[_videoScrollView viewWithTag:3] setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/3/thumbnail"]]] forState:UIControlStateNormal];
    
    [[(UIButton *)[_videoScrollView viewWithTag:4] imageView] setContentMode:UIViewContentModeScaleAspectFill];
    [(UIButton *)[_videoScrollView viewWithTag:4] setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/4/thumbnail"]]] forState:UIControlStateNormal];
    
    if (!IS_IPHONE_5) {
        _videoScrollView.frame = CGRectMake(_videoScrollView.frame.origin.x, _videoScrollView.frame.origin.y, _videoScrollView.frame.size.width, 95);
        _videoScrollView.contentSize = CGSizeMake(582, 95);
    } else {
        _videoScrollView.contentSize = CGSizeMake(582, 184);
        
        [[(UIButton *)[_videoScrollView viewWithTag:5] imageView] setContentMode:UIViewContentModeScaleAspectFill];
        [(UIButton *)[_videoScrollView viewWithTag:5] setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/5/thumbnail"]]] forState:UIControlStateNormal];
        
        [[(UIButton *)[_videoScrollView viewWithTag:6] imageView] setContentMode:UIViewContentModeScaleAspectFill];
        [(UIButton *)[_videoScrollView viewWithTag:6] setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/6/thumbnail"]]] forState:UIControlStateNormal];
        
        [[(UIButton *)[_videoScrollView viewWithTag:7] imageView] setContentMode:UIViewContentModeScaleAspectFill];
        [(UIButton *)[_videoScrollView viewWithTag:7] setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/7/thumbnail"]]] forState:UIControlStateNormal];
        
        [[(UIButton *)[_videoScrollView viewWithTag:8] imageView] setContentMode:UIViewContentModeScaleAspectFill];
        [(UIButton *)[_videoScrollView viewWithTag:8] setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/8/thumbnail"]]] forState:UIControlStateNormal];
    }
    
    [_videoScrollView flashScrollIndicators];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[webView viewWithTag:69] removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)youTubePlayerViewController:(LBYouTubePlayerViewController *)controller didSuccessfullyExtractYouTubeURL:(NSURL *)videoURL {
    NSLog(@"Did extract video source:%@", videoURL);
}

-(void)youTubePlayerViewController:(LBYouTubePlayerViewController *)controller failedExtractingYouTubeURLWithError:(NSError *)error {
    NSLog(@"Failed loading %@ due to error:%@", controller.youTubeURL, error);
}

- (IBAction)videoThumbnailSelect:(id)sender {
    [self.heroVideoView.view removeFromSuperview];
    
    self.heroVideoView = [[LBYouTubePlayerViewController alloc] initWithYouTubeURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ilovetheory.com/apps/mobil1/f1/iphone/video/%i", [sender tag]]]];
    self.heroVideoView.delegate = self;
    self.heroVideoView.quality = LBYouTubePlayerQualityLarge;
    self.heroVideoView.view.autoplayOnLoad = YES;
    self.heroVideoView.view.frame = CGRectMake(0.0f, 44.0f, 320.0f, 180.0f);
    [self.view addSubview:self.heroVideoView.view];
}

@end
