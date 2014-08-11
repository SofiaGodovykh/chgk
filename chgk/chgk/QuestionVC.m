//
//  QuestionVC.m
//  chgk
//
//  Created by Admin on 05/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "QuestionVC.h"
#import "AnswerVC.h"
#import "OneRound.h"
#import "Question.h"
#import "MenuVC.h"
#import "ContinueDelegate.h"
#import "DB.h"
#import <Parse/Parse.h>

static const NSUInteger TimerMaximumSeconds = 60;
static NSString *const DefaultFileNameForLocalStore = @"PlayedQuestionsAndScore.dat";
static NSString *const kWinsKey = @"wins";
static NSString *const kLoosesKey = @"looses";
static NSString *const kPlayedKey = @"score";

@interface QuestionVC () <ContinueDelegate>

@property (nonatomic, weak) IBOutlet UILabel *score;
@property (nonatomic, weak) IBOutlet UILabel *timerLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionCount;
@property (nonatomic, weak) IBOutlet UITextField *answer;
@property (nonatomic, weak) IBOutlet UITextView *question;
@property (nonatomic, weak) IBOutlet UIButton *confirmButton;
//@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property int seconds;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) OneRound *oneRound;
@property (nonatomic, strong) NSMutableArray *playedQuestions;
@property (nonatomic, strong) NSURL *persistanceURL;
@end

@implementation QuestionVC

@synthesize oneRound = oneRound_;
@synthesize timer = timer_;
@synthesize playedQuestions = playedQuestions_;
@synthesize persistanceURL = persistanceURL_;

#pragma mark initialization and lazy getters
- (OneRound *)oneRound
{
    if (!oneRound_){
        oneRound_ = [[OneRound alloc]init];
    }

    return oneRound_;
}

- (NSMutableArray *)playedQuestions
{
    if (!playedQuestions_){
        playedQuestions_ = [NSMutableArray array];
    }
    return playedQuestions_;
}

- (NSURL *)persistanceURL
{
    if (!persistanceURL_) {
        NSURL *const documentDirectoryURL =
        [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory
                                                inDomains:NSUserDomainMask] lastObject];
        persistanceURL_ =
        [documentDirectoryURL URLByAppendingPathComponent:DefaultFileNameForLocalStore];
    }
    
    return persistanceURL_;
}

