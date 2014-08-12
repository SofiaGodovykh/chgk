//
//  FavoriteVC.h
//  chgk
//
//  Created by Semen Ignatov on 12/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FavoriteVC;

@protocol FavoriteVCDelegate <NSObject>

- (void)favoriteVCdidFinish:(FavoriteVC *)sender ;

@end

@interface FavoriteVC : UIViewController

@property (nonatomic, weak) id<FavoriteVCDelegate> delegate;

- (instancetype)initWithQuestions:(NSArray *)questions;

@end
