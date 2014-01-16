#import "FMSideMenuController.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "FMAppDelegate.h"

@implementation FMSideMenuController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {

        [self.sidePanelController showCenterPanelAnimated:YES];
        UIViewController *history = [FMAppDelegate historyController];
        [MainNavigationController pushViewController:history animated:NO];
    }
}

@end