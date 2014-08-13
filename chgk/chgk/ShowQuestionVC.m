//
//  showQuestionVC.m
//  chgk
//
//  Created by Admin on 13/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ShowQuestionVC.h"

@interface ShowQuestionVC ()

@property (nonatomic, weak) IBOutlet UITextView *fullText;
@property (nonatomic, weak) IBOutlet UIView *viewWithText;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (nonatomic, weak) IBOutlet UIButton *okButton;
@property (nonatomic, strong) NSString *text;
@end

@implementation ShowQuestionVC
@synthesize text = text_;

- (instancetype)initWithQuestionText:(NSString *)text
{
    if (self = [super init]){
        text_ = text;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewWithText.layer.cornerRadius = 5;
    self.viewWithText.layer.masksToBounds = YES;
    self.fullText.text = self.text;
    CGSize sizeThatFitsTextView = [self.fullText sizeThatFits:
                                       CGSizeMake(self.fullText.frame.size.width, MAXFLOAT)];

    self.textViewHeightConstraint.constant = ceilf(MIN(sizeThatFitsTextView.height,422)) +
                                                self.okButton.frame.size.height;
    UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(tappedInBackground)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];
}

- (void)tappedInBackground
{
    [self.delegate showQuestionVCDidFinished:self];
}

- (IBAction)okButtonPressed:(id)sender
{
    [self.delegate showQuestionVCDidFinished:self];
}

@end
