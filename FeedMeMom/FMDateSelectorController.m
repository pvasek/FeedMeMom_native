#import "FMDateSelectorController.h"


@implementation FMDateSelectorController {
}

@synthesize done = _done;

- (NSDate*)date {
    return _dateSelector.date;
}

- (void)setDate:(NSDate *)date {
    _dateSelector.date = date;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_done != nil) {
        _done(self);
    }
}

@end