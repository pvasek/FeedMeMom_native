#import "FMRepository.h"
#import "FMFeedingEntry.h"
#import "FMDatabase.h"
#import "FMAppDelegate.h"


NSString *const CreateDbSql = @"CREATE TABLE IF NOT EXISTS FeedingEntry("
        "    Id integer primary key autoincrement not null,"
        "    Type integer,"
        "    Name varchar(140),"
        "    Date datetime,"
        "    Value integer,"
        "    LeftBreastLengthSeconds integer,"
        "    RightBreastLengthSeconds integer,"
        "    LeftStartTime datetime,"
        "    RightStartTime datetime,"
        "    IsPaused integer,"
        "    PausedAt datetime,"
        "    IsLeft integer"
        ")";

NSString *const SelectLastSql = @"SELECT * FROM FeedingEntry ORDER BY Date DESC LIMIT 1";

NSString *const InsertSql = @"INSERT INTO FeedingEntry ("
        "Type, "
        "Name, "
        "Date, "
        "Value, "
        "LeftBreastLengthSeconds,"
        "RightBreastLengthSeconds,"
        "LeftStartTime,"
        "RightStartTime,"
        "PausedAt,"
        "IsLeft"
    ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

@implementation FMRepository {
    FMDatabase *_db;
    NSString *_dbPath;
}

-(id)init {
    return [self initWithDbPath:nil debug:false];
}

-(id)initWithDbPath:(NSString*)path debug:(BOOL)isDebug {
    self = [super init];
    if (self) {
        _debug = isDebug;
        if (path != nil) {
            _dbPath = path;
        } else {
            NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDir = [docPaths objectAtIndex:0];
            _dbPath = [documentsDir   stringByAppendingPathComponent:@"UserDatabase4.sqlite"];
        }

        [self createDb];

    }

    return self;
}

-(void)createDb {
    _db = [FMDatabase databaseWithPath:_dbPath];
    _db.logsErrors = true;
    _db.crashOnErrors = true;
    if (_debug) {
        _db.traceExecution = true;
    }
    [self run:^(FMDatabase *db) {
        [db executeUpdate:CreateDbSql];
    }];
}

-(void)run:(void(^)(FMDatabase* db)) callback {
    [_db open];
    @try {
        callback(_db);
    } @finally {
        [_db close];
    }
}


- (FMFeedingEntry *)lastFeeding {
    __block FMFeedingEntry *result = nil;
    [self run:^(FMDatabase *db) {
        FMResultSet *row = [db executeQuery:SelectLastSql];
        while ([row next])
        {
            result = [[FMFeedingEntry alloc] init];
            result.id = [row intForColumn:@"Id"];
            result.type = [row intForColumn:@"Type"];
            result.name = [row stringForColumn:@"Name"];
            result.date = [row dateForColumn:@"Date"];
            result.value = [row intForColumn:@"Value"];
            result.leftBreastLengthSeconds = [row intForColumn:@"LeftBreastLengthSeconds"];
            result.rightBreastLengthSeconds = [row intForColumn:@"RightBreastLengthSeconds"];
            result.leftStartTime = [row dateForColumn:@"LeftStartTime"];
            result.rightStartTime = [row dateForColumn:@"RightStartTime"];
            result.pausedAt = [row dateForColumn:@"PausedAt"];
            result.isLeft = [row intForColumn:@"IsLeft"];

        }
    }];
    return result;
}


- (BOOL)insertFeeding:(FMFeedingEntry *)entry {
    __block BOOL result = false;
    [self run:^(FMDatabase *db) {

        result = [db executeUpdate:InsertSql,
                                   [NSNumber numberWithInt:entry.type],
                                   entry.name,
                                   entry.date,
                                   [NSNumber numberWithInt:entry.value],
                                   [NSNumber numberWithInt:entry.leftBreastLengthSeconds],
                                   [NSNumber numberWithInt:entry.rightBreastLengthSeconds],
                                   entry.leftStartTime,
                                   entry.rightStartTime,
                                   entry.pausedAt,
                                   [NSNumber numberWithInt:entry.isLeft],
                                   nil];
        if (result) {
            entry.id = [NSNumber numberWithInteger:[db lastInsertRowId]];
        }
    }];
    return result;
}

@end