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


@interface FinalVC ()

@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UIButton *startGameButton;
@property (nonatomic, weak) IBOutlet UIButton *statistic;
@property (nonatomic, weak) IBOutlet UIButton *shareToFacebook;
@property (nonatomic, weak) IBOutlet UIButton *shareToTwitter;

@property (nonatomic) int rightAnswers;
@property (nonatomic) int wrongAnswers;

@end

@implementation FinalVC
@synthesize rightAnswers = rightAnswers_;
@synthesize wrongAnswers = wrongAnswers_;


- (instancetype)initWithRight:(int)right wrongAnswers:(int)wrong playedID:(NSArray *)played
{
    if (self = [super init]){
        rightAnswers_ = right;
        wrongAnswers_ = wrong;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scoreLabel.text = [NSString stringWithFormat:@"%02d:%02d",
                            self.rightAnswers,
                            self.wrongAnswers];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)startGamePressed:(id)sender
{
    QuestionVC *questionVC = [[QuestionVC alloc]init];
    [self.delegate finalVCdidFinish:self withView:questionVC];
}

- (IBAction)statisticPressed:(id)sender
{
    NSMutableArray *playedQuestions = [NSMutableArray array];
    DB *database = [DB standardBase];
    [playedQuestions addObject:[database getQuestionsById:12]];
//    FavoriteVC *statisticVC = [FavoriteVC alloc]initWithQuestions:[DB standardBase]
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
