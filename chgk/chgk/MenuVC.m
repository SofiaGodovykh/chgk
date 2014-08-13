//
//  MenuVC.m
//  chgk
//
//  Created by Semen Ignatov on 05/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import "MenuVC.h"
#import "QuestionVC.h"
#import "FavoriteVC.h"
#import "DB.h"

@interface MenuVC () <FavoriteVCDelegate>

@property (nonatomic, weak) IBOutlet UIButton *startGame;
@property (nonatomic, weak) IBOutlet UIButton *continueGame;

@end

@implementation MenuVC

//TODO: I totaly don't like how startGamePressed and continueGamePressed actions works.
- (IBAction)startGamePressed:(id)sender
{
    QuestionVC *questionVC = [[QuestionVC alloc]init];
    [self.navigationController pushViewController:questionVC animated:YES];
    [questionVC startNewGame];
    if ((!self.navigationController)&&(!!self.delegate)){
        [self.delegate stopTimer];
        UINavigationController *mainNC = [[UINavigationController alloc]
                                          initWithRootViewController:questionVC];
        mainNC.navigationBar.translucent = NO;
        self.view.window.rootViewController = mainNC;
    }
}

- (IBAction)continueGamePressed:(id)sender
{
    if (!!self.delegate){
        [self.delegate removeMenu];
    }
    else {
        QuestionVC *questionVC = [[QuestionVC alloc] init];
        [questionVC continuePreviousGame];
        [self.navigationController pushViewController:questionVC animated:YES];
    }
}

- (IBAction)favoritePressed:(id)sender
{
    FavoriteVC *favoriteVC = [[FavoriteVC alloc]initWithQuestions:[[DB standardBase] getAllFavs]
                                                        deletable:YES];
    favoriteVC.delegate = self;
    UINavigationController *const navigationController =
    [[UINavigationController alloc] initWithRootViewController:favoriteVC];
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (void)favoriteVCdidFinish:(FavoriteVC *)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
