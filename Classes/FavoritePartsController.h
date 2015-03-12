//
//  FavoritePartsController.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 3/17/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiologicalPart.h"
#import "PartInfoController.h"

@interface FavoritePartsController : UITableViewController 
{
	IBOutlet UIBarButtonItem*				_moreButton;
	
	NSMutableArray*							_parts;
	uint									_count;
}

-(IBAction)getMoreParts:(id)sender;

@end
