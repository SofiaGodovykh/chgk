//
//  QuestionVC.m
//  chgk
//
//  Created by Admin on 05/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "QuestionVC.h"
#import "Question.h"
#import <Parse/Parse.h>

@interface QuestionVC ()

@property (nonatomic, weak) IBOutlet UILabel *score;
@property (nonatomic, weak) IBOutlet UILabel *timer;
@property (nonatomic, weak) IBOutlet UILabel *questionCount;
@property (nonatomic, weak) IBOutlet UITextField *answer;
@property (nonatomic, weak) IBOutlet UITextView *question;
@property (nonatomic, weak) IBOutlet UIButton *confirmButton;
@property (strong) Question *currentQuestion;

@end

@implementation QuestionVC

-(void)dismissKeyboard
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

- (IBAction)confirmPressed:(id)sender
{
    QuestionVC *nextQuestion = [[QuestionVC alloc] init];
    [self.navigationController pushViewController:nextQuestion animated:YES];

}

- (void)downloadSingleQuestion
{
    self.question.text = @"Загрузка вопроса...";
    int ind = arc4random() % 12000;
    NSPredicate *questPredicate = [NSPredicate predicateWithFormat:@"(IdByOrder = %d)",ind];
    PFQuery *questQuery = [PFQuery queryWithClassName:@"Exercise" predicate:questPredicate];
    questQuery.limit = 1;
    [questQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ( (!error) && ([objects count]>0) ){
            self.currentQuestion = [[Question alloc] initWithParseObject:objects[0]];
            self.question.text = self.currentQuestion.question;
        }
        else{
            NSLog(@"Parse.com error: %@ %@", error, [error userInfo]);
            self.question.text = @"Вопрос не загружен :(";
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!!self.navigationController) {
        self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc]initWithTitle:@"Меню"
                                        style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(menuButtonTapped)];;
    }
}

- (void)menuButtonTapped{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(dismissKeyboard)];
    [tapBackground setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:tapBackground];
    [self observeKeyboard];

    
    [self downloadSingleQuestion];
    
}

@end
