#import <Foundation/Foundation.h>

@class FMFeedingEntry;


@interface FMRepository : NSObject {
    BOOL _debug;
}

@property(nonatomic) BOOL debug;

- (id)initWithDbPath:(NSString *)path debug:(BOOL)isDebug;

- (FMFeedingEntry *)lastFeeding;

- (BOOL)insertFeeding:(FMFeedingEntry *)entry;

- (void)updateFeeding:(FMFeedingEntry *)entry;
@end