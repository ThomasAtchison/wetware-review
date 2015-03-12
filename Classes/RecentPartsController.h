//
//  RecentPartsController.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/17/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiologicalPart.h"
#import "PartInfoController.h"


@interface RecentPartsController : UITableViewController 
{
	IBOutlet UISegmentedControl*			_segControl;
	IBOutlet UIBarButtonItem*				_moreButton;
	
	NSMutableArray*							_parts;
	uint									_count;
}

-(IBAction)getMoreParts:(id)sender;

@end
