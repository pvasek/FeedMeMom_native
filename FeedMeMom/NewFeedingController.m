//
//  NewFeedingController.m
//  app
//
//  Created by Pavel Vašek on 11/01/14.
//  Copyright (c) 2014 Pavel Vašek. All rights reserved.
//

#import "NewFeedingController.h"
#import "FMFeedingEntry.h"

@interface NewFeedingController ()

@end

@implementation NewFeedingController {
    NSDate* _date;
    NSNumber* _leftMinutes;
    NSNumber* _rightMinutes;
}

@synthesize feeding = _feeding;


- (IBAction)cancelClick:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:true completion:^{}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (_feeding == nil) {
        [self setDate: [NSDate date]];
        [self setLeftMinutes:[[NSNumber alloc] initWithInt:0]];
        [self setRightMinutes:[[NSNumber alloc] initWithInt:0]];
    }
}



-(void)setDate:(NSDate*)value {
    _date = value;
    NSString *dateText = [NSDateFormatter
            localizedStringFromDate:value
                          dateStyle:kCFDateFormatterMediumStyle
                          timeStyle:NSDateFormatterShortStyle];

    [_dateButton setTitle:dateText forState:UIControlStateNormal];
    [_dateButton setTitle:dateText forState:UIControlStateSelected];
}

-(NSDate*) date {
    return _date;
}

-(void)setLeftMinutes:(NSNumber *)leftMinutes {
    _leftMinutes = leftMinutes;
    NSString* text = [_leftMinutes stringValue];
    [_leftButton setTitle:text forState:UIControlStateNormal];
    [_leftButton setTitle:text forState:UIControlStateSelected];
}

- (NSNumber *)leftMinutes {
    return _leftMinutes;
}

- (void)setRightMinutes:(NSNumber *)rightMinutes {
    _rightMinutes = rightMinutes;
    NSString* text = [_leftMinutes stringValue];
    [_leftButton setTitle:text forState:UIControlStateNormal];
    [_leftButton setTitle:text forState:UIControlStateSelected];
}

- (NSNumber *)rightMinutes {
    return _rightMinutes;
}
@end
