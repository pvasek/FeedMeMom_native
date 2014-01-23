#import "FMRootController.h"
#import "UIViewController+JASidePanel.h"
#import "FMAppDelegate.h"

@implementation FMRootController {

}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningNavigationBar;
    [self setLeftDrawerViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"sideMenuController"]];
    UIViewController *mainNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainNavigationController"];
    MainNavigationController = (UINavigationController*)mainNavigationController;
    [self setCenterViewController:mainNavigationController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.sidePanelController showCenterPanelAnimated:NO];
}

@end