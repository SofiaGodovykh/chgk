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
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)startGamePressed:(id)sender
{
    QuestionVC *questionVC = [[QuestionVC alloc]init];
    [questionVC startNewGame];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:questionVC] animated:YES];
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

- (void)favoriteVCdidFinish:(FavoriteVC *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareToFacebookPressed:(id)sender
{
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [controller setInitialText:@"score"];
    [self presentViewController:controller animated:YES completion:Nil];
}

- (IBAction)shareToTwitterPressed:(id)sender
{
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [controller setInitialText:@"score"];
    [self presentViewController:controller animated:YES completion:Nil];

}
@end
