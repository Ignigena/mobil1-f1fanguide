//
//  M1AppDelegate.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/6/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAPush.h"
#import "AMCountdownModel.h"

@interface M1AppDelegate : UIResponder <UIApplicationDelegate, UAPushNotificationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
