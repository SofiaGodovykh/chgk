//
//  FinalVCViewController.m
//  chgk
//
//  Created by Admin on 12/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "FinalVC.h"
#import "MenuVC.h"
#import "FavoriteVC.h"
#import "DB.h"
#import "QuestionVC.h"
#import <Social/Social.h>


@interface FinalVC () <FavoriteVCDelegate>

@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UIButton *startGameButton;
@property (nonatomic, weak) IBOutlet UIButton *statistic;
@property (nonatomic, weak) IBOutlet UIButton *shareToFacebook;
@property (nonatomic, weak) IBOutlet UIButton *shareToTwitter;

@property (nonatomic) int rightAnswers;
@property (nonatomic) int wrongAnswers;
@property (nonatomic) NSArray *playedID;

@end

@implementation FinalVC
@synthesize rightAnswers = rightAnswers_;
@synthesize wrongAnswers = wrongAnswers_;
@synthesize playedID = playedID_;

#pragma mark initialization
- (id)init
{
    NSLog(@"Please use initWithRight:wrongAnswers:playedID: instead");
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (instancetype)initWithRight:(int)right wrongAnswers:(int)wrong playedID:(NSArray *)played
{
    if (self = [super init]){
        rightAnswers_ = right;
        wrongAnswers_ = wrong;
        playedID_ = played;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d:%d",
                            self.rightAnswers,
                            self.wrongAnswers];
}

#pragma mark actions
- (IBAction)startGamePressed:(id)sender
{
    QuestionVC *questionVC = [[QuestionVC alloc]init];
    [questionVC startNewGame];
    [self.navigationController setViewControllers:
     [NSArray arrayWithObject:questionVC] animated:YES];
}

- (IBAction)statisticPressed:(id)sender
{
    FavoriteVC *favoriteVC = [[FavoriteVC alloc]initWithQuestions:
                              [[DB standardBase] questionsWithNumbers:self.playedID]
                                                        deletable:NO];
    favoriteVC.delegate = self;
    UINavigationController *const navigationController =
    [[UINavigationController alloc] initWithRootViewController:favoriteVC];
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (IBAction)menuPressed:(id)sender
{
    MenuVC *menuVC = [[MenuVC alloc]init];
    [self.navigationController setViewControllers:
     [NSArray arrayWithObject:menuVC] animated:YES];
}

- (IBAction)shareToFacebookPressed:(id)sender
{
    SLComposeViewController *controller = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeFacebook];
    [controller setInitialText:[NSString stringWithFormat:
                                @"My score is chgkGame is : %@",
                                self.scoreLabel.text]];
    [self presentViewController:controller animated:YES completion:Nil];
}

- (IBAction)shareToTwitterPressed:(id)sender
{
    SLComposeViewController *controller = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
    [controller setInitialText:[NSString stringWithFormat:
                                @"My score is chgkGame is : %@",
                                self.scoreLabel.text]];
    [self presentViewController:controller animated:YES completion:Nil];

}

- (void)favoriteVCdidFinish:(FavoriteVC *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
