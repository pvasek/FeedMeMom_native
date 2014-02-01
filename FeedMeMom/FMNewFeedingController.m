#import "FMNewFeedingController.h"
#import "FMAppDelegate.h"
#import "CCAlertView.h"
#import "FMFeedingEntry.h"
#import "FMRepository.h"
#import "FMUIConstants.h"


static NSString *const ckFeedingIncluded = @"feedingIncluded";
static NSString *const ckIsLeft = @"isLeft";
static NSString *const ckRightBreastLengthSeconds = @"rightBreastLengthSeconds";
static NSString *const ckLeftBreastLengthSeconds = @"leftBreastLengthSeconds";
static NSString *const ckLeftStartTime = @"leftStartTime";
static NSString *const ckRightStartTime = @"rightStartTime";
static NSString *const ckPausedAt = @"pausedAt";

@implementation FMNewFeedingController {
    FMFeedingEntry *_feeding;
}

- (IBAction)saveFeeding:(id)sender {
    [_feeding stop];
    _feeding.date = [NSDate date];
    [Repository insertFeeding:_feeding];
    _feeding = nil;

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)cancelFeeding:(id)sender {

    CCAlertView *alert = [[CCAlertView alloc]
            initWithTitle:@""
                  message:NSLocalizedString(@"Do you want to cancel this session?", nil)];

    [alert addButtonWithTitle:NSLocalizedString(@"Yes", nil) block:^{
        _feeding = nil;
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

    _btnSwitchSides.layer.cornerRadius = FM_DEFAULT_CORNER_RADIUS;
    _pnlTime.layer.cornerRadius = FM_DEFAULT_CORNER_RADIUS;

    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    _lblLeftRunning.attributedText = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"left", nil)
                                                                     attributes:underlineAttribute];
    _lblRightRunning.attributedText = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"right", nil)
                                                                     attributes:underlineAttribute];

    _feeding = [[FMFeedingEntry alloc] init];
    self.isLeft = _startWithLeft;
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
    if (_feeding == nil){
        return;
    }
    _lblTime.text = _feeding.totalMinutesText;
    _lblLeftTime.text = [_feeding totalLeftMinutesText];
    _lblRightTime.text = [_feeding totalRightMinutesText];

    if (_feeding.isPaused) {
        _lblTapDescription.text = NSLocalizedString(@"tap to start", nil);
    } else {
        _lblTapDescription.text = NSLocalizedString(@"tap to pause", nil);
    }
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeBool:_feeding != nil forKey:ckFeedingIncluded];
    if (_feeding != nil) {
        [coder encodeInt:_feeding.isLeft forKey:ckIsLeft];
        [coder encodeInt:_feeding.rightBreastLengthSeconds forKey:ckRightBreastLengthSeconds];
        [coder encodeInt:_feeding.leftBreastLengthSeconds forKey:ckLeftBreastLengthSeconds];
        if (_feeding.leftStartTime != nil) {
            [coder encodeDouble:_feeding.leftStartTime.timeIntervalSinceReferenceDate forKey:ckLeftStartTime];
        }
        if (_feeding.rightStartTime != nil) {
            [coder encodeDouble:_feeding.rightStartTime.timeIntervalSinceReferenceDate forKey:ckRightStartTime];
        }
        if (_feeding.pausedAt != nil) {
            [coder encodeDouble:_feeding.pausedAt.timeIntervalSinceReferenceDate forKey:ckPausedAt];
        }
    }
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    if ([coder decodeBoolForKey:ckFeedingIncluded]) {
        _feeding = [[FMFeedingEntry alloc] init];
        _feeding.isLeft = [coder decodeIntForKey:ckIsLeft];
        _feeding.rightBreastLengthSeconds = [coder decodeIntForKey:ckRightBreastLengthSeconds];
        _feeding.leftBreastLengthSeconds = [coder decodeIntForKey:ckLeftBreastLengthSeconds];
        if ([coder containsValueForKey:ckLeftStartTime]) {
            double tmp = [coder decodeDoubleForKey:ckLeftStartTime];
            _feeding.leftStartTime = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:tmp];
        }
        if ([coder containsValueForKey:ckRightStartTime]) {
            double tmp = [coder decodeDoubleForKey:ckRightStartTime];
            _feeding.rightStartTime = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:tmp];
        }
        if ([coder containsValueForKey:ckPausedAt]) {
            double tmp = [coder decodeDoubleForKey:ckPausedAt];
            _feeding.pausedAt = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:tmp];
        }
        self.isLeft = _feeding.isLeft == 1;
    }
}


@end