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
#import "showQuestionVC.h"

@interface AnswerVC () <ShowQuestionVCDelegate>

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

@property (nonatomic,strong) NSRegularExpression *trimmingRegex;

@end

@implementation AnswerVC

@synthesize oneRound = oneRound_;
@synthesize isRight = isRight_;
@synthesize trimmingRegex = trimmingRegex_;

- (NSRegularExpression *)trimmingRegex
{
    if (!trimmingRegex_){
        trimmingRegex_ = [NSRegularExpression
                          regularExpressionWithPattern:@"[^0-9a-zа-я]"
                          options:NSRegularExpressionCaseInsensitive
                          error:nil];
    }
    return trimmingRegex_;
}

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
    if (!!modified){
    [self.trimmingRegex replaceMatchesInString:modified
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
    UIImage *image = [UIImage imageNamed: @"favorite_on.png"];
    [self.addToFavoriteButton.imageView setImage:image];
    [[DB standardBase] addToFavorite:self.oneRound.currentQuestion.IdByOrder];
    self.addToFavoriteButton.selected = YES;
}

- (IBAction)endGamePressed:(id)sender
{
    [self.delegate endGameWithLastAnswer:self.isRight];
}

- (IBAction)showQuestionPressed:(id)sender
{
//    UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc]
//                                             initWithTarget:self
//                                             action:@selector(dismissKeyboard)];
//    
//    UIView *modalView =
//    [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    modalView.opaque = NO;
//    modalView.backgroundColor =
//    [[UIColor blackColor] colorWithAlphaComponent:0.5f];
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"Modal View";
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor whiteColor];
//    label.opaque = NO;
//    [label sizeToFit];
//    [label setCenter:CGPointMake(modalView.frame.size.width / 2,
//                                 modalView.frame.size.height / 4)];
//    [modalView addSubview:label];
//    
//    UITextView *questionText = [[UITextView alloc]init];
//    questionText.text = self.oneRound.currentQuestion.question;
//    questionText.backgroundColor = [UIColor whiteColor];
//    questionText.opaque = NO;
//    questionText.editable = NO;
//    CGRect newFrame = CGRectMake(20, 20, (modalView.frame.size.width-40), (modalView.frame.size.height-40));
//    questionText.frame = newFrame;
////    [questionText setCenter:CGPointMake(modalView.frame.size.width / 2,
////                                 modalView.frame.size.height / 2)];
//    [modalView addSubview:questionText];
//    
////    [self.view addSubview:modalView];

    showQuestionVC *fullQuestionInfo = [[showQuestionVC alloc]initWithQuestionText:self.oneRound.currentQuestion.question];
    fullQuestionInfo.delegate = self;
    [self presentViewController:fullQuestionInfo animated:YES completion:nil];
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
    
    UIImage *image = [UIImage imageNamed: @"favorite_on.png"];
    [self.addToFavoriteButton setImage:image forState: UIControlStateSelected];

    
    [self.delegate questionsWatchDog];
}

@end
