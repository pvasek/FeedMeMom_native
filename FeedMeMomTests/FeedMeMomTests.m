//
//  FeedMeMomTests.m
//  FeedMeMomTests
//
//  Created by Pavel Vašek on 12/01/14.
//  Copyright (c) 2014 Pavel Vašek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMRepository.h"
#import "FMFeedingEntry.h"

@interface FeedMeMomTests : XCTestCase

@end

@implementation FeedMeMomTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRepositoryInit
{
    FMRepository *repository = [[FMRepository alloc] initWithDbPath:nil debug:true];
    FMFeedingEntry *feeding = [[FMFeedingEntry alloc] init];
    feeding.name = @"test feeding";
    feeding.date = [[NSDate alloc] init];
    feeding.leftBreastLengthSeconds = 30;
    feeding.rightBreastLengthSeconds = 20;
    BOOL insertOk = [repository insertFeeding:feeding];
    FMFeedingEntry *result = [repository lastFeeding];
    XCTAssertEqual(YES, insertOk);
    XCTAssertNotNil(result);
}

@end
