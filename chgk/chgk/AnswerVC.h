//
//  AnswerVC.h
//  chgk
//
//  Created by Semen Ignatov on 06/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContinueDelegate.h"

@class OneRound;

@interface AnswerVC : UIViewController

/**
 *  Returns the object that handles the delegated duties.
 */
@property (nonatomic, weak) id<ContinueDelegate> delegate;

/**
 *  Performs no initialization, use -initWithRound: instead
 */
- (id)init NS_UNAVAILABLE;

- (instancetype)initWithRound:(OneRound *)round;

@end
