//
//  ViewController.h
//  Lesson2
//
//  Created by Azat Almeev on 26.09.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewController : UITableViewController
@property (nonatomic) NSMutableArray *items;
@property BOOL isLoading;
@property BOOL didFail;

@end

