//
//  MenuVC.m
//  chgk
//
//  Created by Semen Ignatov on 05/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import "MenuVC.h"
#import "QuestionVC.h"

@interface MenuVC ()

@property (nonatomic, weak) IBOutlet UIButton *startGame;
@property (nonatomic, weak) IBOutlet UIButton *continueGame;

@end

@implementation MenuVC

- (IBAction)startGamePressed:(id)sender
{
    QuestionVC *questionVC = [[QuestionVC alloc]init];
    [self.navigationController pushViewController:questionVC animated:YES];
    
    if ((!self.navigationController)&&(!!self.delegate)){
        //TODO: think more about such solution. Isn't it a leak?
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
