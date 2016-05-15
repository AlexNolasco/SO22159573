//
//  SampleTableViewController.m
//  inheritance
//
//  Created by alexander nolasco on 5/14/16.
//  Copyright © 2016 coladapp.com. All rights reserved.
//

#import "SampleTableViewController.h"
// Model
#import "SWGGameTouchEventModel.h"
#import "SWGGameFooEventModel.h"
// Cells
#import "GameTouchViewCell.h"
#import "GameFooViewCell.h"

@interface SampleTableViewController ()
@property (nonatomic, strong) NSArray<SWGGameEventModel *>* eventModels;
@end

@implementation SampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self registerCell: @"GameTouchViewCell"];
    [self registerCell: @"GameFooViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerCell: (NSString *)cellName
{
    UINib *nib = [UINib nibWithNibName:cellName bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:cellName];
}

- (NSArray<SWGGameEventModel *>*) eventModels
{
    if (_eventModels == nil) {
        _eventModels = [self loadEventsFromJsonString:[self getJson]];
    }
    return _eventModels;
}

#pragma mark - 
- (NSArray<SWGGameEventModel *>*) loadEventsFromJsonString: (NSString *)jsonString
{
    NSError * error;
    NSArray<SWGGameEventModel *>* result = [SWGGameEventModel arrayOfModelsFromString:jsonString error:&error];
    
    for (SWGGameEventModel * model in result) {
        NSLog(@"%@\n%@", NSStringFromClass([model class]), [model description]);
    }
    return result;
}

- (NSString *) getJson
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"example" ofType:@"json"];
    NSError * error;
    
    NSString * result = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    return result;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self eventModels] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWGGameEventModel * eventModel = [[self eventModels] objectAtIndex:[indexPath row]];
    if ([eventModel isKindOfClass:[SWGGameTouchEventModel class]]) {
        GameTouchViewCell * touchCell = [[self tableView] dequeueReusableCellWithIdentifier:@"GameTouchViewCell"];
        return touchCell;
    } else if ([eventModel isKindOfClass:[SWGGameFooEventModel class]]) {
        GameFooViewCell * fooCell = [[self tableView] dequeueReusableCellWithIdentifier:@"GameFooViewCell"];
        return fooCell;
    } else {
        return nil;
    }
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[GameTouchViewCell class]]){
        SWGGameTouchEventModel * model = (SWGGameTouchEventModel *) [[self eventModels] objectAtIndex:[indexPath row]];
        GameTouchViewCell * touchCell = ((GameTouchViewCell*)cell);
        
        NSString * text = [NSString stringWithFormat:@"%@ , %@", [[model point] x], [[model point] y]];
        [[touchCell pointsLabel] setText:text];
        
    } else if ([cell isKindOfClass:[GameFooViewCell class]]) {
        SWGGameFooEventModel * model = (SWGGameFooEventModel *) [[self eventModels] objectAtIndex:[indexPath row]];
        GameFooViewCell * fooCell = ((GameFooViewCell*)cell);
        
        NSString * text = [NSString stringWithFormat:@"%@", [model name]];
        [[fooCell nameLabel] setText:text];
    }
}

@end
