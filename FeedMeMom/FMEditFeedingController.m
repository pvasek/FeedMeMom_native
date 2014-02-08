#import "FMEditFeedingController.h"
#import "FMFeedingEntry.h"
#import "FMDateSelectorController.h"
#import "FMLengthSelectorController.h"
#import "FMAppDelegate.h"
#import "FMRepository.h"
#import "CCAlertView.h"
#import "FMColors.h"

@implementation FMEditFeedingController {
    NSDate* _date;
    int _leftMinutes;
    int _rightMinutes;
    FMFeedingEntry *_feeding;
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

- (IBAction)deleteFeeding:(id)sender {
    if (!_feeding.isNew) {
        CCAlertView *alert = [[CCAlertView alloc]
                initWithTitle:@""
                      message:NSLocalizedString(@"Do you want to delete this feeding?", nil)];

        [alert addButtonWithTitle:NSLocalizedString(@"Yes", nil) block:^{
            [Repository deleteFeedingWithId:_feeding.id];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        [alert addButtonWithTitle:NSLocalizedString(@"No", nil) block:^{
        }];
        [alert show];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_prepare != nil) {
        _prepare(self);
    }

    _btnDeleteFeeding.hidden = _feeding.isNew;

    self.view.backgroundColor = Colors.background;
}


-(void)setDate:(NSDate*)value {
    _date = value;
    _lblDate.text = [NSDateFormatter
            localizedStringFromDate:value
                          dateStyle:NSDateFormatterMediumStyle
                          timeStyle:NSDateFormatterShortStyle];

}


- (void) setFeeding:(FMFeedingEntry*) feeding {
    _feeding = feeding;
    _prepare = ^(FMEditFeedingController * ctrl) {
        ctrl.date = feeding.date;
        ctrl.leftMinutes = feeding.leftBreastLengthMinutes;
        ctrl.rightMinutes = feeding.rightBreastLengthMinutes;
        ctrl.prepare = nil;
    };
    FMEditFeedingController *selfPointer = self;
    _doneOk = ^(FMEditFeedingController * ctrl) {
        feeding.date = ctrl.date;
        feeding.rightBreastLengthMinutes = ctrl.rightMinutes;
        feeding.leftBreastLengthMinutes = ctrl.leftMinutes;

        if (feeding.isNew) {
            [Repository insertFeeding:feeding];
        } else {
            [Repository updateFeeding:feeding];
        }
        [selfPointer.navigationController popToRootViewControllerAnimated:YES];
    };    
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
