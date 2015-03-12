//
//  MITSearchController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 5/11/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "MITSearchController.h"

#define msCellIdentifier @"edu.stanford.bioeng.endylab.BioBrickStudio.MITSearchSelectionCellIdentifier"

@implementation MITSearchController

@synthesize resultFeed;

- (id)init
{
	if (self = [super init])
	{
		_shouldDoAllSearch = NO;
	}
	
	return self;
}

- (void)setShouldDoAllSearch:(bool)decision
{
	if(decision)
	{
		_shouldDoAllSearch = decision;
	}
}
- (bool)shouldDoAllSearch
{
	return _shouldDoAllSearch;
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView 
{
 
}
*/

- (void)viewDidLoad 
{
	NSString				*documentsDirectory;
	NSString				*path;
	NSString				*urlString;
	NSError					*error;
	
	[super viewDidLoad]; 
	
	if(_searchBar)
	{
		[_searchBar setAutocorrectionType:UITextAutocorrectionTypeNo];
	}
	
	if([self shouldDoAllSearch])
	{
		[self executeSearchWithString:@""];
	}
	
	documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	path = [documentsDirectory stringByAppendingString:@"/mitsearchurl.txt"];
	urlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
	
	if(urlString)
	{
		[self fetchFeed:[NSURL URLWithString:urlString]];
	}
}

//- (void)viewDidAppear:(BOOL)animated
//{
//	[super viewDidAppear:animated];
//}

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

-(BiologicalPart *)convertEntryToPart:(GDataEntryGoogleBase *)entry
{
	BiologicalPart	*part;
	uint			value;
	NSString		*longDescription;
	
	part = [[BiologicalPart alloc] init];
	[part setIdentifier:[[entry title] stringValue]];
	[part setType:@"Pending"];
	
	value = [[[entry attributeWithName:@"size" type:@"int"] textValue] intValue];
	[part setSize:[NSNumber numberWithInt:value]];
	[part setShortDescription:[[entry content] stringValue]];
	longDescription = [[entry attributeWithName:@"long description" type:@"text"] textValue];
	
	if(longDescription && [longDescription length] > 0)
	{
		[part setLongDescription:longDescription];
	}
	
	return part;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
	[self executeSearchWithString:[searchBar text]];
}

-(void)executeSearchWithString:(NSString *)searchString
{
	NSString				*processedString;
	NSString				*queryString;
	NSString				*googleBaseSnippetsFeed;
	NSURL					*feedURL;
	GDataQueryGoogleBase	*query;
	GDataServiceGoogleBase	*service;
	
	processedString = [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	if([processedString length] > 0)
	{
		queryString = [NSString stringWithFormat:@"%@ [customer id : 5751624][item type : Standard biological part]-[item type : feature]", processedString];
		
	}
	else
	{
		queryString = @"[customer id : 5751624][item type : Standard biological part]-[item type : feature]";
	}
	
	googleBaseSnippetsFeed = kGDataGoogleBaseSnippetsFeed;	// "http://base.google.com/base/feeds/snippets";
	feedURL = [NSURL URLWithString:googleBaseSnippetsFeed];
	
	query = [GDataQueryGoogleBase googleBaseQueryWithFeedURL:feedURL];
	[query setGoogleBaseQuery:queryString];
	[query setStartIndex:1];
	[query setMaxResults:20];
	
	service = [self googleBaseService];
	[_activityIndicator setHidden:NO];
	[_activityIndicator startAnimating];
	
	[service fetchGoogleBaseQuery:query
						 delegate:self
				didFinishSelector:@selector(ticket:finishedWithObject:)
				  didFailSelector:@selector(ticket:failedWithError:)];
}

- (void)fetchFeed:(NSURL *)url
{
	GDataServiceGoogleBase	*service;
	
	if(url)
	{
		service = [self googleBaseService];
		[_activityIndicator setHidden:NO];
		[_activityIndicator startAnimating];
		[service fetchGoogleBaseFeedWithURL:url
								   delegate:self
						  didFinishSelector:@selector(ticket:finishedWithObject:)
							didFailSelector:@selector(ticket:failedWithError:)];
	}
}

- (void)ticket:(GDataServiceTicket *)ticket finishedWithObject:(GDataObject *)object 
{
	GDataFeedGoogleBase		*feed;
	NSString				*firstMember;
	NSString				*lastMember;
	NSString				*setSize;
	int						lastMemberIndex;
	UIAlertView				*alertView;
	
	if ([object isKindOfClass:[GDataEntryGoogleBase class]]) 
	{
		feed = [GDataFeedGoogleBase googleBaseFeed];
		[feed addEntry:(GDataEntryGoogleBase *) object];
		[self setResultFeed:feed];
	} 
	else 
	{
		feed = (GDataFeedGoogleBase *) object;
		[self setResultFeed:feed];
	}
	
	if([[feed entries] count] > 0)
	{
		firstMember = [[feed startIndex] stringValue];
		lastMemberIndex = [[feed startIndex] intValue] + [[feed entries] count] - 1;
		lastMember = [[NSNumber numberWithInt:lastMemberIndex] stringValue];
		setSize = [[feed totalResults] stringValue];
		[_indexButton setTitle:[NSString stringWithFormat:@"%@ - %@ of %@", firstMember, lastMember, setSize]];
		[_activityIndicator stopAnimating];
	}
	else
	{
		[_activityIndicator stopAnimating];
		
		alertView = [[UIAlertView alloc] initWithTitle:@"Search Result" 
											   message:@"No parts were found." 
											  delegate:nil 
									 cancelButtonTitle:@"OK" 
									 otherButtonTitles:nil];
		[alertView show];
		
		[_indexButton setTitle:@"0 Parts"];
	}
	
	[_resultTableView reloadData];
}

- (void)ticket:(GDataServiceTicket *)ticket failedWithError:(NSError *)error 
{
	UIAlertView		*alertView;
	
	[_activityIndicator stopAnimating];
	
	alertView = [[UIAlertView alloc] initWithTitle:@"Web Service Error" 
										   message:@"There was an error while retrieving data from the BioBrick Studio Web Service." 
										  delegate:nil 
								 cancelButtonTitle:@"OK" 
								 otherButtonTitles:nil];
	[alertView show];
	
	[_indexButton setTitle:@""];
}

- (GDataServiceGoogleBase *)googleBaseService 
{
	static GDataServiceGoogleBase* service = nil;
	
	if (!service) 
	{
		service = [[GDataServiceGoogleBase alloc] init];
		[service setUserAgent:@"Stanford-BioBrickStudio-1.0"]; // set this to yourName-appName-appVersion
		[service setShouldCacheDatedData:YES];
		[service setUserCredentialsWithUsername:nil password:nil];
	}
	
	return service;
}

-(IBAction)previous:(id)sender
{
	UIAlertView				*alertView;
	GDataServiceGoogleBase	*service;
	GDataLink				*link;
	
	service = [self googleBaseService];
	
	
	if([self resultFeed])
	{
		if(link = [[self resultFeed] previousLink])
		{
			[self fetchFeed:[link URL]];
		}
		else
		{
			alertView = [[UIAlertView alloc] initWithTitle:@"Previous" 
												   message:@"There is no previous set of parts." 
												  delegate:nil 
										 cancelButtonTitle:@"OK" 
										 otherButtonTitles:nil];
			[alertView show];
		}
	}
	else
	{
		alertView = [[UIAlertView alloc] initWithTitle:@"Web Service Error" 
											   message:@"There is an error in the data from the BioBrick Studio Web Service." 
											  delegate:nil 
									 cancelButtonTitle:@"OK" 
									 otherButtonTitles:nil];
		[alertView show];
	}
}

-(IBAction)next:(id)sender
{
	UIAlertView				*alertView;
	GDataServiceGoogleBase	*service;
	GDataLink				*link;
	
	service = [self googleBaseService];
	
	if([self resultFeed])
	{
		link = [[self resultFeed] nextLink];
		
		if(link)
		{
			[self fetchFeed:[link URL]];
		}
		else
		{
			alertView = [[UIAlertView alloc] initWithTitle:@"Next" 
												   message:@"There are no additional parts." 
												  delegate:nil 
										 cancelButtonTitle:@"OK" 
										 otherButtonTitles:nil];
			[alertView show];
		}
	}
	else
	{
		alertView = [[UIAlertView alloc] initWithTitle:@"Web Service Error" 
											   message:@"There is an error in the data from the BioBrick Studio Web Service." 
											  delegate:nil 
									 cancelButtonTitle:@"OK" 
									 otherButtonTitles:nil];
		[alertView show];
	}	
}

- (void)retrieveDNASequence;
{
	NSString			*urlString;
	NSURL				*url;
	NSXMLParser			*parser;
	UIAlertView			*alertView;
	NSString			*dasResponse;
	
	if(_part)
	{
		urlString = [NSString stringWithFormat:@"http://partsregistry.org/das/parts/dna/?segment=%@",[_part identifier]];
		url = [NSURL URLWithString:urlString];
		[_activityIndicator setHidden:NO];
		[_activityIndicator startAnimating];
		dasResponse = [NSString stringWithContentsOfURL:url];
		[_activityIndicator stopAnimating];
		
		if(dasResponse)
		{
			dasResponse = [dasResponse stringByReplacingOccurrencesOfString:@"\n" withString:@""];
			
			@try
			{
				parser = [NSXMLParser alloc];
				parser = [parser initWithData:[dasResponse dataUsingEncoding:NSUTF8StringEncoding]];
				[parser setDelegate:self];
				[parser parse];
			}
			@catch (NSException* exception) 
			{
				alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
													   message:@"There was an error while parsing the DNA sequence from the MIT Registry." 
													  delegate:nil 
											 cancelButtonTitle:@"OK" 
											 otherButtonTitles:nil];
				[alertView show];
			}
		}
		else
		{
			alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
												   message:@"There was an error while retrieving the DNA sequence from the MIT Registry." 
												  delegate:nil 
										 cancelButtonTitle:@"OK" 
										 otherButtonTitles:nil];
			[alertView show];
		}
	}
}

