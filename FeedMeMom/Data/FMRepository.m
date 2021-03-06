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

NSString *const FeedingSelectLastSql = @"SELECT * FROM FeedingEntry ORDER BY Date DESC LIMIT 1";

NSString *const FeedingInsertSql = @"INSERT INTO FeedingEntry ( \
        Type,\
        Name,\
        Date,\
        Value,\
        LeftBreastLengthSeconds,\
        RightBreastLengthSeconds,\
        LeftStartTime,\
        RightStartTime,\
        PausedAt,\
        IsLeft\
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

NSString *const FeedingUpdateSql = @"UPDATE FeedingEntry SET\
        Type=:type,\
        Name=:name,\
        Date=:date,\
        Value=:value,\
        LeftBreastLengthSeconds=:leftBreastLengthSeconds,\
        RightBreastLengthSeconds=:rightBreastLengthSeconds,\
        LeftStartTime=:leftStartTime,\
        RightStartTime=:rightStartTime,\
        PausedAt=:pausedAt,\
        IsLeft=:isLeft\
        WHERE Id = :id";


NSString *const FeedingDeleteSql = @"DELETE FROM FeedingEntry WHERE Id = ?";

void addKeyValue(NSMutableDictionary *dict, NSString *key, NSObject *obj) {
    if (obj == nil) {
        obj = [NSNull null];
    }
    [dict setObject:obj forKey:key];
}

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
        if (path == nil) {
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
        FMResultSet *row = [db executeQuery:FeedingSelectLastSql];
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

        result = [db executeUpdate:FeedingInsertSql,
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
            entry.id = [[NSNumber numberWithInteger:[db lastInsertRowId]] integerValue];
        }
    }];
    return result;
}

- (BOOL)updateFeeding:(FMFeedingEntry *)entry {
    __block BOOL result = false;
    [self run:^(FMDatabase *db) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        addKeyValue(params, @"id", [NSNumber numberWithInt:entry.id]);
        addKeyValue(params, @"type", [NSNumber numberWithInt:entry.type]);
        addKeyValue(params, @"name", entry.name);
        addKeyValue(params, @"date", entry.date);
        addKeyValue(params, @"value", [NSNumber numberWithInt:entry.value]);
        addKeyValue(params, @"leftBreastLengthSeconds", [NSNumber numberWithInt:entry.leftBreastLengthSeconds]);
        addKeyValue(params, @"rightBreastLengthSeconds", [NSNumber numberWithInt:entry.rightBreastLengthSeconds]);
        addKeyValue(params, @"leftStartTime", entry.leftStartTime);
        addKeyValue(params, @"rightStartTime", entry.rightStartTime);
        addKeyValue(params, @"pausedAt", entry.pausedAt);
        addKeyValue(params, @"isLeft", [NSNumber numberWithInt:entry.isLeft]);
        result = [db executeUpdate:FeedingUpdateSql withParameterDictionary:params];
    }];
    return result;
}

- (void)deleteFeedingWithId:(int) id {
    [self run:^(FMDatabase *db) {
        [db executeUpdate:FeedingDeleteSql, [[NSNumber alloc] initWithInt:id]];
    }];
}

@end