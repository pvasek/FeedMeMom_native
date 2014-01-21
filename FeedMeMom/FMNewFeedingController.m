#import "FMNewFeedingController.h"
#import "FMAppDelegate.h"
#import "CCAlertView.h"
#import "FMFeedingEntry.h"


@implementation FMNewFeedingController {
    FMFeedingEntry *_feeding;
}

- (IBAction)saveFeeding:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)cancelFeeding:(id)sender {

    CCAlertView *alert = [[CCAlertView alloc]
            initWithTitle:@""
                  message:NSLocalizedString(@"Do you want to cancel this session?", nil)];

    [alert addButtonWithTitle:NSLocalizedString(@"Yes", nil) block:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alert addButtonWithTitle:NSLocalizedString(@"No", nil) block:^{
    }];
    [alert show];
}

- (IBAction)switchSides:(id)sender {
    self.isLeft = !self.isLeft;
}

- (IBAction)timeTapped:(id)sender {
    if (_feeding.isPaused) {
        [_feeding start];
    } else {
        [_feeding pause];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    _lblLeftRunning.attributedText = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"left", nil)
                                                                     attributes:underlineAttribute];
    _lblRightRunning.attributedText = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"right", nil)
                                                                     attributes:underlineAttribute];

    _feeding = [[FMFeedingEntry alloc] init];
    self.isLeft = YES;
    [_feeding start];
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateData) userInfo:nil repeats:YES];
}

- (void)setIsLeft:(BOOL)isLeft {
    _isLeft = isLeft;
    _feeding.isLeft = isLeft;
    _lblLeftRunning.hidden = !isLeft;
    _lblLeft.hidden = isLeft;
    _lblRightRunning.hidden = isLeft;
    _lblRight.hidden = !isLeft;
    if (isLeft) {
        [_btnSwitchSides setTitle:NSLocalizedString(@"Switch to Right", nil) forState:UIControlStateNormal];
    } else {
        [_btnSwitchSides setTitle:NSLocalizedString(@"Switch to Left", nil) forState:UIControlStateNormal];
    }
}

- (void) updateData {
    _lblTime.text = _feeding.totalMinutesText;
}


@end