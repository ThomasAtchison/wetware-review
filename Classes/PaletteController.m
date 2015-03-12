//
//  PaletteController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/15/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "PaletteController.h"

#define kCellIdentifier @"edu.stanford.bioeng.endylab.BioBrickStudio.PaletteTableSelectionCellIdentifier"

@implementation PaletteController

+ (enum BBSPartSaveStatus)savePart:(BiologicalPart *)part
{
	NSMutableArray			*paletteParts;
	NSString				*documentsDirectory;
	NSString				*path;
	NSDictionary			*partAttributes;
	BOOL					newPart;
	enum BBSPartSaveStatus	status;
	
	documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	path = [documentsDirectory stringByAppendingString:@"/paletteparts.plist"];
	
	if(paletteParts = [NSMutableArray arrayWithContentsOfFile:path])
	{
		newPart = YES;
		
		for(partAttributes in paletteParts)
		{
			if([[part identifier] isEqualToString:[partAttributes objectForKey:@"identifier"]])
			{
				newPart = NO;
				break;
			}
		}
		
		if(newPart)
		{
			[paletteParts addObject:[part attributes]];
			
			if([paletteParts writeToFile:path atomically:YES])
			{
				status = BBSPartSaved;
			}
			else
			{
				status = BBSPartSaveError;
				[paletteParts removeLastObject];
			}
		}
		else
		{
			status = BBSPartPresent;
		}
	}
	else
	{	paletteParts = [NSMutableArray arrayWithCapacity:1];
		[paletteParts addObject:[part attributes]];
		
		if([paletteParts writeToFile:path atomically:YES])
		{
			status = BBSPartSaved;
		}
		else
		{
			status = BBSPartSaveError;
		}	
	}
	
	return status;
}

+ (uint)partCount
{
	NSMutableArray			*paletteParts;
	NSString				*documentsDirectory;
	NSString				*path;
	uint					count;
	
	documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	path = [documentsDirectory stringByAppendingString:@"/paletteparts.plist"];
	
	if(paletteParts = [NSMutableArray arrayWithContentsOfFile:path])
	{
		count = [paletteParts count];
	}
	else
	{	
		count = 0;
	}
	
	return count;	
}

#pragma mark UIViewController delegate

//- (void)loadView
//{
//	[super loadView];
//}

- (void)viewDidLoad 
{
    [super viewDidLoad];
	
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	[self setTitle:@"Palette"];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//	
//}

- (void)viewWillAppear:(BOOL)animated
{	
	NSString			*documentsDirectory;
	NSString			*path;
	UIAlertView			*alertView;
	
	[super viewWillAppear:animated];
	
	// make sure we remove the current selection in the table view
	NSIndexPath *tableSelection = [[self tableView] indexPathForSelectedRow];
	[[self tableView] deselectRowAtIndexPath:tableSelection animated:NO];
	
	//	// Set the navbar style to its default color for the list view.
	//	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	//	// Set the status bar to its default color for the list view.
	//	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
	
	documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	path = [documentsDirectory stringByAppendingString:@"/paletteparts.plist"];
	
	if(_parts)
	{
		_parts = [[_parts initWithContentsOfFile:path] retain];
	}
	else
	{
		_parts = [[NSMutableArray arrayWithContentsOfFile:path] retain];
	}
	
	if(_parts && [_parts count] > 0)
	{
		[[self tableView] reloadData];
	}
	else
	{
		alertView = [[UIAlertView alloc] initWithTitle:@"Palette" 
											   message:@"You have no parts in your palette." 
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

#pragma mark UITableView delegate methods

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  	PartInfoController		*controller;
	NSDictionary			*attributes;
	BiologicalPart			*part;
	
	attributes = [_parts objectAtIndex:[indexPath row]];
	part = [[BiologicalPart alloc] initWithAttributes:attributes];
	controller = [[PartInfoController alloc] initWithNibName:@"PartInfo" bundle:nil part:part];
	[controller setTitle:[part identifier]];
	[controller setHidesBottomBarWhenPushed:YES];
	[[self navigationController] pushViewController:[controller autorelease] animated:YES];
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSString			*documentsDirectory;
	NSString			*path;
	UIAlertView			*alertView;
	NSDictionary		*part;
	
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		part = [_parts objectAtIndex:[indexPath row]];
		[_parts removeObjectAtIndex:[indexPath row]];
		documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		path = [documentsDirectory stringByAppendingString:@"/paletteparts.plist"];
		
		if([_parts writeToFile:path atomically:YES])
		{
			[_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		}
		else
		{
			alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
												   message:[NSString stringWithFormat:@"There was an error while deleting biological part %@.", [part objectForKey:@"identifier"]]
												  delegate:nil 
										 cancelButtonTitle:@"OK" 
										 otherButtonTitles:nil];
			[alertView show];
			[_parts insertObject:part atIndex:[indexPath row]];
		}
    }
}

#pragma mark UITableView data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	return YES;
}

- (void)dealloc
{
	[super dealloc];
	[_parts dealloc];
}

@end

