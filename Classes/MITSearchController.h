//
//  MITSearchController.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 5/11/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataGoogleBase.h"
#import "BiologicalPart.h"
#import "PartInfoController.h"

@interface MITSearchController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
{
	IBOutlet UISearchBar				*_searchBar;
	IBOutlet UITableView				*_resultTableView;
	IBOutlet UIBarButtonItem			*_indexButton;
	IBOutlet UIActivityIndicatorView	*_activityIndicator;
	
	GDataFeedGoogleBase					*resultFeed;
	NSString							*_elementName;
	BiologicalPart						*_part;
	bool								_shouldDoAllSearch;
}

@property(readwrite, retain)GDataFeedGoogleBase *resultFeed;

- (IBAction)next:(id)sender;
- (IBAction)previous:(id)sender;

- (void)executeSearchWithString:(NSString *)searchString;
- (void)fetchFeed:(NSURL *)url;
- (BiologicalPart *)convertEntryToPart:(GDataEntryGoogleBase *)entry;
- (GDataServiceGoogleBase *)googleBaseService;
- (void)setShouldDoAllSearch:(bool)decision;
- (bool)shouldDoAllSearch;
- (void)retrieveDNASequence;

@end
