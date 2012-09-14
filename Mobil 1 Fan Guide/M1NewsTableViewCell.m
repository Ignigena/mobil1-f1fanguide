//
//  M1NewsTableViewCell.m
//  Mobil 1 Fan Guide
//
//  Created by Albert Martin on 9/14/12.
//  Copyright (c) 2012 Albert Martin. All rights reserved.
//

#import "M1NewsTableViewCell.h"

@implementation M1NewsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"init");
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableGradient"]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)contentView
{
    UIView *view = [super contentView];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableGradient"]];
    return view;
}

@end
