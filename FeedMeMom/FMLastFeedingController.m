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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];

    if (segue.identifier == @"") {
        //segue.destinationViewController
    }
}

@end