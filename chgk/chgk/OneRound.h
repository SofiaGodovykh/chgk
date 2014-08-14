//
//  OneRound.h
//  chgk
//
//  Created by Semen Ignatov on 06/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

/**
 *  This class stores current question, string with player's answer to that question, 
 *  and current score
 */
@interface OneRound : NSObject <NSCopying>

@property (nonatomic, strong) Question *currentQuestion;
@property (nonatomic, copy) NSString *playerAnswer;
@property (nonatomic) int rightAnswers;
@property (nonatomic) int wrongAnswers;

@end
