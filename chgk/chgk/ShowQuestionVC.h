//
//  showQuestionVC.h
//  chgk
//
//  Created by Admin on 13/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShowQuestionVC;

@protocol ShowQuestionVCDelegate <NSObject>

/**
 *  Notifies the receiver that the sender has finished its job
 *  (showing text of just played question).
 */
- (void)showQuestionVCDidFinished:(ShowQuestionVC *)sender;

@end

@interface ShowQuestionVC : UIViewController

/**
 *  Returns the object that handles the delegated duties.
 */
@property (nonatomic, strong) id<ShowQuestionVCDelegate> delegate;

/**
 *  Performs no initialization, use -initWithQuestionText: instead
 */
- (id)init NS_UNAVAILABLE;

- (instancetype)initWithQuestionText:(NSString *)text;

@end
