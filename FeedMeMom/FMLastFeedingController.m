#import "FMLastFeedingController.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "FMRootController.h"
#import "FMAppDelegate.h"
#import "FMEditFeedingController.h"
#import "FMRepository.h"
#import "UIViewController+MMDrawerController.h"
#import "FMColors.h"
#import "FMNewFeedingController.h"
#import "FMUIConstants.h"

@implementation FMLastFeedingController {
    FMFeedingEntry *_lastFeeding;
}

- (IBAction)menuClick:(id)sender {
    //[self.sidePanelController showLeftPanelAnimated:YES];
    [self.mm_drawerController toggleDrawerSide: MMDrawerSideLeft animated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnStartLeft.layer.cornerRadius = FM_DEFAULT_CORNER_RADIUS;
    _btnStartRight.layer.cornerRadius = FM_DEFAULT_CORNER_RADIUS;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _lastFeeding = [Repository lastFeeding];
    [self updateView];

    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModePanningCenterView | MMCloseDrawerGestureModeTapCenterView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
}


- (void)updateView {
    if (_lastFeeding != nil) {
        _lblTotalLength.text = [NSString stringWithFormat:@"%d %@", _lastFeeding.totalMinutes, NSLocalizedString(@"min", nil)];
        _lblAgo.text = [_lastFeeding agoMinutes];
        _lblAgoTime.text = _lastFeeding.dateTitle;

        if (_lastFeeding.isLeft) {
            _btnStartLeft.backgroundColor = Colors.inactiveButtonColor;
            _btnStartRight.backgroundColor = Colors.activeButtonColor;
            _lblRecommendedLeft.hidden = YES;
            _lblRecommendedRight.hidden = NO;
            _lblSide.text = NSLocalizedString(@"LEFT", nil);
        } else {
            _btnStartLeft.backgroundColor = Colors.activeButtonColor;
            _btnStartRight.backgroundColor = Colors.inactiveButtonColor;
            _lblRecommendedLeft.hidden = NO;
            _lblRecommendedRight.hidden = YES;
            _lblSide.text = NSLocalizedString(@"RIGHT", nil);
        }

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

    if ([segue.identifier isEqualToString: @"newLeftFeeding"]) {
        FMNewFeedingController *controller = (FMNewFeedingController *)segue.destinationViewController;
        controller.startWithLeft = YES;
    }

    if ([segue.identifier isEqualToString: @"newRightFeeding"]) {
        FMNewFeedingController *controller = (FMNewFeedingController *)segue.destinationViewController;
        controller.startWithLeft = NO;
    }
}


@end