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

- (void)addItemsInExercise:(NSArray* )items;
- (NSInteger)countOfItemsInExercise;

/**
 *  Returns the shared database object.
 */
+ (instancetype)standardBase;

-(NSArray*)bunchOfQuestions;

-(void)addToFavorite:(NSInteger) idByOrder;
-(NSArray*)getAllFavs;
-(NSInteger)getID;
-(Question*)getQuestionsById:(NSInteger) key;
@end
