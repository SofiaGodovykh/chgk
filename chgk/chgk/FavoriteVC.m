//
//  FavoriteVC.m
//  chgk
//
//  Created by Semen Ignatov on 12/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import "FavoriteVC.h"
#import "DB.h"
#import "Question.h"

@interface FavoriteVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *questions;

@end

@implementation FavoriteVC

@synthesize questions = questions_;
@synthesize tableView = tableView_;

- (instancetype)initWithQuestions:(NSArray *)questions
{
    if (self = [super init]){
        questions_ = questions;
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
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //TODO: add a table
//    self.label1.text = answers;

    
    
}

- (void)didTouchOKBarButtonItem:(UIBarButtonItem *)sender
{
    [self.delegate favoriteVCdidFinish:self];
}

- (NSInteger)tableView:(UITableView *)tableView
             numberOfRowsInSection:(NSInteger)section
{
    return [self.questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
                     cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReusableCellID";
    UITableViewCell *tableViewCell = [[UITableViewCell alloc]
                                      initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    tableViewCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    tableViewCell.textLabel.font  = [UIFont systemFontOfSize:11];
    tableViewCell.detailTextLabel.font  = [UIFont systemFontOfSize:9];
    tableViewCell.detailTextLabel.textColor = [UIColor darkGrayColor];
    
    NSString *title = [NSString stringWithFormat:@"%ld. %@",
                       indexPath.row+1,
                       [[self.questions objectAtIndex:indexPath.row] answer]];
    tableViewCell.textLabel.text = title;
    tableViewCell.detailTextLabel.text = [[self.questions objectAtIndex:indexPath.row] question];
    return tableViewCell;
}


@end
