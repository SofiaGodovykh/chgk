//
//  FinalVCViewController.h
//  chgk
//
//  Created by Admin on 12/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinalVC : UIViewController

/**
 *  Performs no initialization, use -initWithRight:wrongAnswers:playedID instead
 */
- (id)init NS_UNAVAILABLE;

//TODO: send a single object with game info.
- (instancetype)initWithRight:(int)right wrongAnswers:(int)wrong playedID:(NSArray *)played;

@end
