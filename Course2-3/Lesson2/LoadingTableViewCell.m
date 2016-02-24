//
//  LoadingTableViewCell.m
//  Lesson2
//
//  Created by Ри on 24.02.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "LoadingTableViewCell.h"

@implementation LoadingTableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[self viewWithTag:1];
    [indicator startAnimating];
}

@end
