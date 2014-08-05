//
//  QuestionVC.m
//  chgk
//
//  Created by Admin on 05/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "QuestionVC.h"

@interface QuestionVC ()

@property (nonatomic, weak) IBOutlet UILabel *score;
@property (nonatomic, weak) IBOutlet UILabel *timer;
@property (nonatomic, weak) IBOutlet UILabel *questionCount;
@property (nonatomic, weak) IBOutlet UITextField *answer;
@property (nonatomic, weak) IBOutlet UITextView *question;
@property (nonatomic, weak) IBOutlet UIButton *confirmButton;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(dismissKeyboard)];
    [tapBackground setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:tapBackground];
    [self observeKeyboard];
    // Do any additional setup after loading the view from its nib.
}

@end
