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
//        NSString *path = @"/Users/signatov/Documents/kk/database.sqlite";
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                             NSUserDomainMask,
                                                             YES);
        NSString *path = paths[0];
        path = [path stringByAppendingPathComponent:@"chgkDB.sqlite"];
        
        _database = [FMDatabase databaseWithPath:path];
        [_database open];
        //don't forget to remove it
        [_database executeUpdate:@"delete from Exercise"];
        [_database executeUpdate:@"create table if not exists Exercise(idByOrder int, question text, answer text, annotation text, authors text, sources text, picture text, id int)"];
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
             [self.database executeUpdate:@"insert into Exercise(idByOrder, question, answer, annotation, authors, sources, picture, id) values(?,?,?,?,?,?,?,?)",
              [NSNumber numberWithInteger:question.IdByOrder],
              question.question,
              question.answer,
              question.annotation,
              question.authors,
              question.sources,
              question.pictureName,
              [NSNumber numberWithInteger:question.ID]];
             
         }
         [self.database commit];
     }];
    NSLog(@"%ld", [self countOfItemsInExercise]);
}

- (NSInteger)countOfItemsInExercise
{
    return [self.database intForQuery:@"SELECT COUNT(*) FROM Exercise"];
}

- (void)dealloc
{
    [self.database close];
}

@end
