#import "FMRootController.h"
#import "UIViewController+JASidePanel.h"
#import "FMAppDelegate.h"

@implementation FMRootController {

}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"sideMenuController"]];
    UIViewController *mainNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainNavigationController"];
    MainNavigationController = (UINavigationController*)mainNavigationController;
    [self setCenterPanel:mainNavigationController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.sidePanelController showCenterPanelAnimated:YES];
}

- (void)stylePanel:(UIView *)panel {
}

@end