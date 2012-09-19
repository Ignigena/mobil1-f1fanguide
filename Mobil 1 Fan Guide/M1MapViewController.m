//
//  M1MapViewController.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/7/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1MapViewController.h"
#import "M1MapAnnotation.h"
#import "UIView+Origami.h"
#import "TileOverlay.h"
#import "TileOverlayView.h"

@interface M1MapViewController ()

@end

@implementation M1MapViewController

@synthesize mapView = _mapView;
@synthesize containerView = _containerView;

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Initialize the TileOverlay with tiles in the application's bundle's resource directory.
    // Any valid tiled image directory structure in there will do.
    _overlay = [[TileOverlay alloc] initWithTileDirectory:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Tiles"]];
    [_mapView addOverlay:self.overlay];
    
    // zoom in by a factor of two from the rect that contains the bounds
    // because MapKit always backs up to get to an integral zoom level so
    // we need to go in one so that we don't end up backed out beyond the
    // range of the TileOverlay.
    MKMapRect visibleRect = [_mapView mapRectThatFits:self.overlay.boundingMapRect];
    visibleRect.size.width /= 2;
    visibleRect.size.height /= 2;
    visibleRect.origin.x += visibleRect.size.width / 2;
    visibleRect.origin.y += visibleRect.size.height / 2;
    _mapView.visibleMapRect = visibleRect;
    
    NSLog(@"mapView visibleMapRect: %f %f %f %f", visibleRect.origin.x,visibleRect.origin.y, visibleRect.size.width,visibleRect.size.height);
    
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
            customPinView.image = [UIImage imageNamed:@"Turn1@2x.png"];
            
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
    
    return nil;
}

/*- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    
    M1MapOverlay *mapOverlay = (M1MapOverlay *)overlay;
    M1MapOverlayView *mapOverlayView = [[M1MapOverlayView alloc] initWithOverlay:mapOverlay];
    
    return mapOverlayView;
} */

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    TileOverlayView *view = [[TileOverlayView alloc] initWithOverlay:overlay];
    view.tileAlpha = 0.6;
    return view;
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
