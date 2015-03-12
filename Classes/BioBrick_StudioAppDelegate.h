//
//  BioBrick_StudioAppDelegate.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/17/09.
//  Copyright Stanford University 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BioBrick_StudioAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>
{
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
