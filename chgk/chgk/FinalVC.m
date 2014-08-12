//
//  FinalVCViewController.m
//  chgk
//
//  Created by Admin on 12/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "FinalVC.h"

@interface FinalVC ()

@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UIButton *startGameButton;
@property (nonatomic, weak) IBOutlet UIButton *statistic;

@end

@implementation FinalVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
