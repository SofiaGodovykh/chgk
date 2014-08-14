//
//  OneRound.m
//  chgk
//
//  Created by Semen Ignatov on 06/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import "OneRound.h"
#import "Question.h"

@implementation OneRound

@synthesize currentQuestion = currentQuestion_;

- (instancetype)copyWithZone:(NSZone *)zone
{
    OneRound *copy = [[OneRound allocWithZone:zone]init];
    copy.currentQuestion = [self.currentQuestion copy];
    copy.playerAnswer = self.playerAnswer;
    copy.rightAnswers = self.rightAnswers;
    copy.wrongAnswers = self.wrongAnswers;
    return copy;
}

@end
