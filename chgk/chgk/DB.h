//
//  DB.h
//  chgk
//
//  Created by Admin on 11/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DB : NSObject

- (void)addItemsInExercise:(NSArray* )items;
- (NSInteger)countOfItemsInExercise;

/**
 *  Returns the shared database object.
 */
+ (instancetype)standardBase;
@end
