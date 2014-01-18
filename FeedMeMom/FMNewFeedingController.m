#import "FMNewFeedingController.h"
#import "FMFeedingEntry.h"
#import "FMDateSelectorController.h"
#import "FMLengthSelectorController.h"

@implementation FMNewFeedingController {
    NSDate* _date;
    int _leftMinutes;
    int _rightMinutes;
}

@synthesize feeding = _feeding;


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

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (_feeding == nil) {
        [self setDate: [NSDate date]];
        [self setLeftMinutes: 0];
        [self setRightMinutes: 0];
    } else {
        [self setDate: _feeding.date];
        [self setLeftMinutes:_feeding.leftBreastLengthMinutes];
        [self setRightMinutes:_feeding.rightBreastLengthMinutes];
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
        FMDateSelectorController *ctrl = (FMDateSelectorController *)segue.destinationViewController;
        ctrl.date = _date;
        ctrl.done = ^() {
            [self setDate: ctrl.date];
        };
    }

    if ([segue.identifier isEqualToString: @"selectLeft"]) {
        FMLengthSelectorController *ctrl = (FMLengthSelectorController *)segue.destinationViewController;
        ctrl.title = NSLocalizedString(@"Left", nil);
        ctrl.prepare = ^() {
            ctrl.value = _leftMinutes;
        };
        ctrl.done = ^() {
            [self setLeftMinutes:ctrl.value];
        };
    }

    if ([segue.identifier isEqualToString: @"selectRight"]) {
        FMLengthSelectorController *ctrl = (FMLengthSelectorController *)segue.destinationViewController;
        ctrl.title = NSLocalizedString(@"Right", nil);
        ctrl.prepare = ^() {
            ctrl.value = _rightMinutes;
        };
        ctrl.done = ^() {
            [self setRightMinutes:ctrl.value];
        };
    }
}


@end
