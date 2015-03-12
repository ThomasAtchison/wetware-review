//
//  CanvasPaletteController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 6/3/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "CanvasPaletteController.h"

#define kCellIdentifier @"edu.stanford.bioeng.endylab.BioBrickStudio.CanvasPaletteTableSelectionCellIdentifier"

@implementation CanvasPaletteController

#pragma mark UIViewController delegate

- (void)viewWillAppear:(BOOL)animated
{	
	NSString			*documentsDirectory;
	NSString			*path;
	UIAlertView			*alertView;
	
	[super viewWillAppear:animated];
	
	documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	path = [documentsDirectory stringByAppendingString:@"/paletteparts.plist"];
	_parts = [NSMutableArray arrayWithContentsOfFile:path];
	
	if(_parts)
	{
		[_parts retain];
		[_tableView reloadData];
	}
	else
	{
		alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
											   message:@"There was an error while retrieving the Palette."
											  delegate:nil 
									 cancelButtonTitle:@"OK" 
									 otherButtonTitles:nil];
		[alertView show];
	}
}

- (BiologicalPart *)convertToPart:(NSDictionary *)attributes
{
	BiologicalPart	*part;
	
	if(attributes)
	{
		part = [[BiologicalPart alloc] initWithAttributes:attributes];
	}
	else
	{
		@throw [NSException exceptionWithName:@"Null Parameter" reason:@"Attributes is null." userInfo:nil];
	}
	
	return part;
}

- (IBAction)dismissPalette:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	return YES;
}

- (void)dealloc
{
	[super dealloc];
	[_parts dealloc];
}

#pragma mark UITableView delegate methods

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary			*attributes;
	BiologicalPart			*part;
	UIAlertView				*alertView;
	
	attributes = [_parts objectAtIndex:[indexPath row]];
	part = [[BiologicalPart alloc] initWithAttributes:attributes];
	
	if([CanvasController savePart:part])
	{
		[self dismissModalViewControllerAnimated:YES];
	}
	else
	{
		alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
											   message:@"There was an error while selecting a biological part for the Canvas."
											  delegate:nil 
									 cancelButtonTitle:@"OK" 
									 otherButtonTitles:nil];
		[alertView show];
	}
}

#pragma mark UITableView data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
	NSString	*sectionTitle;
	
	switch (section) 
	{
		case 0:
			sectionTitle = @"Available Biological Parts";
			break;
			
		default:
			break;
	}
	
    return sectionTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	uint rows;
	
	if(_parts)
	{
		rows = [_parts count];
	}
	else
	{
		rows = 0;
	}
	
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString			*shortDescription;
	UITableViewCell		*cell;
	
	cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kCellIdentifier] autorelease];
	}
	
	shortDescription = [[_parts objectAtIndex:[indexPath row]] valueForKey:@"shortDescription"];
	[cell setText:shortDescription];
	
	return cell;
}

@end

