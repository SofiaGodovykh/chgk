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

/**
 *  Notifies the receiver that the sender has finished its job 
 *  (showing list of favorite or played questions).
 */
- (void)favoriteVCdidFinish:(FavoriteVC *)sender ;

@end

@interface FavoriteVC : UIViewController

/**
 *  Returns the object that handles the delegated duties.
 */
@property (nonatomic, weak) id<FavoriteVCDelegate> delegate;

/**
 *  Performs no initialization, use -initWithQuestion instead
 */
- (id)init NS_UNAVAILABLE;

/**
 *  Initializes a newly created instance with array of Question objects.
 *  isDeleatable - this flag enables delete button from swype right gesture.
 *  This is designated initializer.
 */
- (instancetype)initWithQuestions:(NSArray *)questions deletable:(BOOL)isDeletable;

@end
