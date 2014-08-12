//
//  FavoriteVC.m
//  chgk
//
//  Created by Semen Ignatov on 12/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import "FavoriteVC.h"
#import "DB.h"
#import "Question.h"

@interface FavoriteVC ()
@property (nonatomic, weak) IBOutlet UILabel *label1;
@end

@implementation FavoriteVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!!self.navigationItem) {
        UIBarButtonItem *const okBarButtonItem =
        [[UIBarButtonItem alloc]initWithTitle:@"OK"
                                        style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(didTouchOKBarButtonItem:)];;
        [self.navigationItem setRightBarButtonItem:okBarButtonItem];
    }
    
    
    NSMutableString *answers = [NSMutableString string];
    NSArray *favArray = [[DB standardBase] getAllFavs];
    
    int i = 0;
    for ( Question *quest in favArray){
        [answers appendFormat:@"%d  :  %@\n", i, quest.answer];
        i++;
    }
    //TODO: add a table
    self.label1.text = answers;

    
    
}

- (void)didTouchOKBarButtonItem:(UIBarButtonItem *)sender
{
    [self.delegate favoriteVCdidFinish:self];
}

@end