#pragma mark showing and hiding keyboard
- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize kbSize = [[[notification userInfo]
                      objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    self.view.frame = aRect;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGSize kbSize = [[[notification userInfo]
                      objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect aRect = self.view.frame;
    aRect.size.height += kbSize.height;
    // CR: Don't change self.view frame, it is managed by a superview, add a subview with all
    // content and resize it.
    self.view.frame = aRect;
}

#pragma mark dealing with modal windows
- (IBAction)confirmPressed:(id)sender
{
    [self.playedQuestions addObject:[NSNumber numberWithInteger:
                                     self.oneRound.currentQuestion.IdByOrder]];
    [self dismissKeyboard];
    [self stopTimer];
    self.oneRound.playerAnswer = self.answer.text;
//TODO: send copy of oneRound
    AnswerVC *modalAnswer = [[AnswerVC alloc]initWithRound:self.oneRound];
    modalAnswer.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    modalAnswer.delegate = self;
    [self presentViewController:modalAnswer
                       animated:YES
                     completion:nil];
}

- (void)menuButtonTapped{
    MenuVC *modalmenu = [[MenuVC alloc]init];
    modalmenu.delegate = self;
    
    [self presentViewController:modalmenu
                       animated:YES
                     completion:nil];
}

- (void)removeMenu
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)nextQuestionAfterAnswer:(BOOL)isRight
{
    self.timerLabel.text = @"01:00";
    [self dismissViewControllerAnimated:YES completion:nil];
    self.answer.text = @"";
    isRight == 1? self.oneRound.rightAnswers++ : self.oneRound.wrongAnswers ++;
    [self startTimer];
    [self refreshScoreLabel];
    [self saveScore];
}

#pragma mark working with database
- (void)downloadSingleQuestion
{
    self.question.text = @"Загрузка вопроса...";
    int ind = arc4random() % 17589;
//    ind = 9507; //for test
    NSLog(@"Downloading %d question...", ind);
    NSPredicate *questPredicate = [NSPredicate predicateWithFormat:@"(IdByOrder > %d)",ind];
    PFQuery *questQuery = [PFQuery queryWithClassName:@"Exercise" predicate:questPredicate];
    questQuery.limit = 1000;
    [questQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ( (!error) && ([objects count]>0) ){

            DB *database = [DB standardBase];
            if ([database countOfItemsInExercise] < 50000 ){
            
                NSMutableArray *someQuestions = [NSMutableArray array];
                for (PFObject *object in objects){
                    [someQuestions addObject:[[Question alloc] initWithParseObject:object]];
                }
                
                [database addItemsInExercise:[someQuestions copy]];
            }

            self.oneRound.currentQuestion = [[Question alloc] initWithParseObject:objects[0]];
            NSString *text = [self.oneRound.currentQuestion.question
                              stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
            text = [text stringByReplacingOccurrencesOfString:@"  " withString:@" "];
            self.question.text = text;
        }
        else{
            NSLog(@"Parse.com error: %@ %@", error, [error userInfo]);
            self.question.text = [NSString stringWithFormat:@"Вопрос %d не загружен :(", ind];
        }
    }];
}

#pragma mark timer work
-(void)startTimer
{
    if(!!self.timer){
        [self stopTimer];
    }
    self.seconds = TimerMaximumSeconds;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(refreshTimeLabel:)
                                                userInfo:nil
                                                 repeats:YES];
    NSLog(@"starttimer");
}

-(void)refreshTimeLabel:(id)sender
{
    if(![self.timer isValid])
        return;
    
    if(!self.timer){
        [self stopTimer];
        return;
    }
    self.seconds--;
    NSMutableString *time = [NSMutableString stringWithFormat:@"00:%02d", self.seconds];

    self.timerLabel.text = [NSString stringWithFormat:@"%@", time];
    NSLog(@"%@", time);
    if(self.seconds == 0 && !!self.timer) //when the minute expired
    {
        [self confirmPressed:nil];
        [self stopTimer];
        NSLog(@"seconds os over");
        
    }
}

- (void)refreshScoreLabel
{
    self.score.text = [NSString stringWithFormat:
                       @"%d:%d",
                       self.oneRound.rightAnswers,
                       self.oneRound.wrongAnswers ];
    int questCount = self.oneRound.rightAnswers + self.oneRound.wrongAnswers + 1;
    self.questionCount.text = [NSString stringWithFormat:@"№ %d", questCount];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshScoreLabel];
    if (!!self.navigationController) {
        self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc]initWithTitle:@"Меню"
                                        style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(menuButtonTapped)];;
    }
    UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(dismissKeyboard)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];
    [self observeKeyboard];
    if (!self.oneRound.currentQuestion) {
        [self downloadSingleQuestion];
        [self startTimer];
        [self saveScore];
    }
}

#pragma mark persistance functions
- (void)continuePreviousGame
{
    NSDictionary *oldData = [NSDictionary dictionaryWithContentsOfURL:self.persistanceURL];
    if (!!oldData){
        self.oneRound.wrongAnswers = [[oldData objectForKey:kLoosesKey] intValue];
        self.oneRound.rightAnswers = [[oldData objectForKey:kWinsKey] intValue];
        self.playedQuestions = [oldData objectForKey:self.playedQuestions];
    }
}

- (void)saveScore
{
    NSDictionary *saveData = @{kWinsKey   : [NSNumber numberWithInteger:self.oneRound.rightAnswers],
                               kLoosesKey : [NSNumber numberWithInteger:self.oneRound.wrongAnswers],
                               kPlayedKey : self.playedQuestions};
    [saveData writeToURL:self.persistanceURL atomically:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

//this could be used later for picture viewing
//- (void)textViewDidChange:(UITextView *)textView
//{
//    CGSize sizeThatFitsTextView = [textView sizeThatFits:
//                                   CGSizeMake(textView.frame.size.width, MAXFLOAT)];
//
//    self.textViewHeightConstraint.constant = ceilf(MIN(sizeThatFitsTextView.height,422));
//}
@end
