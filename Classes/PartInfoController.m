//
//  PartInfoController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 3/2/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "PartInfoController.h"

#define kCellIdentifier @"edu.stanford.bioeng.endylab.BioBrickStudio.PartInfoSelectionCellIdentifier"

@implementation PartInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil part:(BiologicalPart*)part
{	
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{		
		if(part)
		{
			_part = part;
		}
	}
	
	return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView 
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	BOOL decision;
	
	switch (interfaceOrientation) 
	{
		case UIInterfaceOrientationPortrait:
			decision = YES;
			break;
			
		case UIInterfaceOrientationPortraitUpsideDown:
			decision = YES;
			break;
			
		case UIInterfaceOrientationLandscapeLeft:
			decision = YES;
			break;
			
		case UIInterfaceOrientationLandscapeRight:
			decision = YES;
			break;
			
		default:
			break;
	}
	
	return decision;
}

- (void)didReceiveMemoryWarning 
{
     // Releases the view if it doesn't have a superview
	[super didReceiveMemoryWarning];
	
    // Release anything that's not essential, such as cached data
}

-(void)displayDescription
{
	DescriptionController	*controller;
	
	controller = [[DescriptionController alloc] initWithNibName:@"Description" bundle:nil part:_part];
	[controller setTitle:@"Description"];
	[controller setHidesBottomBarWhenPushed:YES];
	[[self navigationController] pushViewController:[controller autorelease] animated:YES];
}

-(void)openPartWebPage
{
	NSURL* url;
	
	url = [NSURL URLWithString:[NSString stringWithFormat:@"http://partsregistry.org/wiki/index.php?title=Part:%@",[_part identifier]]];
	[[UIApplication sharedApplication] openURL:url];
}

-(void)queryGoogleScholar
{
	NSURL* url;
	
	url = [NSURL URLWithString:[NSString stringWithFormat:@"http://scholar.google.com/scholar?hl=en&lr=&q=%@&btnG=Search",[_part identifier]]];
	[[UIApplication sharedApplication] openURL:url];
}

-(void)displayFeatures
{
	FeaturesController*	controller;
	
	controller = [[FeaturesController alloc] initWithNibName:@"Features" bundle:nil part:_part];
	[controller setTitle:@"Features"];
	[[self navigationController] pushViewController:controller animated:YES];
}

-(void)displaySequence
{
	CanvasController	*controller;
	UIAlertView			*alertView;
	
	if([_part isDNASequenceValid])
	{
		controller = [[CanvasController alloc] initWithNibName:@"Canvas" bundle:nil part:_part];
		[controller setTitle:[_part identifier]];
		[[self navigationController] pushViewController:controller animated:YES];
	}
	else 
	{
		alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
											   message:[NSString stringWithFormat:@"Part %@ has an invalid DNA sequence.", [_part identifier]] 
											  delegate:nil 
									 cancelButtonTitle:@"OK" 
									 otherButtonTitles:nil];
		[alertView show];
	}
}

-(void)saveToPalette
{
	enum BBSPartSaveStatus	status;
	UIAlertView				*alertView;
	
	status = [PaletteController savePart:_part];
	
	switch (status) 
	{
		case BBSPartSaved:
			alertView = [[UIAlertView alloc] initWithTitle:@"Palette" 
												   message:[NSString stringWithFormat:@"Part %@ was saved to the palette.", [_part identifier]] 
												  delegate:nil 
										 cancelButtonTitle:@"OK" 
										 otherButtonTitles:nil];
			[alertView show];
			break;
			
		case BBSPartPresent:
			alertView = [[UIAlertView alloc] initWithTitle:@"Palette" 
												   message:[NSString stringWithFormat:@"Part %@ is already in your palette.", [_part identifier]] 
												  delegate:nil 
										 cancelButtonTitle:@"OK" 
										 otherButtonTitles:nil];
			[alertView show];
			break;
			
		case BBSPartSaveError:
			alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
												   message:[NSString stringWithFormat:@"There was an error while trying to save part %@ to the palette.", [_part identifier]] 
												  delegate:nil 
										 cancelButtonTitle:@"OK" 
										 otherButtonTitles:nil];
			[alertView show];
			break;
			
		default:
			break;
	}	
}

-(void)edit
{
	UIAlertView*	alertView;
	
	alertView = [[UIAlertView alloc] initWithTitle:@"Under Development" 
										   message:@"The \"Edit\" function is under development." 
										  delegate:nil 
								 cancelButtonTitle:@"OK" 
								 otherButtonTitles:nil];
	[alertView show];
}

