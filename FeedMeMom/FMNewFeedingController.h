//
//  FMNewFeedingController.h
//  app
//
//  Created by Pavel Vašek on 11/01/14.
//  Copyright (c) 2014 Pavel Vašek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMFeedingEntry.h"


@interface FMNewFeedingController : UITableViewController

@property (nonatomic,strong) FMFeedingEntry * feeding;
@property(nonatomic, copy) void (^doneOk)();

@property (nonatomic,strong) NSDate* date;
@property (nonatomic) int leftMinutes;
@property (nonatomic) int rightMinutes;
@property (weak, nonatomic) IBOutlet UILabel *lblRightMinutes;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftMinutes;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;


@end
