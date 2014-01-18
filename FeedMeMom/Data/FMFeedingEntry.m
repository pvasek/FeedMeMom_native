//
//  FeedingEntry.m
//  app
//
//  Created by Pavel Vašek on 11/01/14.
//  Copyright (c) 2014 Pavel Vašek. All rights reserved.
//
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


@end


