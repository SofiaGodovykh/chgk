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
#import <Parse/Parse.h>

@interface QuestionVC () <ContinueDelegate>

@property (nonatomic, weak) IBOutlet UILabel *score;
@property (nonatomic, weak) IBOutlet UILabel *timer;
@property (nonatomic, weak) IBOutlet UILabel *questionCount;
@property (nonatomic, weak) IBOutlet UITextField *answer;
@property (nonatomic, weak) IBOutlet UITextView *question;
@property (nonatomic, weak) IBOutlet UIButton *confirmButton;

@property (nonatomic, strong) OneRound *oneRound;

@end

@implementation QuestionVC

@synthesize oneRound = oneRound_;

- (OneRound *)oneRound
{
    if (!oneRound_){
        oneRound_ = [[OneRound alloc]init];
    }

    return oneRound_;
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
    self.view.frame = aRect;
}

#pragma mark dealing with modal windows
- (IBAction)confirmPressed:(id)sender
{
    [self dismissKeyboard];
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
    [self dismissViewControllerAnimated:YES completion:nil];
    self.answer.text = @"";
    isRight == 1? self.oneRound.rightAnswers++ : self.oneRound.wrongAnswers ++;
    self.score.text = [NSString stringWithFormat:
                       @"%d:%d",
                       self.oneRound.rightAnswers,
                       self.oneRound.wrongAnswers ];
    int questCount = self.oneRound.rightAnswers + self.oneRound.wrongAnswers + 1;
    self.questionCount.text = [NSString stringWithFormat:@"№ %d", questCount];
}

- (void)downloadSingleQuestion
{
    self.question.text = @"Загрузка вопроса...";
    int ind = arc4random() % 10219;
    NSPredicate *questPredicate = [NSPredicate predicateWithFormat:@"(IdByOrder = %d)",ind];
    PFQuery *questQuery = [PFQuery queryWithClassName:@"Exercise" predicate:questPredicate];
    questQuery.limit = 1;
    [questQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ( (!error) && ([objects count]>0) ){
            self.oneRound.currentQuestion = [[Question alloc] initWithParseObject:objects[0]];
            self.question.text = self.oneRound.currentQuestion.question;
        }
        else{
            NSLog(@"Parse.com error: %@ %@", error, [error userInfo]);
            self.question.text = [NSString stringWithFormat:@"Вопрос %d не загружен :(", ind];
        }
    }];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
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
    }

}

@end
