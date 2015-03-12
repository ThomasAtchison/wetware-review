//
//  FeaturesController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/15/09.
//  Copyright 2009 Stanford University. All rights reserved.

#import "FeaturesController.h"

#define kCellIdentifier @"edu.stanford.bioeng.endylab.BioBrickStudio.FeatureSelectionCellIdentifier"

@implementation FeaturesController

@synthesize features;
@synthesize part;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil part:(BiologicalPart*)BiologicalPart
{
	NSString*		urlString;
	NSURL*			url;
	NSXMLParser*	parser;
	
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{		
		part = BiologicalPart;
		features = [[NSMutableArray alloc] init];
		
		urlString = [NSString stringWithFormat:@"http://partsregistry.org/das/parts/features/?segment=%@",[part identifier]];
		url = [[NSURL alloc] initWithString:urlString];
		
		@try
		{
			parser = [NSXMLParser alloc];
			parser = [parser initWithContentsOfURL:url];
			[parser setDelegate:self];
			[parser parse];
		}
		@catch (NSException* exception) 
		{
			
		}
	}
	
	return self;
}

//-(void)awakeFromNib
//{
//
//}

//-(void)setPart:(BiologicalPart*)part
//{
//	if(part)
//	{
//		_part = part;
//	}
//}

-(void)viewDidLoad
{	

}

#pragma mark UIViewController delegate

- (void)viewWillAppear:(BOOL)animated
{	
	// make sure we remove the current selection in the table view
	NSIndexPath *tableSelection = [[self tableView] indexPathForSelectedRow];
	[[self tableView] deselectRowAtIndexPath:tableSelection animated:NO];
	
	//	// Set the navbar style to its default color for the list view.
	//	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	//	// Set the status bar to its default color for the list view.
	//	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

#pragma mark UITableView delegate methods

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//	UIViewController *targetViewController = [menuList objectAtIndex: indexPath.row];
	//	[[self navigationController] pushViewController:targetViewController animated:YES];
}

#pragma mark UITableView data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [features count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kCellIdentifier] autorelease];
	}
	
	[cell setText:[[features objectAtIndex:[indexPath row]] label]];
	
	return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	return YES;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{	
	NSString*	value;
	
	if([elementName caseInsensitiveCompare:@"FEATURE"] == NSOrderedSame)
	{
		_feature = [[Feature alloc] init];
		
		value = [attributeDict valueForKey:@"id"];
		
		if(value && [value length] > 0)
		{
			[_feature setFeatureID:value];
		}
		else
		{
			[_feature setFeatureID:@""];
		}
		
		value = [attributeDict valueForKey:@"label"];
		
		if(value && [value length] > 0)
		{
			[_feature setLabel:value];
		}
		else
		{
			[_feature setLabel:@"No Label"];
		}
		
		[features addObject:_feature];
	}
}

- (void)dealloc
{
	[features dealloc];
	[super dealloc];
}

@end

