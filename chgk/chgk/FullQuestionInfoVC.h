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

- (void)FullQuestionInfoVCdidFinish:(FullQuestionInfoVC *)sender ;

@end

@interface FullQuestionInfoVC : UIViewController

@property (nonatomic, weak) id<FullQuestionInfoVCDelegate> delegate;

- (instancetype)initWithQuestion:(Question *)question;

@end
