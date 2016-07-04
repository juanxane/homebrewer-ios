//
// UtilitiesViewController.m
// Homebrewer
//
// Created by Juan Cruz Ané on 1/7/16.
// Copyright © 2016 JuanxAne. All rights reserved.
//

#import "UtilitiesViewController.h"
#import "TemperatureConverterViewController.h"
#import "IBUSCalculatorViewController.h"

@interface UtilitiesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *items;

@end

@implementation UtilitiesViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = @"Utilidades";
	
	[self configureTableView];
}

- (void)configureTableView
{
	self.items = @[
		@{@"title" : @"Conversor de temperatura",
		  @"viewController" : [TemperatureConverterViewController class]},
		@{@"title" : @"Calculador de IBUs",
		  @"viewController" : [IBUSCalculatorViewController class]},

	];

	self.tableView.delegate = self;
	self.tableView.dataSource = self;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UtilityCell"];

	cell.textLabel.text = [[self.items objectAtIndex:indexPath.row] objectForKey:@"title"];

	return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIViewController *viewController = [[[[self.items objectAtIndex:indexPath.row] objectForKey:@"viewController"] alloc] init];

	[self.navigationController pushViewController:viewController animated:YES];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
