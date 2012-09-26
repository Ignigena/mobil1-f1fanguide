//
//  M1TechnologyStoryViewController.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/25/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M1TechnologyStoryViewController : UIViewController

- (void)toggleDriver:(UIBarButtonItem *)sender;

@property (strong, nonatomic) NSString *infoSectionContent;
@property (strong, nonatomic) IBOutlet UIWebView *infoSection;

@end