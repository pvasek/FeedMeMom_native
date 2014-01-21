#import <Foundation/Foundation.h>
#import "FMAgo.h"

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


@property(nonatomic,readonly) BOOL isNew;
@property(nonatomic) int leftBreastLengthMinutes;
@property(nonatomic) int rightBreastLengthMinutes;
@property(nonatomic, readonly) int totalMinutes;
@property (nonatomic, readonly) int totalSeconds;
@property (nonatomic, readonly) BOOL isPaused;

- (NSString *)totalMinutesText;

- (FMAgo *)ago;
- (void)setNowForTestDate:(NSDate *)date;

- (void)pause;

- (void)start;
@end
