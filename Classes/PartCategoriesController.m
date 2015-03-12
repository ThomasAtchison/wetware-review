//
//  PartCategoriesController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 3/17/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "PartCategoriesController.h"

#define kCellIdentifier @"edu.stanford.bioeng.endylab.BioBrickStudio.PartCategorySelectionCellIdentifier"

@implementation PartCategoriesController

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

-(void)awakeFromNib
{	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;	
}

- (void)viewDidLoad
{	
	NSURL*					url;
	UIAlertView*			alertView;
	NSXMLParser*			parser;
	
	[super viewDidLoad];
	_parts = [[NSMutableArray alloc] init];
	url = [[NSURL alloc] initWithString:@"http://partsregistry.org/das/parts/favorites/index.cgi"];
	parser = [NSXMLParser alloc];
	
	@try
	{
		parser = [parser initWithContentsOfURL:url];
		[parser setDelegate:self];
		[parser parse];
		[_parts sortUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"shortDescription" ascending:YES]]];
	}
	@catch (NSException* exception) 
	{		
		alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
											   message:@"There was an error while gathering the information from the Registry." 
											  delegate:nil 
									 cancelButtonTitle:@"OK" 
									 otherButtonTitles:nil];
		[alertView show];
	}
}

- (void)viewWillAppear:(BOOL)animated
{	
	NSIndexPath*	tableSelection;
	
	// make sure we remove the current selection in the table view
	tableSelection = [[self tableView] indexPathForSelectedRow];
	[[self tableView] deselectRowAtIndexPath:tableSelection animated:NO];
	
	//	// Set the navbar style to its default color for the list view.
	//	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	//	// Set the status bar to its default color for the list view.
	//	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

-(IBAction)getMoreParts:(id)sender
{
	UIAlertView*	alertView;
	
	alertView = [[UIAlertView alloc] initWithTitle:@"Under Development" 
										   message:@"This functionality is under development." 
										  delegate:nil 
								 cancelButtonTitle:@"OK" 
								 otherButtonTitles:nil];
	[alertView show];
}

-(IBAction)switchPartsList:(id)sender
{
	UIAlertView*	alertView;
	
	alertView = [[UIAlertView alloc] initWithTitle:@"Under Development" 
										   message:@"This functionality is under development." 
										  delegate:nil 
								 cancelButtonTitle:@"OK" 
								 otherButtonTitles:nil];
	[alertView show];
}

#pragma mark UITableView delegate methods

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	PartInfoController*	controller;
	
	controller = [[PartInfoController alloc] initWithNibName:@"PartInfo" bundle:nil part:[_parts objectAtIndex:[indexPath row]]];
	[controller setTitle:[[_parts objectAtIndex:[indexPath row]] identifier]];
	[[self navigationController] pushViewController:[controller autorelease] animated:YES];
}

#pragma mark UITableView data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_parts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell*	cell;
	NSString*			text;
	
	cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kCellIdentifier] autorelease];
	}
	
	text = [[_parts objectAtIndex:[indexPath row]] shortDescription];
	[cell setText:text];
	
	return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	return YES;
}

#pragma mark NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{	
	BiologicalPart*	part;
	
	if([elementName caseInsensitiveCompare:@"SEGMENT"] == NSOrderedSame)
	{
		part = [[BiologicalPart alloc] init];
		[part setIdentifier:[attributeDict valueForKey:@"id"]];
		[part setShortDescription:[[attributeDict valueForKey:@"short_desc"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
		[part setLongDescription:[NSString stringWithFormat:@"Long description for %@.",[attributeDict valueForKey:@"id"] ]];
		[_parts addObject:part];
		[part release];
	}
}

- (void)dealloc
{
	[_parts dealloc];
	[super dealloc];
}


@end

