//
//  CanvasPaletteController.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 6/3/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiologicalPart.h"
#import "PartInfoController.h"
 
@class CanvasController;


@interface CanvasPaletteController : UIViewController <UITableViewDelegate, UITableViewDataSource> 
{
	IBOutlet UITableView	*_tableView;
	
	NSMutableArray*			_parts;
}

- (IBAction)dismissPalette:(id)sender;

- (BiologicalPart *)convertToPart:(NSDictionary *)attributes;

@end
