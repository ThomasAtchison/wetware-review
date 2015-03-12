//
//  PaletteController.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/15/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiologicalPart.h"
#import "PartInfoController.h"

enum BBSPartSaveStatus
{
	BBSPartSaved = 0,
	BBSPartSaveError,
	BBSPartPresent
};

@interface PaletteController : UITableViewController 
{
	IBOutlet UITableView	*_tableView;
	
	NSMutableArray*			_parts;
}

+ (enum BBSPartSaveStatus)savePart:(BiologicalPart *)part;
+ (uint)partCount;

- (BiologicalPart *)convertToPart:(NSDictionary *)attributes;

@end
