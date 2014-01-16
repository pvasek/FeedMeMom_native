//
//  NewFeedingController.h
//  app
//
//  Created by Pavel Vašek on 11/01/14.
//  Copyright (c) 2014 Pavel Vašek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMFeedingEntry;

@interface NewFeedingController : UITableViewController

@property (nonatomic,strong) FMFeedingEntry * feeding;

@property (nonatomic,strong) NSDate* date;
@property (nonatomic,strong) NSNumber* leftMinutes;
@property (nonatomic,strong) NSNumber* rightMinutes;

@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end
