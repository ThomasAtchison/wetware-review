//
//  LibraryController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 3/17/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "LibraryController.h"

#define kCellIdentifier @"edu.stanford.bioeng.endylab.BioBrickStudio.LibraryCellIdentifier"

@implementation LibraryController

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
	 
	[self setTitle:@"Library"];
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
			decision = NO;
			break;
			
		case UIInterfaceOrientationLandscapeRight:
			decision = NO;
			break;
			
		default:
			break;
	}
	
	return decision;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	uint rows;
	
	switch (section) 
	{
		case 0:
			rows = 2;
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
	
	switch ([indexPath row]) 
	{
		case 0:
			[cell setText:@"Search for Parts"];
			break;
			
		case 1:
			[cell setText:@"All Parts"];
			break;
			
		default:
			break;
	}
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	MITSearchController			*mitSearchController;
	
	switch ([indexPath row]) 
	{
		case 0:
			mitSearchController = [[MITSearchController alloc] initWithNibName:@"PartsSearch" bundle:nil];
			[mitSearchController setTitle:@"Registry of Parts"];
			[mitSearchController setHidesBottomBarWhenPushed:YES];
			[self.navigationController pushViewController:[mitSearchController autorelease] animated:YES];
			break;
			
		case 1:
			mitSearchController = [[MITSearchController alloc] initWithNibName:@"PartsList" bundle:nil];
			[mitSearchController setShouldDoAllSearch:YES];
			[mitSearchController setTitle:@"Registry of Parts"];
			[mitSearchController setHidesBottomBarWhenPushed:YES];
			[self.navigationController pushViewController:[mitSearchController autorelease] animated:YES];
			break;
		
		default:
			break;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
	NSString	*sectionTitle;
	
	switch (section) 
	{
		case 0:
			sectionTitle = @"Registry of Parts (MIT)";
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
//	[_libraryItems dealloc];
}


@end

