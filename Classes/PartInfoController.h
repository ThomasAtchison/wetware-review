//
//  PartInfoController.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 3/2/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiologicalPart.h"
#import "FeaturesController.h"
#import "CanvasController.h"
#import "DescriptionController.h"
#import "PaletteController.h"

@interface PartInfoController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	BiologicalPart			*_part;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil part:(BiologicalPart*)part;

-(void)displayFeatures;
-(void)displayDescription;
-(void)displaySequence;
-(void)openPartWebPage;
-(void)queryGoogleScholar;
-(void)saveToPalette;
-(void)emailPart;
-(void)edit;

@end
