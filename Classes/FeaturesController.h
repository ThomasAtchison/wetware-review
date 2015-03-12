//
//  FeaturesController.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/15/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiologicalPart.h"
#import "Feature.h"

@interface FeaturesController : UITableViewController 
{
	NSMutableArray*		features;
	BiologicalPart*		part;
	
	Feature*			_feature;
}

@property(readwrite,assign)NSMutableArray* features;
@property(readwrite, assign)BiologicalPart* part;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil part:(BiologicalPart*)BiologicalPart;

@end
