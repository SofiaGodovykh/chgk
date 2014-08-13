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

- (void)showQuestionVCDidFinished:(ShowQuestionVC *)sender;

@end

@interface ShowQuestionVC : UIViewController

@property (nonatomic, strong) id<ShowQuestionVCDelegate> delegate;
- (instancetype)initWithQuestionText:(NSString *)text;

@end
