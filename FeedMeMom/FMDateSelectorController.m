#import "FMDateSelectorController.h"
#import "FMAppDelegate.h"
#import "FMColors.h"


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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = Colors.background;
}

@end