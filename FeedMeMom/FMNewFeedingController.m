#import "FMNewFeedingController.h"
#import "FMFeedingEntry.h"
#import "FMDateSelectorController.h"
#import "FMLengthSelectorController.h"

@implementation FMNewFeedingController {
    NSDate* _date;
    int _leftMinutes;
    int _rightMinutes;
}

- (IBAction)cancelClick:(UIBarButtonItem *)sender {
    //[self.navigationController dismissViewControllerAnimated:true completion:^{}];
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (IBAction)saveClick:(id)sender {
    if (_doneOk != nil) {
        _doneOk(self);
    }
    [self.navigationController dismissViewControllerAnimated:true completion:^{}];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_prepare != nil) {
        _prepare(self);
    }
}


-(void)setDate:(NSDate*)value {
    _date = value;
    _lblDate.text = [NSDateFormatter
            localizedStringFromDate:value
                          dateStyle:kCFDateFormatterMediumStyle
                          timeStyle:NSDateFormatterShortStyle];

}

-(NSDate*) date {
    return _date;
}

-(void)setLeftMinutes:(int)leftMinutes {
    _leftMinutes = leftMinutes;
    _lblLeftMinutes.text = [NSString stringWithFormat:@"%d", _leftMinutes];
}

- (int)leftMinutes {
    return _leftMinutes;
}

- (void)setRightMinutes:(int)rightMinutes {
    _rightMinutes = rightMinutes;
    _lblRightMinutes.text = [NSString stringWithFormat:@"%d", _rightMinutes];
}

- (int)rightMinutes {
    return _rightMinutes;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    [super prepareForSegue:segue sender:sender];

    if ([segue.identifier isEqualToString: @"selectDate"]) {
        FMDateSelectorController *controller = (FMDateSelectorController *)segue.destinationViewController;
        controller.date = _date;
        controller.done = ^(FMDateSelectorController *ctrl) {
            [self setDate: ctrl.date];
        };
    }

    if ([segue.identifier isEqualToString: @"selectLeft"]) {
        FMLengthSelectorController *controller = (FMLengthSelectorController *)segue.destinationViewController;
        controller.title = NSLocalizedString(@"Left", nil);
        controller.prepare = ^(FMLengthSelectorController *ctrl) {
            ctrl.value = _leftMinutes;
        };
        controller.done = ^(FMLengthSelectorController *ctrl) {
            [self setLeftMinutes:ctrl.value];
        };
    }

    if ([segue.identifier isEqualToString: @"selectRight"]) {
        FMLengthSelectorController *controller = (FMLengthSelectorController *)segue.destinationViewController;
        controller.title = NSLocalizedString(@"Right", nil);
        controller.prepare = ^(FMLengthSelectorController *ctrl) {
            ctrl.value = _rightMinutes;
        };
        controller.done = ^(FMLengthSelectorController *ctrl) {
            [self setRightMinutes:ctrl.value];
        };
    }
}


@end
