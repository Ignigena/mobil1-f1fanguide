//
//  NSString+RelativeDate.h
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/21/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RelativeDate)

+ (NSString *)formattedDateRelativeToNow:(NSDate *)date;

@end
