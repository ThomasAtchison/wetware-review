//
//  AboutController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 3/4/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "AboutController.h"


@implementation AboutController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad
{
	id				version;
	NSString		*aboutHTMLPath;
	NSString		*aboutHTMLString;
	NSError			*error;
	UIAlertView		*alertView;
	
    [super viewDidLoad];
	
	version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
	[_versionLabel setText:[NSString stringWithFormat:@"v. %@",version]];
	aboutHTMLPath = [[NSBundle mainBundle] pathForResource:@"About" ofType:@"html"];
	
	if(aboutHTMLPath)
	{
		aboutHTMLString = [NSString stringWithContentsOfFile:aboutHTMLPath encoding:NSUTF8StringEncoding error:&error];
		
		if(aboutHTMLString)
		{
			[_webView loadHTMLString:aboutHTMLString baseURL:nil];
		}
		else
		{
			alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
												   message:@"There was error while trying to retrieve the About file."
												  delegate:nil 
										 cancelButtonTitle:@"OK" 
										 otherButtonTitles:nil];
			[alertView show];
		}
	}
	else
	{
		alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
											   message:@"There was error while trying to retrieve the About file."
											  delegate:nil 
									 cancelButtonTitle:@"OK" 
									 otherButtonTitles:nil];
		[alertView show];
	}
}


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
			decision = NO;
			break;
			
		case UIInterfaceOrientationLandscapeRight:
			decision = NO;
			break;
			
		default:
			break;
	}
	
	return decision;
}

- (IBAction)openProjectWebsite:(id)sender
{
	NSURL	*url;
	
	url = [NSURL URLWithString:@"http://openwetware.org/wiki/Endy:Notebook/BioBrick_Studio"];
	[[UIApplication sharedApplication] openURL:url];
}

-(IBAction)dismissAboutView:(id)sender
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
