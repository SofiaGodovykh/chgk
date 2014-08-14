	//
//  FullQuestionInfoVC.h
//  chgk
//
//  Created by Semen Ignatov on 12/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FullQuestionInfoVC;
@class Question;

@protocol FullQuestionInfoVCDelegate <NSObject>

/**
 *  Notifies the receiver that the sender has finished its job (showing full question info).
 */
- (void)FullQuestionInfoVCdidFinish:(FullQuestionInfoVC *)sender ;

@end

@interface FullQuestionInfoVC : UIViewController

/**
 *  Returns the object that handles the delegated duties.
 */
@property (nonatomic, weak) id<FullQuestionInfoVCDelegate> delegate;

/**
 *  Performs no initialization, use -initWithQuestion instead
 */
- (id)init NS_UNAVAILABLE;
- (instancetype)initWithQuestion:(Question *)question;

@end
