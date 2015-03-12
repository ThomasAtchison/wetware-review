//
//  CanvasPartInfoController.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 5/30/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiologicalPart.h"

@interface CanvasPartInfoController : UIViewController
{	
	IBOutlet UITextView		*_textView;
	
	BiologicalPart			*_part;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil part:(BiologicalPart*)part;

-(IBAction)dismissView:(id)sender;

@end
