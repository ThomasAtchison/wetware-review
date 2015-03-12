//
//  CanvasController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/13/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "DescriptionController.h"

@implementation DescriptionController

-(void)awakeFromNib
{
	
}

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

- (void)viewDidLoad 
{
	NSString	*longDescription;
	
	[super viewDidLoad];
	
	if(_part)
	{	
		longDescription = [_part longDescription];
		
		if(longDescription && [longDescription length] > 0)
		{
			[_textView setText:longDescription];
		}
		else
		{
			[_textView setText:@"The long description is unavailable."];
		}
	}
	else
	{
		[_textView setText:@"The long description is unavailable."];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	return YES;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc 
{
    [super dealloc];
}

@end
