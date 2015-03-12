//
//  FoyerViewController.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/18/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "FoyerViewController.h"


@implementation FoyerViewController

-(void)awakeFromNib
{
//	NSString*				urlString;
//	NSURL*					url;
//	NSMutableURLRequest*	request;
//	
//	urlString = @"http://ginkgobioworks.com/mobile.html";
//	
//	url = [[NSURL alloc] initWithString:urlString];
//	request = [[NSMutableURLRequest alloc] initWithURL:url];
//	[request setHTTPMethod:@"GET"];
//	[_webView loadRequest:request];
}

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

-(IBAction)openAdPage:(id)sender
{
	NSURL* url;	

	url = [NSURL URLWithString:@"http://bbf.openwetware.org/Membership.html"];
	[[UIApplication sharedApplication] openURL:url];
}

-(IBAction)presentAboutView:(id)sender
{
	AboutController*	controller;
	
	controller = [[[AboutController alloc] initWithNibName:@"About" bundle:nil] autorelease];
	[controller setTitle:@"About"];
	[self presentModalViewController:controller animated:YES];
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
