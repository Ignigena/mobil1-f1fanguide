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

#define TRACK_RECT MKMapRectMake(61407232.000000, 110626923.789474, 20480.000000, 13653.333333)
#define FANFEST_RECT MKMapRectMake(61331819.915805, 110519799.982554, 3458.589826, 1948.501337)

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Show the user location
    _mapView.showsUserLocation = YES;
    
    // Zoom into the track by default
    _mapView.visibleMapRect = TRACK_RECT;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Initialize the TileOverlay with tiles in the application's bundle's resource directory.
    // Any valid tiled image directory structure in there will do.
    _overlay = [[TileOverlay alloc] initWithTileDirectory:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Tiles"]];
    [_mapView addOverlay:self.overlay];
    
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.265648,-97.745189) title:@"Austin Fan Fest" subtitle:@"powered by Mobil 1"]];
    
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.12977222222222,-97.63660833333336) title:@"Special" subtitle:@"Turn1"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13233573484781,-97.63761198869007) title:@"Special" subtitle:@"Turn2"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13356361461617,-97.6346674131745) title:@"Special" subtitle:@"Turn3"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13458838215721,-97.63490238090559) title:@"Special" subtitle:@"Turn4"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13467911184228,-97.63346055516335) title:@"Special" subtitle:@"Turn5"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13638394840469,-97.63310829826139) title:@"Special" subtitle:@"Turn6"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13547267446125,-97.63101198623896) title:@"Special" subtitle:@"Turn7"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13691570806554,-97.62978529588254) title:@"Special" subtitle:@"Turn8"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13596881217982,-97.62911229372683) title:@"Special" subtitle:@"Turn9"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.1363268456492,-97.62680851763956) title:@"Special" subtitle:@"Turn10"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.1395776645105,-97.62412635515734) title:@"Special" subtitle:@"Turn11"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13744980455283,-97.63704347396823) title:@"Special" subtitle:@"Turn12"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13551483703974,-97.63518258892344) title:@"Special" subtitle:@"Turn13"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13534723393265,-97.63655008510861) title:@"Special" subtitle:@"Turn14"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13682357038325,-97.63772219896754) title:@"Special" subtitle:@"Turn15"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13441318061477,-97.63658127921968) title:@"Special" subtitle:@"Turn16"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13400909497561,-97.63767320660379) title:@"Special" subtitle:@"Turn17"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13343838057951,-97.638699153847) title:@"Special" subtitle:@"Turn18"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13573458257057,-97.64067696007579) title:@"Special" subtitle:@"Turn19"]];
    [_mapView addAnnotation:[[M1MapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(30.13445816227009,-97.6439224122243) title:@"Special" subtitle:@"Turn20"]];
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
    
    NSLog(@"%f - %f - %f - %f", [self.mapView visibleMapRect].origin.x, [self.mapView visibleMapRect].origin.y, [self.mapView visibleMapRect].size.width, [self.mapView visibleMapRect].size.height);
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
            
            if (annotation.title == @"Special") {
                customPinView.image = [UIImage imageNamed:annotation.subtitle];
            } else {
                customPinView.pinColor = MKPinAnnotationColorPurple;
                customPinView.animatesDrop = YES;
                customPinView.canShowCallout = YES;
            }
            
            return customPinView;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    TileOverlayView *view = [[TileOverlayView alloc] initWithOverlay:overlay];
    view.tileAlpha = 0.6;
    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleMapView:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        // User selected "Track"
        [_mapView setVisibleMapRect:TRACK_RECT animated:YES];
    } else {
        // User selected "Fan Fest"
        [_mapView setVisibleMapRect:FANFEST_RECT animated:YES];
    }
}

@end
