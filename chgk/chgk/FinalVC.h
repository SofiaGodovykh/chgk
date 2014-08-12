//
//  FinalVCViewController.h
//  chgk
//
//  Created by Admin on 12/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FinalVC;

@protocol FinalVCViewControllerDelegate <NSObject>

- (void)finalVCdidFinish:(FinalVC *)sender ;

@end

@interface FinalVC : UIViewController

@property (nonatomic, weak) id<FinalVCViewControllerDelegate> delegate;

@end
