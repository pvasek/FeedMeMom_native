//
//  FMAppDelegate.h
//  app
//
//  Created by Pavel Vašek on 11/01/14.
//  Copyright (c) 2014 Pavel Vašek. All rights reserved.
//

#import <UIKit/UIKit.h>

UINavigationController * MainNavigationController;

@interface FMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(UIViewController*) historyController;

@end
