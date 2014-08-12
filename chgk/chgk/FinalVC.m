//
//  FinalVCViewController.m
//  chgk
//
//  Created by Admin on 12/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "FinalVC.h"
#import "MenuVC.h"
#import "QuestionVC.h"

@interface FinalVC ()

@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UIButton *startGameButton;
@property (nonatomic, weak) IBOutlet UIButton *statistic;

@property (nonatomic) int rightAnswers;
@property (nonatomic) int wrongAnswers;

@end

@implementation FinalVC
@synthesize rightAnswers = rightAnswers_;
@synthesize wrongAnswers = wrongAnswers_;


- (instancetype)initWithRight:(int)right andWrongAnswers:(int)wrong
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

@end