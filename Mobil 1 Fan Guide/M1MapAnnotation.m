//
//  M1MapAnnotation.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/10/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1MapAnnotation.h"

@implementation M1MapAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

#pragma mark - Class Methods

+ (M1MapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)aCoordinate {
	return [self mapAnnotationWithCoordinate:aCoordinate title:nil subtitle:nil];
}


+ (M1MapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle {
	return [self mapAnnotationWithCoordinate:aCoordinate title:aTitle subtitle:nil];
}


+ (M1MapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle subtitle:(NSString *)aSubtitle {
	M1MapAnnotation *annotation = [[self alloc] init];
	annotation.coordinate = aCoordinate;
	annotation.title = aTitle;
	annotation.subtitle = aSubtitle;
	return annotation;
}

#pragma mark - Initializers

- (M1MapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate {
	return [self initWithCoordinate:aCoordinate title:nil subtitle:nil];
}


- (M1MapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle {
	return [self initWithCoordinate:aCoordinate title:aTitle subtitle:nil];
}


- (M1MapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle subtitle:(NSString *)aSubtitle {
	if ((self = [super init])) {
		self.coordinate = aCoordinate;
		self.title = aTitle;
		self.subtitle = aSubtitle;
	}
	return self;
}

@end
