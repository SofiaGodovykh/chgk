//
//  FullQuestionInfoVC.m
//  chgk
//
//  Created by Semen Ignatov on 12/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import "FullQuestionInfoVC.h"
#import "Question.h"

@interface FullQuestionInfoVC ()

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, strong) Question *question;

@end

@implementation FullQuestionInfoVC
@synthesize question = question_;

- (instancetype)initWithQuestion:(Question *)question
{
    if (self = [super init]){
        question_ = question;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!!self.navigationItem) {
        UIBarButtonItem *const okBarButtonItem =
        [[UIBarButtonItem alloc]initWithTitle:@"OK"
                                        style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(didTouchOKBarButtonItem:)];;
        [self.navigationItem setRightBarButtonItem:okBarButtonItem];
    }
    
    self.textView.text = [self.question description];
    
}

- (void)didTouchOKBarButtonItem:(UIBarButtonItem *)sender
{
    [self.delegate FullQuestionInfoVCdidFinish:self];
}



@end
