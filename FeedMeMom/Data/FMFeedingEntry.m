#import "FMFeedingEntry.h"

const int secPerMinute = 60;
const int secPerHour = secPerMinute*60;
const int secPerDay = secPerHour*24;

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

- (int)totalSeconds {
    int running = [self runningLeft] + [self runningRight];
    return _leftBreastLengthSeconds+_rightBreastLengthSeconds + running;
}

- (int)totalLeftSeconds {
    return _leftBreastLengthSeconds + [self runningLeft];
}

- (int)totalRightSeconds {
    return _rightBreastLengthSeconds + [self runningRight];
}

- (int)runningLeft {
    if (_leftStartTime != nil) {
        return (int) [[self now] timeIntervalSinceDate:_leftStartTime];
    }
    return 0;
}

- (int)runningRight {
    if (_rightStartTime != nil) {
        return (int) [[self now] timeIntervalSinceDate:_rightStartTime];
    }
    return 0;
}

- (int)totalMinutes {
    return self.totalSeconds / 60;
}

- (void)setRightBreastLengthMinutes:(int)rightBreastLengthMinutes {
    _rightBreastLengthSeconds = rightBreastLengthMinutes * 60;

}

- (NSString*)totalMinutesText {
    int tot = self.totalSeconds;
    return [NSString stringWithFormat:@"%d:%02d", tot / 60, tot % 60];
}

- (NSString*)totalLeftMinutesText {
    int tmp = [self totalLeftSeconds] / 60;
    return [NSString stringWithFormat:@"%d", tmp];
}

- (NSString*)totalRightMinutesText {
    int tmp = [self totalRightSeconds] / 60;
    return [NSString stringWithFormat:@"%d", tmp];
}


- (NSString*)agoMinutes {
    if (_date == nil) {
        return @"";
    }
    NSTimeInterval diff = [[self now] timeIntervalSinceDate:_date];

    if (diff < 120) {
        return NSLocalizedString(@"now", nil);
    }
    int hours = (int) (diff / secPerHour);
    diff = diff - hours*secPerHour;
    int minutes = (int) (diff / 60);
    return [NSString stringWithFormat:@"%d:%02d", hours, minutes];
}

- (NSString*) dateTitle {
    NSDateFormatterStyle dateStyle =  NSDateFormatterNoStyle;
    if (![self isToday:_date]) {
        dateStyle =  NSDateFormatterShortStyle;
    }
    return [NSDateFormatter localizedStringFromDate:_date dateStyle:dateStyle timeStyle:NSDateFormatterShortStyle];
}

- (BOOL) isToday:(NSDate*)date {
    NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    return [today day] == [otherDay day] &&
            [today month] == [otherDay month] &&
            [today year] == [otherDay year] &&
            [today era] == [otherDay era];
}

- (FMAgo*)ago {
    if (_date == nil) {
        return [[FMAgo alloc] init];
    }

    NSTimeInterval diff = [[self now] timeIntervalSinceDate:_date];

    int days = (int) (diff / secPerDay);
    diff = diff - days*secPerDay;
    int hours = (int) (diff / secPerHour);
    diff = diff - hours*secPerHour;
    int minutes = (int) (diff / 60);

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


- (void)pause {
    [self stop];
    _pausedAt = [self now];
}

- (BOOL)isPaused {
    return _pausedAt != nil;
}

- (void)stop {
    self.rightBreastLengthSeconds += [self runningRight];
    self.leftBreastLengthSeconds += [self runningLeft];
    self.rightStartTime = nil;
    self.leftStartTime = nil;
}

- (void)start {
    _pausedAt = nil;
    if (_isLeft) {
        self.leftStartTime = [self now];
    } else {
        self.rightStartTime = [self now];
    }
}

@end


