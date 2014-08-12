//
//  DB.m
//  chgk
//
//  Created by Admin on 11/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "DB.h"
#import "FMDB.h"
#import "Question.h"

@interface DB()

@property (nonatomic)  FMDatabase* database;

@property (nonatomic, strong, readonly) NSString* path;

@end


@implementation DB

+ (instancetype)standardBase
{
    static dispatch_once_t onceToken = 0;
    static DB *standardBase_ = nil;
    dispatch_once(&onceToken, ^{
        standardBase_ = [[self alloc] init];
    });
    
    return standardBase_;
}


- (DB *)init
{
    if(self == [super init]){
        NSString *path = @"/Users/signatov/Documents/kk/database.sqlite";
        //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                    //         NSUserDomainMask,
                                                     //        YES);
      //  NSString *path = paths[0];
        //path = [path stringByAppendingPathComponent:@"chgkDB.sqlite"];
        
        _database = [FMDatabase databaseWithPath:path];
        [_database open];
        //don't forget to remove it
        //[_database executeUpdate:@"delete from Exercise"];
        [_database executeUpdate:@"create table if not exists Exercise(idByOrder int primary key, question text, answer text, annotation text, authors text, sources text, picture text, id int, isUsed int, isFavorited int)"];
    }
    
    return self;
}

- (void)addItemsInExercise:(NSArray* )items
{
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc] initWithPath: self.path];
    [queue inDatabase:^(FMDatabase *database)
    {
         [self.database beginTransaction];
         for(Question *question in items) {
             [self.database executeUpdate:@"insert into Exercise(idByOrder, question, answer, annotation, authors, sources, picture, id, isUsed, isFavorited) values(?,?,?,?,?,?,?,?,?,?)",
              [NSNumber numberWithInteger:question.IdByOrder],
              question.question,
              question.answer,
              question.annotation,
              question.authors,
              question.sources,
              question.pictureName,
              [NSNumber numberWithInteger:question.ID],
              @0,
              @0];
         }
         [self.database commit];
     }];
    NSLog(@"Number of question in sql DB : %ld", [self countOfItemsInExercise]);
}

- (NSInteger)countOfItemsInExercise
{
    return [self.database intForQuery:@"SELECT COUNT(idByOrder) FROM Exercise WHERE isUsed=0"];
}

-(NSArray*)bunchOfQuestions
{
    FMResultSet *result = [self.database executeQuery: @"SELECT * FROM Exercise WHERE isUsed=0 group by random() limit 10"];
    NSMutableArray *array = [NSMutableArray array];
    
    while([result next])
    {
        [array addObject:[[Question alloc] initWithDictionary:[result resultDictionary]]];
    }
    
    NSMutableString *ids = [[NSMutableString alloc] initWithString:@""];

    for (int i = 0; i < [array count]; i++)
    {
        NSMutableString *idFromDictionary = [NSMutableString stringWithFormat:
                                             @"%ld",
                                             [array[i] IdByOrder]];
        [ids appendString: idFromDictionary];
        [ids appendString:@","];
    }
    
    NSRange range;
    range.location = ids.length - 1;
    range.length = 1;
    
    [ids deleteCharactersInRange: range];
    NSMutableString *update = [[NSMutableString alloc] initWithString:@"UPDATE Exercise SET isUsed=1 where idByOrder in ("];
    [update appendString:ids];
    [update appendString:@")"];
   [self.database executeUpdate: update];
    
    return [array copy];
}

-(void)addToFavorite:(NSInteger) idByOrder
{
    NSMutableString *update = [[NSMutableString alloc] initWithString: @"UPDATE Exercise SET isFavorited=1 where idByOrder="];
    [update appendFormat:@"%ld", (long)idByOrder];
    [self.database executeUpdate: update];
}

-(NSArray*)getAllFavs
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    FMResultSet *result = [self.database executeQuery: @"SELECT * FROM Exercise where isFavorited=1"];
    while([result next])
    {
        [array addObject:[[Question alloc] initWithDictionary:[result resultDictionary] ]];
    }
    
    return array;
}

-(void)removeFromFavorite:(NSInteger) idByOrder
{
    NSMutableString *update = [[NSMutableString alloc] initWithString: @"UPDATE Exercise SET isFavorited=0 where idByOrder="];
    [update appendFormat:@"%ld", (long)idByOrder];
    [self.database executeUpdate: update];
}

-(Question*)getQuestionsById:(NSInteger) key
{
    NSString *str = [NSString stringWithFormat:@"SELECT * FROM Exercise where idByOrder = %ld", key];
    FMResultSet *result = [self.database executeQuery: str];
    while ([result next])
    {
        Question *question = [[Question alloc] initWithDictionary:[result resultDictionary]];
        return question;
    }
    
    return nil;
}

-(NSInteger)getID
{
    FMResultSet *result = [self.database executeQuery: @"SELECT * FROM Exercise group by random() limit 1"];
    while ([result next])
    {
        NSInteger str = [[[result resultDictionary] valueForKey:@"idByOrder"] intValue];
        return str;
    }
    
    return 0;
}

- (void)dealloc
{
    [self.database close];
}

@end
