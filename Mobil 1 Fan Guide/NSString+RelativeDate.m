//
//  NSString+RelativeDate.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/21/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "NSString+RelativeDate.h"

@implementation NSString (RelativeDate)

+ (NSString *)formattedDateRelativeToNow:(NSDate *)date
{
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
	[mdf setDateFormat:@"yyyy-MM-dd"];
	NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:date]];
    
	NSInteger dayDiff = (int)[midnight timeIntervalSinceNow] / (60*60*24);
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if(dayDiff >= 365)
        [dateFormatter setDateFormat:@"MMM d',' YYYY"];
    else if(dayDiff >= 2)
        [dateFormatter setDateFormat:@"MMM d',' h:mma"];
    else if(dayDiff == 1)
		[dateFormatter setDateFormat:@"'Tomorrow,' h:mma"];
	else if(dayDiff == 0)
		[dateFormatter setDateFormat:@"'Today,' h:mma"];
	else if(dayDiff == -1)
		[dateFormatter setDateFormat:@"'Yesterday'"];
	else if(dayDiff == -2)
		[dateFormatter setDateFormat:@"'Two days ago'"];
	else if(dayDiff > -14 && dayDiff <= -7)
		[dateFormatter setDateFormat:@"'Last week'"];
    else if(dayDiff > -30 && dayDiff < -14)
		[dateFormatter setDateFormat:@"'Two weeks ago'"];
	else if(dayDiff > -60 && dayDiff <= -30)
		[dateFormatter setDateFormat:@"'Last month'"];
	else if(dayDiff <= -60)
		[dateFormatter setDateFormat:@"MMM d',' YYYY"];
    
	return [dateFormatter stringFromDate:date];
}

@end
