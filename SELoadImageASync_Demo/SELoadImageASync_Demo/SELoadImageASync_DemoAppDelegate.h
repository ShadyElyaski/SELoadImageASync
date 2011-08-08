//
//  SELoadImageASync_DemoAppDelegate.h
//  SELoadImageASync_Demo
//
//  Created by Shady Elyaski on 7/30/11.
//

#import <UIKit/UIKit.h>
#import "SELoadImageASync_DemoViewController.h"

@class SELoadImageASync_DemoViewController;

@interface SELoadImageASync_DemoAppDelegate : NSObject <UIApplicationDelegate>{
    SELoadImageASync_DemoViewController *vc;
    UINavigationController *nc;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SELoadImageASync_DemoViewController *viewController;

@end
