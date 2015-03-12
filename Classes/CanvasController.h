//
//  CanvasController.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/13/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiologicalPart.h"
#import "PaletteController.h"
#import "CanvasPaletteController.h"
#import "CanvasPartInfoController.h"


@interface CanvasController : UIViewController 
{
	IBOutlet UIWebView			*_webView;
	IBOutlet UIToolbar			*_toolbar;
	IBOutlet UIButton			*_partIDButton;
	IBOutlet UIBarButtonItem	*_wrapButton;
	
	BiologicalPart			*_part;
}

+ (BOOL)savePart:(BiologicalPart *)part;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil part:(BiologicalPart*)part;
- (void)showSequence;

- (IBAction)showToolbar:(id)sender;
- (IBAction)hideToolbar:(id)sender;
- (IBAction)showPalette:(id)sender;
- (IBAction)showPartInformation:(id)sender;
- (IBAction)wrapSequence:(id)sender;

@end
