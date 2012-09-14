//
//  M1MapViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/7/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1MapOverlay.h"
#import "M1MapOverlayView.h"
#import "M1MapViewController.h"
#import "M1MapAnnotation.h"
#import "UIView+Origami.h"

@interface M1MapViewController ()

@end

@implementation M1MapViewController

@synthesize mapView = _mapView;
@synthesize containerView = _containerView;

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
    
    [_mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(30.135,-97.63), MKCoordinateSpanMake(0.02,0.04)) animated:NO];
    M1MapOverlay *mapOverlay = [[M1MapOverlay alloc] init];
    [_mapView addOverlay:mapOverlay];
    _mapView.showsUserLocation = YES;
    
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13,-97.63) title:@"Mobil 1 Performance Zone" subtitle:@"Awesome Mobil 1 stuff!"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.14,-97.64) title:@"Render" subtitle:@"Sick!" image:[UIImage imageNamed:@"Render"]]];
}

- (IBAction)toggleInfoDrawer:(id)sender {
    if (!_infoDrawerOpen) {
        [self.containerView showOrigamiTransitionWith:self.infoView
                                 NumberOfFolds:2
                                      Duration:0.5
                                     Direction:XYOrigamiDirectionFromRight
                                    completion:nil];
        _infoDrawerOpen = YES;
    } else {
        [self.containerView hideOrigamiTransitionWith:self.infoView
                                        NumberOfFolds:2
                                             Duration:0.5
                                            Direction:XYOrigamiDirectionFromRight
                                           completion:nil];
        _infoDrawerOpen = NO;

    }
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if ([annotation isKindOfClass:[M1MapAnnotation class]]) {
        // try to dequeue an existing pin view first
        static NSString* M1AnnotationIdentifier = @"M1AnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:M1AnnotationIdentifier];
        if (!pinView) {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:M1AnnotationIdentifier];
            customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self action:@selector(toggleInfoDrawer:) forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    
    M1MapOverlay *mapOverlay = (M1MapOverlay *)overlay;
    M1MapOverlayView *mapOverlayView = [[M1MapOverlayView alloc] initWithOverlay:mapOverlay];
    
    return mapOverlayView;
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
