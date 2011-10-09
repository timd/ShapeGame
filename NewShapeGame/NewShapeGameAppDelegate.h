//
//  NewShapeGameAppDelegate.h
//  NewShapeGame
//
//  Created by Tim Duckett on 09/10/2011.
//  Copyright 2011 Charismatic Megafauna Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewShapeGameViewController;

@interface NewShapeGameAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet NewShapeGameViewController *viewController;

@end
