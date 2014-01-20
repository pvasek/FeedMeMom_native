#import "FMNewFeedingController.h"
#import "FMAppDelegate.h"
#import "CCAlertView.h"


@implementation FMNewFeedingController {

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

- (IBAction)timeTapped:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    _lblLeftRunning.attributedText = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"left", nil)
                                                                     attributes:underlineAttribute];
    _lblRightRunning.attributedText = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"right", nil)
                                                                     attributes:underlineAttribute];

    self.isLeft = true;
}

- (void)setIsLeft:(BOOL)isLeft {
    _lblLeftRunning.hidden = !isLeft;
    _lblLeft.hidden = isLeft;
    _lblRightRunning.hidden = isLeft;
    _lblRight.hidden = !isLeft;
}


@end