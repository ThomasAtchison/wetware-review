//
//  BioBrick_StudioAppDelegate.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/17/09.
//  Copyright Stanford University 2009. All rights reserved.
//

#import "BioBrick_StudioAppDelegate.h"


@implementation BioBrick_StudioAppDelegate

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc 
{
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

