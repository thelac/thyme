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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createActivityBarButtonItem;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableViewCell;

@property (strong, nonatomic) NSMutableArray *activities;

@property (strong, nonatomic) Activity *activity;
@property (strong, nonatomic) EKEventStore *eventStore;

@end

@implementation ViewController
- (NSMutableArray *) activities {
    if (!_activities) {
        _activities = (NSMutableArray *)[Utilities getSettingsObject:@"activities"];
        
        if (!_activities) {
            _activities = [[NSMutableArray alloc] init];
        }
    }
    
    return _activities;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.createActivityBarButtonItem.target = self;
    self.createActivityBarButtonItem.action = @selector(createActivity);
    
    self.navigationController.delegate = self;
    self.eventStore = [[EKEventStore alloc] init];
    
    [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted) {
            NSLog(@"Hooray!");
        } else {
            NSLog(@"f u");
        }
    }];
}

- (void)createActivity {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"New Activity"
                          message:@"Type in the activity name"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK",
                          nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 12;
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 12) {
        if (buttonIndex == 1) {
            UITextField *textfield = [alertView textFieldAtIndex:0];
            NSLog(@"activity: %@", textfield.text);
            
            [self.activities addObject:textfield.text];
            [self.tableView reloadData];
            [Utilities setSettingsObject:self.activities forKey:@"activities"];
        }
    } else if (alertView.tag == 13) {
        if (buttonIndex == 1) {
            self.activity.end = [[NSDate alloc] init];
            
            EKEvent *event = [EKEvent eventWithEventStore:self.eventStore];

            NSArray *calendars = self.eventStore.calendars;
            
            for (int i = 0; i < [calendars count]; i++) {
                if ([((EKCalendar *)calendars[i]).title isEqualToString:@"Daniel Suo"]) {
                     event.calendar = (EKCalendar *)calendars[i];
                }
            }
            
            event.startDate = self.activity.start;
            event.endDate = self.activity.end;
            event.title = self.activity.label;
            
            NSError *err = nil;
            
            [self.eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
            
            NSLog(@"%@", self.activity.start);
            NSLog(@"%@", self.activity.end);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.activity = [[Activity alloc] init];
    self.activity.label = [self.activities objectAtIndex:indexPath.row];
    self.activity.start = [[NSDate alloc] init];
    
    NSLog(@"%@", self.activity.start);
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Stopwatch"
                          message:@"Hit OK when done with activity"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK",
                          nil];

    alert.tag = 13;
    
    [alert show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.activities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableIdentifier = @"tableCell";
    
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    cell.textLabel.text = [self.activities objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
