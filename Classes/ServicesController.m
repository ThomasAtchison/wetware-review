//
//  ServicesController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 5/15/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "ServicesController.h"

#define kCellIdentifier @"edu.stanford.bioeng.endylab.BioBrickStudio.ServicesCellIdentifier"

@implementation ServicesController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{	
//	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
//	{		
//		
//	}
//		
//	return self;
//}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad 
 {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	 
	[self setTitle:@"Services"];
}

/*
- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return YES;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
//{
//	return UITableViewCellAccessoryDisclosureIndicator;
//}

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
			rows = 1;
			break;
			
		default:
			break;
	}
	
    return rows;
}

// Customize the appearance of table view cells.
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
				[cell setText:@"Home Page"];
				break;
			case 1:
				[cell setText:@"Technical Standards RFCs"];
				break;
			case 2:
				[cell setText:@"Join Today!"];
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
				[cell setText:@"Home Page"];
				break;
				
			case 1:
				[cell setText:@"Want to stop cloning?"];
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
				[cell setText:@"BioBrick Assembly Kit"];
				break;
				
			default:
				break;
		}
	}
			
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSURL			*url;
	
	if([indexPath indexAtPosition:0] == 0)
	{
		switch ([indexPath row]) 
		{
			case 0:
				url = [NSURL URLWithString:@"http://bbf.openwetware.org"];
				[[UIApplication sharedApplication] openURL:url];
				break;
				
			case 1:
				url = [NSURL URLWithString:@"http://bbf.openwetware.org/RFC.html"];
				[[UIApplication sharedApplication] openURL:url];
				break;
				
			case 2:
				url = [NSURL URLWithString:@"http://bbf.openwetware.org/Membership.html"];
				[[UIApplication sharedApplication] openURL:url];
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
				url = [NSURL URLWithString:@"http://ginkgobioworks.com"];
				[[UIApplication sharedApplication] openURL:url];
				break;
		
			case 1:
				url = [NSURL URLWithString:@"http://ginkgobioworks.com/cgi/mobilecontact.cgi?to=info&subject=I%20want%20to%20stop%20cloning"];
				[[UIApplication sharedApplication] openURL:url];
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
				url = [NSURL URLWithString:@"http://www.neb.com/nebecomm/products/productE0546.asp"];
				[[UIApplication sharedApplication] openURL:url];
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
			sectionTitle = @"BioBricks Foundation";
			break;
			
		case 1:
			sectionTitle = @"ginkgobioworks";
			break;
			
		case 2:
			sectionTitle = @"New England BioLabs";
			break;
			
		default:
			break;
	}
	
    return sectionTitle;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
//{
//    return [NSArray arrayWithObjects:@"A",@"G",@"M",@"J",nil];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index 
//{
//	uint	sectionTitle;
//	
//	if([title isEqualToString:@"A"])
//	{
//		sectionTitle = 0;
//	}
//	   
//	if([title isEqualToString:@"G"])
//	{
//		sectionTitle = 1;
//	}
//	   
//	if([title isEqualToString:@"M"])
//	{
//		sectionTitle = 2;
//	}
//	
//	if([title isEqualToString:@"J"])
//	{
//		sectionTitle = 3;
//	}
//	
//    return sectionTitle;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc 
{
    [super dealloc];
}


@end

