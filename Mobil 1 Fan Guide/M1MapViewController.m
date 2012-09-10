//
//  M1MapViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/7/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1MapViewController.h"

@interface M1MapViewController ()

@end

@implementation M1MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _mapScrollView.contentSize = _mapCanvas.frame.size;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    
    float minimumZoomScale = 480  / _mapCanvas.frame.size.width;
    _mapScrollView.minimumZoomScale = minimumZoomScale;
    [_mapScrollView setZoomScale: minimumZoomScale];
    
    [_mapScrollView addGestureRecognizer:doubleTap];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _mapCanvas;
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = _mapScrollView.frame.size.height / scale;
    zoomRect.size.width  = _mapScrollView.frame.size.width / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    if (_mapScrollView.zoomScale > _mapScrollView.minimumZoomScale) {
        CGRect zoomRect = [self zoomRectForScale:_mapScrollView.minimumZoomScale withCenter:CGPointMake(0, 0)];
        [_mapScrollView zoomToRect:zoomRect animated:YES];
    } else {
        float newScale = [_mapScrollView zoomScale] * 2.5;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [_mapScrollView zoomToRect:zoomRect animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
