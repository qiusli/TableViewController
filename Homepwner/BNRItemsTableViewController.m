//
//  BNRItemsTableViewController.m
//  Homepwner
//
//  Created by Qiushi Li on 5/29/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import "BNRItemsTableViewController.h"
#import "BNRItem.h"
#import "BNRItemStore.h"
#import "BNRDetailViewController.h"

@interface BNRItemsTableViewController ()
@end

@implementation BNRItemsTableViewController

- (instancetype) initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (instancetype) init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        [navItem setTitle:@"HomePwner"];
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addNewItem:)];
        [navItem setRightBarButtonItem:bbi];
        [navItem setLeftBarButtonItem:self.editButtonItem];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)addNewItem:(id)sender {
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
//    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    BNRDetailViewController *dvc = [[BNRDetailViewController alloc] initWithNewItem:YES];
    dvc.item = newItem;
    
    dvc.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dvc];
    nav.modalPresentationStyle = UIModalPresentationPageSheet;
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:nav animated:YES completion:nil];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}
    
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    cell.textLabel.text = [item description];
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete && indexPath.row != [[[BNRItemStore sharedStore] allItems] count] - 1) {
        NSArray *allItems = [[BNRItemStore sharedStore] allItems];
        BNRItem *itemToDelete = allItems[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:itemToDelete];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[BNRItemStore sharedStore] moveItemFrom:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

-(NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BNRItem *selectedItem = [[[BNRItemStore sharedStore] allItems] objectAtIndex:indexPath.row];
    BNRDetailViewController *detailedView = [[BNRDetailViewController alloc] initWithNewItem:NO];
    detailedView.item = selectedItem;
    [self.navigationController pushViewController:detailedView animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

@end
