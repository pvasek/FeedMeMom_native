#import "FMAppDelegate.h"
#import "FMRepository.h"
#import "FMColors.h"
#import "Crittercism.h"
#import "FMNewFeedingController.h"

static NSString *const coderKeyAppVersion = @"appVersion";
static int const appStateVersion = 1;

@implementation FMAppDelegate {
@private
    UIWindow *_window;
}

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Crittercism enableWithAppID:@"525e7e6f558d6a55d8000002"];
    LightColors = [FMColors createLightSchema];
    DarkColors = [FMColors createDarkSchema];
    Colors = LightColors;
    Repository = [[FMRepository alloc] initWithDbPath:@"feedingmom_data" debug:true];
    return YES;
}


- (void)dealloc {
    DarkColors = nil;
    LightColors = nil;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
}


+ (UIViewController *)fromStoryboardWithName:(NSString*) name {
    FMAppDelegate* appDelegate = (FMAppDelegate*)[[UIApplication sharedApplication] delegate];
    UIViewController *rootController = appDelegate.window.rootViewController;
    return [rootController.storyboard instantiateViewControllerWithIdentifier:name];
}

+ (UIViewController *)historyController {
    static UIViewController *historyController = nil;
    if (historyController == nil) {
        historyController = [FMAppDelegate fromStoryboardWithName:@"historyController"];
        historyController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return historyController;
}

+ (UIViewController *)statisticsController {
    static UIViewController *statisticsController = nil;
    if (statisticsController == nil) {
        statisticsController = [FMAppDelegate fromStoryboardWithName:@"statisticsController"];
        statisticsController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return statisticsController;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    [coder encodeInt:appStateVersion forKey:coderKeyAppVersion];
    return [MainNavigationController.topViewController isMemberOfClass:[FMNewFeedingController class]];
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    return [coder decodeIntForKey:coderKeyAppVersion] == appStateVersion;
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    return nil;

}


@end
