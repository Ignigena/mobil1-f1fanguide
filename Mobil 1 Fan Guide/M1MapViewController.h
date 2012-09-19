//
//  M1MapViewController.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/7/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class TileOverlay;

@interface M1MapViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *mapScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *mapCanvas;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) TileOverlay *overlay;

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIView *infoView;

@property (nonatomic) BOOL infoDrawerOpen;

@end
