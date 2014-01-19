#import "FMFeedingEntry.h"

@implementation FMFeedingEntry {
@private
    int _id;
    int _type;
    NSString *_name;
    NSDate *_date;
    int _value;
    int _leftBreastLengthSeconds;
    int _rightBreastLengthSeconds;
    NSDate *_leftStartTime;
    NSDate *_rightStartTime;
    NSDate *_pausedAt;
    int _isLeft;
    NSDate *_testNow;
    BOOL _isNew;
}

@synthesize id = _id;
@synthesize type = _type;
@synthesize name = _name;
@synthesize date = _date;
@synthesize value = _value;
@synthesize leftBreastLengthSeconds = _leftBreastLengthSeconds;
@synthesize rightBreastLengthSeconds = _rightBreastLengthSeconds;
@synthesize leftStartTime = _leftStartTime;
@synthesize rightStartTime = _rightStartTime;
@synthesize pausedAt = _pausedAt;
@synthesize isLeft = _isLeft;

- (BOOL)isNew {
    return _id == 0;
}
- (int)leftBreastLengthMinutes {
    return _leftBreastLengthSeconds / 60;
}

- (void)setLeftBreastLengthMinutes:(int)leftBreastLengthMinutes {
    _leftBreastLengthSeconds = leftBreastLengthMinutes * 60;

}

- (int)rightBreastLengthMinutes {
    return _rightBreastLengthSeconds / 60;
}

- (int)totalMinutes {
    return (_leftBreastLengthSeconds+_rightBreastLengthSeconds) / 60;
}

- (void)setRightBreastLengthMinutes:(int)rightBreastLengthMinutes {
    _rightBreastLengthSeconds = rightBreastLengthMinutes * 60;

}

- (NSString*)totalMinutesText {
    return [NSString stringWithFormat:@"%d", self.totalMinutes];
}

- (FMAgo*)ago {
    if (_date == nil) {
        return [[FMAgo alloc] init];
    }

    NSTimeInterval diff = [[self now] timeIntervalSinceDate:_date];

    const int secPerMinute = 60;
    const int secPerHour = secPerMinute*60;
    const int secPerDay = secPerHour*24;

    int days = diff / secPerDay;
    diff = diff - days*secPerDay;
    int hours = diff / secPerHour;
    diff = diff - hours*secPerHour;
    int minutes = diff / 60;

    FMAgo *result = [[FMAgo alloc] init];

    if (days > 1) {
        result.timeText = [NSString stringWithFormat:@"%d", days];
        result.unitText = NSLocalizedString(@"days", @"");
    } else if (days == 1) {
        result.timeText = [NSString stringWithFormat:@"%d", days];
        result.unitText = NSLocalizedString(@"day", @"");
    } else if (hours >= 1) {
        result.timeText = [NSString stringWithFormat:@"%d:%02d", hours, minutes];
        result.unitText = NSLocalizedString(@"hours", @"");
    } else if (minutes > 2) {
        result.timeText = [NSString stringWithFormat:@"%d", minutes];
        result.unitText = NSLocalizedString(@"minutes", @"");
    } else {
        result.timeText = NSLocalizedString(@"now", nil);
        result.unitText = @"";
    }
    return result;
}

- (NSDate*)now {
    if (_testNow != nil) {
        return _testNow;
    }
    return [NSDate date];
}

- (void)setNowForTestDate:(NSDate*)date {
    _testNow = date;
}

@end


