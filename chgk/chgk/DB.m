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


- (DB *)init
{
    if(self == [super init])
    {
        NSString *path = @"/Users/signatov/Documents/kk/database.sqlite";
        
        _database = [FMDatabase databaseWithPath:path];
        [_database open];
        [_database executeUpdate:@"create table if not exists Exercise(idByOrder int, question text, answer text, annotation text, authors text, sources text, picture text, id int)"];
        
//        NSString *query = [NSString stringWithFormat:@"insert into Exercise values (%d, '%@', '%@', '%@', '%@', '%@', '%@', %d, '%@')", arc4random(), @"question1", @"answer1", @"annotation1", @"authors1", @"sources1", @"picture1", 1, @"11"];
        
//        [_database executeUpdate:query];
        //[_database close];
    }
    
    return self;
}

- (void)addItemsInExercise:(NSArray* )items
{
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc] initWithPath: self.path];
    [queue inDatabase:^(FMDatabase *database)
     {
         [_database beginTransaction];
         for(Question *question in items)
         {
             NSString *pic = question.pictureName;
             if(pic == nil)
             {
                 pic = @"";
             }
//             NSString *query = [NSString stringWithFormat:@"insert into Exercise values (%d, '%@', '%@', '%@', '%@', '%@', '%@', %d, '%@')", arc4random(), @"question1", @"answer1", @"annotation1", @"authors1", @"sources1", @"picture1", 1, @"11"];

//             [_database executeUpdate:[NSString stringWithFormat: @"insert into Exercise values (%ld, '%@', '%@', '%@', '%@', '%@', '%@', %ld)", question.IdByOrder, question.question, question.answer, question.annotation, question.authors, question.sources, pic, question.ID]];
             
//             NSString *query = [NSString stringWithFormat:@"insert into Exercise(idByOrder, question, answer, annotation, authors, sources, picture, id) values(?,?,?,?,?,?,?,?)"];
             [self.database executeUpdate:@"insert into Exercise(idByOrder, question, answer, annotation, authors, sources, picture, id) values(?,?,?,?,?,?,?,?)",[NSNumber numberWithInteger:question.IdByOrder], question.question, question.answer, question.annotation, question.authors, question.sources, pic, [NSNumber numberWithInteger:question.ID]];
             
         }
         
         [_database commit];
         //[_database close];
     }];
    NSLog(@"%ld", [self countOfItemsInExercise]);
}

- (NSInteger)countOfItemsInExercise
{
   // FMResultSet *result = [self.database executeQuery:@"select (*) from Exercise"];
    NSUInteger count = [self.database intForQuery:@"SELECT COUNT(*) FROM Exercise"];
    return count;
}


- (void)dealloc
{
   [_database close];
}

@end
