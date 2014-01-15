#import "FMLastFeedingController.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "FMRootController.h"
#import "FMAppDelegate.h"

@implementation FMLastFeedingController {

}

- (IBAction)menuClick:(id)sender {
    [self.sidePanelController showLeftPanelAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end