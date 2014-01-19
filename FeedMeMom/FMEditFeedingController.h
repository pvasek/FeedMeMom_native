//
//  FMNewFeedingController.h
//  app
//
//  Created by Pavel Vašek on 11/01/14.
//  Copyright (c) 2014 Pavel Vašek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMFeedingEntry.h"


@interface FMEditFeedingController : UITableViewController

@property(nonatomic, copy) void (^doneOk)(FMEditFeedingController *controller);
@property(nonatomic, copy) void (^prepare)(FMEditFeedingController *controller);

@property (nonatomic,strong) NSDate* date;
@property (nonatomic) int leftMinutes;
@property (nonatomic) int rightMinutes;
@property (weak, nonatomic) IBOutlet UILabel *lblRightMinutes;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftMinutes;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteFeeding;


- (void)setFeeding:(FMFeedingEntry *)feeding;
@end
