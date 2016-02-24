//
//  ViewController.m
//  Lesson2
//
//  Created by Azat Almeev on 26.09.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "MainTableViewController.h"
#import "LoadingTableViewController.h"

@implementation MainTableViewController

static NSString *loadingCellIdentifier = @"LoadingTableViewCellIdentifier";

- (NSMutableArray *)items {
    if (!_items)
        _items = [NSMutableArray new];
        return _items;
}


- (void)didLoadNewData:(NSArray *)items {
    self.isLoading = NO;
    NSInteger offset = self.items.count * 2;
    [self.items addObjectsFromArray:items];
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSInteger i = 0; i < items.count * 2; i++) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i + offset inSection:0];
        [indexPaths addObject:ip];
    }
    [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)didFailToLoadDataWithError:(NSError *)error {
    self.isLoading = NO;
    self.didFail = YES;
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"%@", error);
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    [self.tableView registerNib: [UINib nibWithNibName:@"LoadingTableViewCell" bundle:nil] forCellReuseIdentifier:loadingCellIdentifier];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 1 ? !self.didFail : 2 * self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *basicIdentifier = @"BaseCellIdentifier";
    static NSString *subtitleIdentifier = @"SubtitleCellIdentifier";
    
    if(self.items.count == 0) {
        return [tableView dequeueReusableCellWithIdentifier:@"LoadingTableViewCellIdentifier"];
    }
    
    if (indexPath.section == 1) {
        return [tableView dequeueReusableCellWithIdentifier:loadingCellIdentifier];
    }
    
    NSInteger index = indexPath.row / 2;
    
    if (indexPath.row %2 == 0) {
        UITableViewCell *basicCell = [tableView dequeueReusableCellWithIdentifier:basicIdentifier];
        basicCell.textLabel.text = [NSString stringWithFormat:@"%@", self.items[index]];
        return basicCell;
    }
    else {
            UITableViewCell *subtitleCell = [tableView dequeueReusableCellWithIdentifier:subtitleIdentifier];
            subtitleCell.textLabel.text = [NSString stringWithFormat:@"%@", self.items[index]];
        subtitleCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ subtitle", self.items[index]];
            return subtitleCell;
    }
    
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && !self.isLoading) {
        [self loadDataUsingLastID:self.items.lastObject];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row / 2;
    [self.items removeObjectAtIndex:index];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 * index inSection:0], [NSIndexPath indexPathForRow:2 * index + 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end
