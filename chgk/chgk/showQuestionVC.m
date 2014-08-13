//
//  showQuestionVC.m
//  chgk
//
//  Created by Admin on 13/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "showQuestionVC.h"

@interface showQuestionVC ()

@property (nonatomic, weak) IBOutlet UITextView *fullText;
@property (nonatomic, strong) NSString *text;
@end

@implementation showQuestionVC
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
    self.fullText.text = self.text;
}

@end
