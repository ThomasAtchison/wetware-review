//
//  CanvasPartInfoController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 5/30/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "CanvasPartInfoController.h"

#define kCellIdentifier @"edu.stanford.bioeng.endylab.BioBrickStudio.CanvasPartInfoSelectionCellIdentifier"

@implementation CanvasPartInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil part:(BiologicalPart*)part
{	
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{		
		if(part)
		{
			_part = part;
		}
	}
	
	return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView 
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	NSMutableString		*partInfo;
	
    [super viewDidLoad];
	
	if(_part)
	{
		partInfo = [NSMutableString stringWithString:@"Biological Part Information\n\n"];
		[partInfo appendString:[NSString stringWithFormat:@"Identifier: %@\n\n", [_part identifier]]];
		[partInfo appendString:[NSString stringWithFormat:@"Short Description: %@\n\n", [_part shortDescription]]];
		[partInfo appendString:[NSString stringWithFormat:@"Size: %@ bp\n\n", [[_part size] stringValue]]];
		[partInfo appendString:[NSString stringWithFormat:@"Long Description:\n%@\n\n", [_part longDescription]]];
		[_textView setText:partInfo];
	}
}


// Override to allow orientations other than the default portrait orientation.
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
			decision = YES;
			break;
			
		case UIInterfaceOrientationLandscapeRight:
			decision = YES;
			break;
			
		default:
			break;
	}
	
	return decision;
}

-(IBAction)dismissView:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning 
{
     // Releases the view if it doesn't have a superview
	[super didReceiveMemoryWarning];
	
    // Release anything that's not essential, such as cached data
}

- (void)dealloc 
{
    [super dealloc];
}


@end
