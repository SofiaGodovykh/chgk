//
//  MenuVC.h
//  chgk
//
//  Created by Semen Ignatov on 05/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContinueDelegate.h"

@interface MenuVC : UIViewController

@property (nonatomic, weak) id<ContinueDelegate> delegate;

@end
