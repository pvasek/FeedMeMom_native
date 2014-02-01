#import <XCTest/XCTest.h>
#import "FMFeedingEntry.h"

@interface FM_feeding_entry_tests : XCTestCase
@end

@implementation FM_feeding_entry_tests {
    FMFeedingEntry *_target;
}

- (void)setUp
{
    [super setUp];
    _target = [[FMFeedingEntry alloc] init];
}

-(void)test_calculate_total_time {
    _target.leftBreastLengthSeconds = 120;
    _target.rightBreastLengthSeconds = 180;
    XCTAssertEqual(5, _target.totalMinutes);

}

-(void)test_calculate_right_time_in_minutes {
    _target.rightBreastLengthSeconds = 180;
    XCTAssertEqual(3, _target.rightBreastLengthMinutes);
}

-(void)test_calculate_left_time_in_minutes {
    _target.leftBreastLengthSeconds = 180;
    XCTAssertEqual(3, _target.leftBreastLengthMinutes);
}

-(void)test_set_right_time_in_minutes {
    _target.rightBreastLengthMinutes = 3;
    XCTAssertEqual(180, _target.rightBreastLengthSeconds);
}

-(void)test_set_left_time_in_minutes {
    _target.leftBreastLengthMinutes = 3;
    XCTAssertEqual(180, _target.leftBreastLengthSeconds);
}

-(void)test_ago_as_now {
    _target.date = [NSDate dateWithTimeIntervalSinceReferenceDate: 0];

    [_target setNowForTestDate:[NSDate dateWithTimeIntervalSinceReferenceDate: 0]];
    FMAgo *result1 = [_target ago];
    XCTAssertEqualObjects(@"now", result1.timeText);
    XCTAssertEqualObjects(@"", result1.unitText);

    [_target setNowForTestDate:[NSDate dateWithTimeIntervalSinceReferenceDate: 119]];
    FMAgo *result2 = [_target ago];
    XCTAssertEqualObjects(@"now", result2.timeText);
    XCTAssertEqualObjects(@"", result2.unitText);
}

-(void)test_ago_as_minutes {
    _target.date = [NSDate dateWithTimeIntervalSinceReferenceDate: 0];

    [_target setNowForTestDate:[NSDate dateWithTimeIntervalSinceReferenceDate: 3*60]];
    FMAgo *result1 = [_target ago];
    XCTAssertEqualObjects(@"3", result1.timeText);
    XCTAssertEqualObjects(@"minutes", result1.unitText);

    [_target setNowForTestDate:[NSDate dateWithTimeIntervalSinceReferenceDate: 59*60]];
    FMAgo *result2 = [_target ago];
    XCTAssertEqualObjects(@"59", result2.timeText);
    XCTAssertEqualObjects(@"minutes", result2.unitText);
}

-(void)test_ago_as_hours {
    _target.date = [NSDate dateWithTimeIntervalSinceReferenceDate: 0];

    [_target setNowForTestDate:[NSDate dateWithTimeIntervalSinceReferenceDate: 60*60]];
    FMAgo *result1 = [_target ago];
    XCTAssertEqualObjects(@"1:00", result1.timeText);
    XCTAssertEqualObjects(@"hours", result1.unitText);

    [_target setNowForTestDate:[NSDate dateWithTimeIntervalSinceReferenceDate: 19*60*60+23*60]];
    FMAgo *result2 = [_target ago];
    XCTAssertEqualObjects(@"19:23", result2.timeText);
    XCTAssertEqualObjects(@"hours", result2.unitText);
}

-(void)test_ago_as_days {
    _target.date = [NSDate dateWithTimeIntervalSinceReferenceDate: 0];

    [_target setNowForTestDate:[NSDate dateWithTimeIntervalSinceReferenceDate: 24*60*60+1]];
    FMAgo *result1 = [_target ago];
    XCTAssertEqualObjects(@"1", result1.timeText);
    XCTAssertEqualObjects(@"day", result1.unitText);

    [_target setNowForTestDate:[NSDate dateWithTimeIntervalSinceReferenceDate: 48*60*60+1]];
    FMAgo *result2 = [_target ago];
    XCTAssertEqualObjects(@"2", result2.timeText);
    XCTAssertEqualObjects(@"days", result2.unitText);
}


- (void)test_should_calculate_total_time_for_running_feeding {
    [_target setNowForTestDate:[NSDate dateWithTimeIntervalSinceReferenceDate: 120]];
    _target.rightBreastLengthSeconds = 30;
    _target.leftStartTime = [NSDate dateWithTimeIntervalSinceReferenceDate: 0];
    XCTAssertEqual(150, _target.totalSeconds);
    XCTAssertEqualObjects(@"2:30", _target.totalMinutesText);
}


@end