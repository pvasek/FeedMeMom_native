#import "FMLastFeedingController.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "FMRootController.h"
#import "FMAppDelegate.h"
#import "FMEditFeedingController.h"
#import "FMRepository.h"

@implementation FMLastFeedingController {
    FMFeedingEntry *_lastFeeding;
}

- (IBAction)menuClick:(id)sender {
    [self.sidePanelController showLeftPanelAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _lastFeeding = [Repository lastFeeding];
    [self updateView];
}

- (void)updateView {
    if (_lastFeeding != nil) {
        _lblTotalLength.text = [NSString stringWithFormat:@"%d", _lastFeeding.totalMinutes];
        FMAgo *ago = [_lastFeeding ago];
        _lblAgo.text = ago.timeText;
        _lblAgoUnits.text = ago.unitText;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];

    if ([segue.identifier isEqualToString: @"addFeeding"]) {
        FMEditFeedingController *controller = (FMEditFeedingController *)segue.destinationViewController;
        [controller setFeeding:[[FMFeedingEntry alloc] init]];
    }

    if ([segue.identifier isEqualToString: @"editFeeding"] && _lastFeeding) {
        FMEditFeedingController *controller = (FMEditFeedingController *)segue.destinationViewController;
        [controller setFeeding:_lastFeeding];
    }
}

@end