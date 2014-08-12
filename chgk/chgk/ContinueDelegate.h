//
//  ContinueDelegate.h
//  chgk
//
//  Created by Semen Ignatov on 06/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AnswerVC;

@protocol ContinueDelegate <NSObject>

- (void)removeMenu;
- (void)nextQuestionAfterAnswer:(BOOL)isRight;
- (void)questionsWatchDog;
- (void)stopTimer;
- (void)answerVC:(AnswerVC *)sender didFinishedWithView:(UIViewController *)viewController;

@end
