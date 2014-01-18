#import <XCTest/XCTest.h>
#import "FMRepository.h"
#import "FMFeedingEntry.h"

@interface FM_repository_tests : XCTestCase

@end

@implementation FM_repository_tests {
    FMRepository *_repository;
}

- (void)setUp
{
    [super setUp];
    _repository = [[FMRepository alloc] initWithDbPath:@"" debug:true];
}

- (void)tearDown
{
    [super tearDown];
    _repository = nil;
}

- (void)test_insert_a_new_feeding
{
    FMFeedingEntry *feeding = [[FMFeedingEntry alloc] init];
    feeding.name = @"test feeding";
    feeding.date = [[NSDate alloc] init];
    feeding.leftBreastLengthSeconds = 30;
    feeding.rightBreastLengthSeconds = 20;
    BOOL insertOk = [_repository insertFeeding:feeding];
    FMFeedingEntry *result = [_repository lastFeeding];
    XCTAssertEqual(YES, insertOk);
    XCTAssertNotNil(result);
}

- (void)test_update_last_feeding
{
    FMFeedingEntry *feeding = [[FMFeedingEntry alloc] init];
    feeding.name = @"test feeding";
    feeding.date = [[NSDate alloc] init];
    feeding.leftBreastLengthSeconds = 30;
    feeding.rightBreastLengthSeconds = 20;
    [_repository insertFeeding:feeding];
    FMFeedingEntry *result = [_repository lastFeeding];

    result.name = @"updated";
    result.date = [[NSDate alloc] init];
    result.leftBreastLengthSeconds = 32;
    result.rightBreastLengthSeconds = 22;
    BOOL updateOk = [_repository updateFeeding:result];

    FMFeedingEntry *result2 = [_repository lastFeeding];
    XCTAssertEqual(YES, updateOk);
    XCTAssertNotNil(result);
    XCTAssertEqualObjects(@"updated", result2.name);
    XCTAssertEqual(32, result2.leftBreastLengthSeconds);
    XCTAssertEqual(22, result2.rightBreastLengthSeconds);
}

@end
