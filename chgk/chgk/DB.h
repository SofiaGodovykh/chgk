//
//  DB.h
//  chgk
//
//  Created by Admin on 11/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface DB : NSObject
/**
 *  Returns the shared database object.
 */
+ (instancetype)standardBase;

- (void)addItemsInExercise:(NSArray* )items;
- (NSInteger)countOfItemsInExercise;

- (NSArray *)bunchOfQuestions;
- (NSArray *)questionsWithNumbers:(NSArray *)idByOrder;
- (Question *)getQuestionsById:(NSInteger)key;
- (void)addToFavorite:(NSInteger)idByOrder;
- (void)removeFromFavorite:(NSInteger)idByOrder;
- (NSArray *)getAllFavs;
- (NSInteger)getID;
@end
