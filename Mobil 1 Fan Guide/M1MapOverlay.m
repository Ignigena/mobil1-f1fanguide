//
//  M1MapOverlay.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/10/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1MapOverlay.h"

@implementation M1MapOverlay

-(CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(48.85883, 2.2945);
}

- (MKMapRect)boundingMapRect
{
    
    MKMapPoint upperLeft   = MKMapPointForCoordinate(CLLocationCoordinate2DMake(30.1495, -97.6484));
    MKMapPoint upperRight  = MKMapPointForCoordinate(CLLocationCoordinate2DMake(30.1471, -97.6134));
    MKMapPoint bottomLeft  = MKMapPointForCoordinate(CLLocationCoordinate2DMake(30.1217, -97.6484));
    
    MKMapRect bounds = MKMapRectMake(upperLeft.x, upperLeft.y, fabs(upperLeft.x - upperRight.x), fabs(upperLeft.y - bottomLeft.y));
    
    return bounds;
}

@end
