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

/**
 *  Adds array of Question objects into database
 */
- (void)addItemsInExercise:(NSArray *)items;

/**
 *  Returns total count of questions in database
 */
- (NSInteger)countOfItemsInDatabase;


/**
 *  Returns several (count) of questions from database
 */
- (NSArray *)bunchOfQuestions:(NSInteger)count;

/**
 *  Returns questions with specific idByOrder parameter from database
 */
- (NSArray *)questionsWithNumbers:(NSArray *)idByOrder;

/**
 *  Returns single question with specific idByOrder parameter
 */
- (Question *)getQuestionsById:(NSInteger)key;

/**
 *  Returns all favorite questions from database
 */
- (NSArray *)getAllFavs;


/**
 *  Marks question with specific idByOrder as favorite or not.
 */
- (void)addToFavorite:(NSInteger)idByOrder;
- (void)removeFromFavorite:(NSInteger)idByOrder;

@end
