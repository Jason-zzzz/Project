//
//  PP2ViewController.m
//  FreeTravel
//
//  Created by Admin on 16/3/4.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "PP2ViewController.h"
#import "PPfirstCell.h"

@interface PP2ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PP2ViewController

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

static NSString *firstIdentifier;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    firstIdentifier = @"PPfirstCell";
    UINib *nib = [UINib nibWithNibName:firstIdentifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:firstIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPfirstCell *cell = [tableView dequeueReusableCellWithIdentifier:firstIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

@end
