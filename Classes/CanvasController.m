//
//  CanvasController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/13/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "CanvasController.h"


@implementation CanvasController

+(BOOL)savePart:(BiologicalPart *)part
{
	NSString		*documentsDirectory;
	NSString		*path;
	NSDictionary	*attributes;
	BOOL			result;
	
	if(part)
	{
		documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		path = [documentsDirectory stringByAppendingString:@"/canvaspart.plist"];
		attributes = [part attributes];
		
		if([attributes writeToFile:path atomically:YES])
		{
			result = YES;
		}
		else 
		{
			result = NO;
		}
		
	}
	else
	{
		result = NO;
	}
	
	return result;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil part:(BiologicalPart*)part
{	
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{		
		if(part)
		{
			if(![CanvasController savePart:part])
			{
				@throw [NSException exceptionWithName:@"Error" reason:[NSString stringWithFormat:@"Error while attempting to save biological part %@.", [part identifier]] userInfo:nil];
			}
		}
	}
	
	return self;
}

//- (void)viewDidLoad 
//{
//	[super viewDidLoad];
//}

- (void)viewWillAppear:(BOOL)animated
{
	UIAlertView		*alertView;
	NSDictionary	*attributes;
	NSString		*documentsDirectory;
	NSString		*path;
	
	[super viewWillAppear:animated];
	
	
	documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	path = [documentsDirectory stringByAppendingString:@"/canvaspart.plist"];
	attributes = [NSDictionary dictionaryWithContentsOfFile:path];
		
	if(attributes)
	{
		_part = [[[BiologicalPart alloc] initWithAttributes:attributes] retain];
		[self showSequence];
	}
	else
	{		
		if([PaletteController partCount] > 0)
		{
			[_partIDButton setTitle:@"" forState:UIControlStateNormal];
			[_partIDButton setHidden:YES];
			
			alertView = [[UIAlertView alloc] initWithTitle:@"Select a Part" 
												   message:@"Please select a part to display on the canvas." 
												  delegate:nil 
										 cancelButtonTitle:@"OK" 
										 otherButtonTitles:nil];
			[alertView show];
			
			[_toolbar setHidden:NO];
		}
		else
		{
			[_partIDButton setTitle:@"" forState:UIControlStateNormal];
			[_partIDButton setHidden:YES];
			
			alertView = [[UIAlertView alloc] initWithTitle:@"Palette" 
												   message:@"You have no parts in your palette for display on the canvas." 
												  delegate:nil 
										 cancelButtonTitle:@"OK" 
										 otherButtonTitles:nil];
			[alertView show];	
		}
	}
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//	NSString		*documentsDirectory;
//	NSString		*path;
//	NSDictionary	*attributes;
//	
//	[super viewWillDisappear:animated];
//	
//	if(_part)
//	{
//		documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//		path = [documentsDirectory stringByAppendingString:@"/canvaspart.plist"];
//		attributes = [_part attributes];
//		[attributes writeToFile:path atomically:YES];
//	}
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	return YES;
}

- (void)showSequence
{
	NSString		*htmlTemplatePath;
	NSString		*htmlTemplate;
	NSError			*error;
	NSString		*htmlString;
	UIAlertView		*alertView;
	
	if(_part)
	{
		if([[_wrapButton title] isEqualToString:@"Wrap"])
		{
			if([_part isDNASequenceValid])
			{
				//Place more checks for errors
				htmlTemplatePath = [[NSBundle mainBundle] pathForResource:@"SequenceTemplate" ofType:@"html"];
				htmlTemplate = [NSString stringWithContentsOfFile:htmlTemplatePath encoding:NSUTF8StringEncoding error:&error];
				htmlString = [htmlTemplate stringByReplacingOccurrencesOfString:@"sequence" withString:[_part sequence]];
				[_webView loadHTMLString:htmlString baseURL:nil];
				[_partIDButton setTitle:[_part identifier] forState:UIControlStateNormal];
				[_partIDButton setHidden:NO];
			}
			else
			{
				[_partIDButton setTitle:@"" forState:UIControlStateNormal];
				[_partIDButton setHidden:YES];
		
				alertView = [[UIAlertView alloc] initWithTitle:@"Invalid DNA Sequence" 
													   message:[NSString stringWithFormat:@"The DNA sequence of biological part %@ is invalid and can not be displayed.", [_part identifier]] 
													  delegate:nil 
											 cancelButtonTitle:@"OK" 
											 otherButtonTitles:nil];
				[alertView show];
			}
		}
		else
		{
			if([_part isDNASequenceValid])
			{
				//Place more checks for errors
				htmlTemplatePath = [[NSBundle mainBundle] pathForResource:@"SequenceTemplate.wrap" ofType:@"html"];
				htmlTemplate = [NSString stringWithContentsOfFile:htmlTemplatePath encoding:NSUTF8StringEncoding error:&error];
				htmlString = [htmlTemplate stringByReplacingOccurrencesOfString:@"sequence" withString:[_part sequence]];
				[_webView loadHTMLString:htmlString baseURL:nil];
				[_partIDButton setTitle:[_part identifier] forState:UIControlStateNormal];
				[_partIDButton setHidden:NO];
			}
			else
			{
				[_partIDButton setTitle:@"" forState:UIControlStateNormal];
				[_partIDButton setHidden:YES];
				
				alertView = [[UIAlertView alloc] initWithTitle:@"Invalid DNA Sequence" 
													   message:[NSString stringWithFormat:@"The DNA sequence of biological part %@ is invalid and can not be displayed.", [_part identifier]] 
													  delegate:nil 
											 cancelButtonTitle:@"OK" 
											 otherButtonTitles:nil];
				[alertView show];
			}
		}
	}
}

- (IBAction)showToolbar:(id)sender
{
	[_toolbar setHidden:NO];
}

- (IBAction)hideToolbar:(id)sender
{
	[_toolbar setHidden:YES];
}

- (IBAction)showPalette:(id)sender
{
	CanvasPaletteController	*controller;
	UIAlertView				*alertView;
	
	if([PaletteController partCount] > 0)
	{
		controller = [[CanvasPaletteController alloc] initWithNibName:@"CanvasPalette" bundle:nil];
		[controller setTitle:@"Palette"];
		[self presentModalViewController:[controller autorelease] animated:YES];
	}
	else
	{
		alertView = [[UIAlertView alloc] initWithTitle:@"Palette" 
											   message:@"You have no parts in your palette." 
											  delegate:nil 
									 cancelButtonTitle:@"OK" 
									 otherButtonTitles:nil];
		[alertView show];	
	}
}

- (IBAction)showPartInformation:(id)sender
{
	CanvasPartInfoController	*controller;
	
	if(_part)
	{
		controller = [[[CanvasPartInfoController alloc] initWithNibName:@"CanvasPartInfo" bundle:nil part:_part] autorelease];
		[controller setTitle:@"Part Information"];
		[self presentModalViewController:controller animated:YES];
	}
}

- (IBAction)wrapSequence:(id)sender
{	
	if([[sender title] isEqualToString:@"Wrap"])
	{
		[sender setTitle:@"Unwrap"];
		[self showSequence];
	}
	else
	{
		[sender setTitle:@"Wrap"];
		[self showSequence];
	}
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
