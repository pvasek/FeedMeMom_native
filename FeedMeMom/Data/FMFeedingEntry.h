//
//  FeedingEntry.h
//  app
//
//  Created by Pavel Vašek on 11/01/14.
//  Copyright (c) 2014 Pavel Vašek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FMFeedingEntry : NSObject

@property int id;
@property int type;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSDate * date;
@property int value;
@property int leftBreastLengthSeconds;
@property int rightBreastLengthSeconds;
@property (strong, nonatomic) NSDate * leftStartTime;
@property (strong, nonatomic) NSDate * rightStartTime;
@property (strong, nonatomic) NSDate * pausedAt;
@property int isLeft;


@end