#pragma mark NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	_elementName = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	UIAlertView		*alertView;
	
	if([_elementName isEqualToString:@"DNA"])
	{
		if(_part && ![_part isDNASequenceValid])
		{
			if(string && [string length] > 0)
			{
				[_part setSequence:string];
			}
			else
			{
				alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
													   message:@"There was an error while processing the information from the Registry." 
													  delegate:nil 
											 cancelButtonTitle:@"OK" 
											 otherButtonTitles:nil];
				[alertView show];
			}
		}
	}
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark UITableView data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    uint rows;
	
	if(resultFeed)
	{
		rows = [[resultFeed entries] count];
	}
	else
	{
		rows = 0;
	}
	
	return rows;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	UITableViewCell			*cell;
	GDataEntryGoogleBase	*entry;
	
	cell = [tableView dequeueReusableCellWithIdentifier:msCellIdentifier];
	
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:msCellIdentifier] autorelease];
	}
	
	NSArray *entries = [resultFeed entries];
	
	entry = [entries objectAtIndex:[indexPath row]];
	[cell setText:[[entry content] stringValue]];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
  	PartInfoController		*controller;
	GDataEntryGoogleBase	*entry;
	UIAlertView				*alertView;
	
	entry = [[resultFeed entries] objectAtIndex:[indexPath row]];
	_part = [self convertEntryToPart:entry];
	[_part retain];
	[self retrieveDNASequence];
	
	if([_part isDNASequenceValid])
	{
		controller = [[PartInfoController alloc] initWithNibName:@"PartInfo" bundle:nil part:_part];
		[controller setTitle:[[entry title] stringValue]];
		[[self navigationController] pushViewController:[controller autorelease] animated:YES];
	}
	else
	{
		alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
											   message:@"The selected biological part has an invalid DNA sequence." 
											  delegate:nil 
									 cancelButtonTitle:@"OK" 
									 otherButtonTitles:nil];
		[alertView show];
	}
}


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
    GDataLink		*link;
	NSString		*urlString;
	NSString		*documentsDirectory;
	NSString		*path;
	
	if([self resultFeed])
	{
		link = [[self resultFeed] selfLink];
		urlString = [[link URL] absoluteString];
	
		documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		path = [documentsDirectory stringByAppendingString:@"/mitsearchurl.txt"];
		[urlString writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
	
	[super dealloc];
}

@end
