//
//  ViewController.m
//  Thyme
//
//  Created by Daniel Suo on 8/20/14.
//  Copyright (c) 2014 The Leather Apron Club. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createChunkBarButtonItem;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableViewCell;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableIdentifier = @"tableCell";
    
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    cell.textLabel.text = @"test";
    
    return cell;
}

@end
