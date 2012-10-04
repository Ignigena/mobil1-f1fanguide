//
//  M1WallpaperViewController.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 10/4/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol M1WallpaperViewDelegate;

@interface M1WallpaperView : UIView

@property (nonatomic, assign) CGFloat paddingTop;
@property (nonatomic, assign) id <M1WallpaperViewDelegate> delegate;

@end

@protocol M1WallpaperViewDelegate <NSObject>

- (void)didCaptureTouchOnPaddingRegion:(M1WallpaperView *)wallpaperView;

@end
