//
//  DescriptionController.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/13/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiologicalPart.h"


@interface DescriptionController : UIViewController 
{
	IBOutlet UITextView		*_textView;
	
	BiologicalPart			*_part;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil part:(BiologicalPart*)part;

@end
