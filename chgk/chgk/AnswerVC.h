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

@property (nonatomic, weak) id<ContinueDelegate> delegate;

- (instancetype)initWithRound:(OneRound *)round;

@end
