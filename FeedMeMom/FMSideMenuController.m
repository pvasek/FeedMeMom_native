#import "FMSideMenuController.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "FMAppDelegate.h"
#import "UIViewController+MMDrawerController.h"
#import "FMColors.h"
#import "FMLastFeedingController.h"

@implementation FMSideMenuController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        [self.sidePanelController showCenterPanelAnimated:YES];
        UIViewController *history = [FMAppDelegate historyController];
        [self.mm_drawerController closeDrawerAnimated:NO completion:^(BOOL finished) {
            [MainNavigationController pushViewController:history animated:NO];
        }];
    }

    if (indexPath.row == 1) {
        [self.sidePanelController showCenterPanelAnimated:YES];
        UIViewController *statistics = [FMAppDelegate statisticsController];
        [self.mm_drawerController closeDrawerAnimated:NO completion:^(BOOL finished) {
            [MainNavigationController pushViewController:statistics animated:NO];
        }];
    }

    if (indexPath.row == 2) {
        [FMColors switchColorScheme];
        MainNavigationController.navigationBar.barTintColor = Colors.navigationBarColor;
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {}];
    }
}

@end