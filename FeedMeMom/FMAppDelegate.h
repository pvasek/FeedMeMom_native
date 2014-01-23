//
//  FMAppDelegate.h
//  app
//
//  Created by Pavel Vašek on 11/01/14.
//  Copyright (c) 2014 Pavel Vašek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMRepository;

UINavigationController * MainNavigationController;
FMRepository *Repository;

@interface FMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (UIViewController *)fromStoryboardWithName:(NSString *)name;

+(UIViewController*) historyController;

@end
