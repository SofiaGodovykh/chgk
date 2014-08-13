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
@property (nonatomic, weak) IBOutlet UILabel *label1;
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
    // CR: Don't use the description property for anything besides debugging.
    self.textView.text = [self.question fullInfo];
//    
//    self.label1.text = [self.question fullInfo];
//    CGRect newFrame = self.label1.frame;
//    CGSize labelSize = [self.label1 sizeThatFits:CGSizeMake(newFrame.size.width, CGFLOAT_MAX)];
//    [self.label1 sizeToFit];
}

- (void)didTouchOKBarButtonItem:(UIBarButtonItem *)sender
{
    [self.delegate FullQuestionInfoVCdidFinish:self];
}



@end
