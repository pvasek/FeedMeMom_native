#import "FMDateSelectorController.h"


@implementation FMDateSelectorController {

@private
    NSDate* _date;
}

- (NSDate*)date {
    return _dateSelector.date;
}

- (void)setDate:(NSDate *)date {
    _dateSelector.date = date;
}

@end