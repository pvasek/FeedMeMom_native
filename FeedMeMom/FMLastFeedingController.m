#import "FMLastFeedingController.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "FMRootController.h"
#import "FMAppDelegate.h"
#import "FMNewFeedingController.h"
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
        FMNewFeedingController *controller = (FMNewFeedingController*)segue.destinationViewController;
        controller.prepare = ^(FMNewFeedingController* ctrl) {
            ctrl.date = [NSDate date];
            ctrl.leftMinutes = 0;
            ctrl.rightMinutes = 0;
            ctrl.prepare = nil;
        };
        controller.doneOk = ^(FMNewFeedingController* ctrl) {
            FMFeedingEntry *entry = [[FMFeedingEntry alloc] init];
            entry.date = ctrl.date;
            entry.rightBreastLengthMinutes = ctrl.rightMinutes;
            entry.leftBreastLengthMinutes = ctrl.leftMinutes;
            [Repository insertFeeding:entry];
            [self.navigationController popToViewController:self animated:true];
        };
    }

    if ([segue.identifier isEqualToString: @"editFeeding"] && _lastFeeding) {
        FMNewFeedingController *controller = (FMNewFeedingController*)segue.destinationViewController;
        controller.prepare = ^(FMNewFeedingController* ctrl) {
            ctrl.date = _lastFeeding.date;
            ctrl.leftMinutes = _lastFeeding.leftBreastLengthMinutes;
            ctrl.rightMinutes = _lastFeeding.rightBreastLengthMinutes;
            ctrl.prepare = nil;
        };
        controller.doneOk = ^(FMNewFeedingController* ctrl) {
            FMFeedingEntry *entry = _lastFeeding;
            entry.date = ctrl.date;
            entry.rightBreastLengthMinutes = ctrl.rightMinutes;
            entry.leftBreastLengthMinutes = ctrl.leftMinutes;
            [Repository updateFeeding:entry];
            [self.navigationController popToViewController:self animated:true];
        };
    }
}

@end