-(void)emailPart
{
	NSMutableString		*emailString;
	NSURL				*url;
	UIAlertView			*alertView;
	
//	@"mailto:?subject=Greetings%20from%20Cupertino!&body=Wish%20you%20were%20here!"
	
	emailString = [NSMutableString stringWithString:@"mailto:?subject="];
	[emailString appendString:[NSString stringWithFormat:@"Biological Part: %@", [_part identifier]]];
	[emailString appendString:@"&body="];
	[emailString appendString:@"Check out this biological part that I found using BioBrick Studio Mobile...\n\n"];
	[emailString appendString:[NSString stringWithFormat:@"Identifier: %@\n\n", [_part identifier]]];
	[emailString appendString:[NSString stringWithFormat:@"Short Description: %@\n\n", [_part shortDescription]]];
	[emailString appendString:[NSString stringWithFormat:@"Size: %@ bp\n\n", [[_part size] stringValue]]];
	[emailString appendString:[NSString stringWithFormat:@"Long Description:\n%@\n\n", [_part longDescription]]];
	
	if([_part isDNASequenceValid])
	{
		[emailString appendString:[NSString stringWithFormat:@"DNA Sequence:\n%@", [_part sequence]]];
	}
	
	url = [NSURL URLWithString:[emailString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	if([[UIApplication sharedApplication] openURL:url] == NO)
	{
		alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
											   message:@"There was an error while attempting to open the Mail application." 
											  delegate:nil 
									 cancelButtonTitle:@"OK" 
									 otherButtonTitles:nil];
		[alertView show];
	}
}

#pragma mark TableView Methods

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	int accessoryType;
	
	if([indexPath indexAtPosition:0] == 0)
	{
		switch ([indexPath row]) 
		{
			case 0:
				accessoryType = UITableViewCellAccessoryNone;
				break;
			case 1:
				accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				break;
			case 2:
				accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				break;
			default:
				break;
		}
	}
	
	if([indexPath indexAtPosition:0] == 1)
	{
		switch ([indexPath row]) 
		{
			case 0:
				accessoryType = UITableViewCellAccessoryNone;
				break;
			case 1:
				accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				break;
			default:
				break;
		}
	}
	
	if([indexPath indexAtPosition:0] == 2)
	{
		switch ([indexPath row]) 
		{
			case 0:
				accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				break;
			case 1:
				accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				break;
			default:
				break;
		}
	}
	
	return accessoryType;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	uint rows;
	
	switch (section) 
	{
		case 0:
			rows = 3;
			break;
			
		case 1:
			rows = 2;
			break;
			
		case 2:
			rows = 2;
			break;
			
		default:
			break;
	}
	
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell*	cell;
	
	cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kCellIdentifier] autorelease];
	}
	
	if([indexPath indexAtPosition:0] == 0)
	{
		switch ([indexPath row]) 
		{
			case 0:
				[cell setText:[_part shortDescription]];
				break;
			case 1:
				[cell setText:[NSString stringWithFormat:@"%@ bp",[[_part size] stringValue]]];
				break;
			case 2:
				[cell setText:@"Long Description"];
				break;
			default:
				break;
		}
	}
	
	if([indexPath indexAtPosition:0] == 2)
	{
		switch ([indexPath row]) 
		{
			case 0:
				[cell setText:@"Registry Web Page"];
				break;
			case 1:
				[cell setText:@"Search Google Scholar"];
				break;
			default:
				break;
		}
	}
	
	if([indexPath indexAtPosition:0] == 1)
	{
		switch ([indexPath row]) 
		{
			case 0:
				[cell setText:@"Save to Palette"];
				break;
			case 1:
				[cell setText:@"Email Part"];
				break;
			default:
				break;
		}
	}
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if([indexPath indexAtPosition:0] == 0)
	{
		switch ([indexPath row]) 
		{
			case 1:
				[self displaySequence];
				break;
			case 2:
				[self displayDescription];
				break;
				
			default:
				break;
		}
	}
	
	if([indexPath indexAtPosition:0] == 2)
	{
		switch ([indexPath row]) 
		{
			case 0:
				[self openPartWebPage];
				break;
			case 1:
				[self queryGoogleScholar];
				break;
			default:
				break;
		}
	}
	
	if([indexPath indexAtPosition:0] == 1)
	{
		switch ([indexPath indexAtPosition:1]) 
		{
			case 0:
				[self saveToPalette];
				break;
			case 1:
				[self emailPart];
				break;
			default:
				break;
		}
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
	NSString	*sectionTitle;
	
	switch (section) 
	{
		case 0:
			sectionTitle = @"Basic Information";
			break;
			
		case 2:
			sectionTitle = @"Web-based Resources";
			break;
			
		case 1:
			sectionTitle = @"Actions";
			break;
			
		default:
			break;
	}
	
    return sectionTitle;
}

- (void)dealloc 
{
    [super dealloc];
}


@end
