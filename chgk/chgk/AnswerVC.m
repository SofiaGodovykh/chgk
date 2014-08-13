//
//  AnswerVC.m
//  chgk
//
//  Created by Semen Ignatov on 06/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import "AnswerVC.h"
#import "OneRound.h"
#import "Question.h"
#import "FinalVC.h"
#import "DB.h"

@interface AnswerVC ()

@property (nonatomic, weak) IBOutlet UIButton *makeCorrectButton;
@property (nonatomic, weak) IBOutlet UIButton *nextQuestion;
@property (nonatomic, weak) IBOutlet UIButton *endGame;
@property (nonatomic, weak) IBOutlet UIButton *addToFavoriteButton;
@property (nonatomic, weak) IBOutlet UITextView *correctAnswer;
@property (nonatomic, weak) IBOutlet UITextView *playerAnswer;
@property (nonatomic, weak) IBOutlet UILabel *score;
@property (nonatomic, weak) IBOutlet UITextView *annotationView;
@property (nonatomic, weak) IBOutlet UIView *rightSignal;
@property (nonatomic, weak) IBOutlet UIImageView *correctnessImage;

@property (nonatomic, weak) OneRound *oneRound;
@property (nonatomic) BOOL isRight;

@end

@implementation AnswerVC

@synthesize oneRound = oneRound_;
@synthesize isRight = isRight_;

//TODO: bad practice to permit init of VC;
- (id)init
{
    NSLog(@"Please use initWithRound: instead");
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (instancetype)initWithRound:(OneRound *)round
{
    if(self=[super init]){
        oneRound_ = round;
    }
    
    return self;
}

- (BOOL)checkAnswer{
    if (([[self trimString:self.oneRound.playerAnswer]
          isEqualToString:
          [self trimString:self.oneRound.currentQuestion.answer]]) ||
        ([oneRound_.playerAnswer isEqualToString:@"hh"])){
        return YES;
    }

    return NO;
}

- (NSString *)trimString:(NSString *)string
{
    NSMutableString *modified = [[string lowercaseString] mutableCopy];
    NSError *__autoreleasing error = nil;
    // CR: Creating regex takes some time, better store this object for future use.
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"[^0-9a-zа-я]"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    if(!!error){
        NSLog(@"Error in string trimming, %@", error.userInfo);
    }
    if (!!modified){
    [regex replaceMatchesInString:modified
                          options:kNilOptions
                            range:NSMakeRange(0, [modified length])
                     withTemplate:@""];
    }
    return [modified copy];
}

- (IBAction)nextQuestionPressed:(id)sender
{
    [self.delegate nextQuestionAfterAnswer:self.isRight];
}

- (IBAction)makeCorrectPressed:(id)sender
{
    self.isRight = !self.isRight;
    self.makeCorrectButton.selected = !self.makeCorrectButton.selected;
}

- (IBAction)addToFavoritePressed:(id)sender
{
    [[DB standardBase] addToFavorite:self.oneRound.currentQuestion.IdByOrder];
}

- (IBAction)endGamePressed:(id)sender
{
    [self.delegate endGameWithLastAnswer:self.isRight];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isRight = [self checkAnswer];
    
    if(self.isRight)
    {
        UIImage *image = [UIImage imageNamed: @"OK.png"];
        [self.correctnessImage setImage:image];
    }
    
    else
    {
        UIImage *image = [UIImage imageNamed: @"Wrong.png"];
        [self.correctnessImage setImage:image];
    }
    
    self.playerAnswer.text = self.oneRound.playerAnswer;
    
    if([self.playerAnswer.text  isEqual: @""])
    {
        [self.makeCorrectButton setEnabled:false];
    }
    
    self.correctAnswer.text = self.oneRound.currentQuestion.answer;
    self.annotationView.text = self.oneRound.currentQuestion.annotation;
    

    
    self.score.text = [NSString stringWithFormat:
                       @"%d : %d",
                       self.oneRound.rightAnswers,
                       self.oneRound.wrongAnswers];
    [self.delegate questionsWatchDog];
}

@end
