//
//  M1VideoViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/14/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1VideoViewController.h"
#import "M1VideoLoadingView.h"

@interface M1VideoViewController ()

@end

@implementation M1VideoViewController

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
    
    _videoScrollView.contentSize = CGSizeMake(582, 184);
    _videoScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _videoScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"VideoThumbnailFrame"]];
    
    [_heroVideoView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/hero"]]];
    [_heroVideoView addSubview:[[M1VideoLoadingView alloc] initWithFrame:CGRectMake(145, 80, 30, 19)]];
    
    [(UIWebView *)[_videoScrollView viewWithTag:1]  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/1"]]];
    [[_videoScrollView viewWithTag:1]  addSubview:[[M1VideoLoadingView alloc] initWithFrame:CGRectMake(47, 25, 30, 19)]];
    
    [(UIWebView *)[_videoScrollView viewWithTag:2] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/2"]]];
    [[_videoScrollView viewWithTag:2] addSubview:[[M1VideoLoadingView alloc] initWithFrame:CGRectMake(47, 25, 30, 19)]];
    
    [(UIWebView *)[_videoScrollView viewWithTag:3] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/3"]]];
    [[_videoScrollView viewWithTag:3] addSubview:[[M1VideoLoadingView alloc] initWithFrame:CGRectMake(47, 25, 30, 19)]];
    
    [(UIWebView *)[_videoScrollView viewWithTag:4] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/4"]]];
    [[_videoScrollView viewWithTag:4] addSubview:[[M1VideoLoadingView alloc] initWithFrame:CGRectMake(47, 25, 30, 19)]];
    
    [(UIWebView *)[_videoScrollView viewWithTag:5] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/5"]]];
    [[_videoScrollView viewWithTag:5] addSubview:[[M1VideoLoadingView alloc] initWithFrame:CGRectMake(47, 25, 30, 19)]];
    
    [(UIWebView *)[_videoScrollView viewWithTag:6] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/6"]]];
    [[_videoScrollView viewWithTag:6] addSubview:[[M1VideoLoadingView alloc] initWithFrame:CGRectMake(47, 25, 30, 19)]];
    
    [(UIWebView *)[_videoScrollView viewWithTag:7] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/7"]]];
    [[_videoScrollView viewWithTag:7] addSubview:[[M1VideoLoadingView alloc] initWithFrame:CGRectMake(47, 25, 30, 19)]];
    
    [(UIWebView *)[_videoScrollView viewWithTag:8] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ilovetheory.com/apps/mobil1/f1/iphone/video/8"]]];
    [[_videoScrollView viewWithTag:8] addSubview:[[M1VideoLoadingView alloc] initWithFrame:CGRectMake(47, 25, 30, 19)]];
    
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

@end
