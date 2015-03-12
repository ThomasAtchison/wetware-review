//
//  AboutController.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 3/4/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutController : UIViewController
{
	IBOutlet UILabel	*_versionLabel;
	IBOutlet UIWebView	*_webView;
}

- (IBAction)openProjectWebsite:(id)sender;
- (IBAction)dismissAboutView:(id)sender;

@end
