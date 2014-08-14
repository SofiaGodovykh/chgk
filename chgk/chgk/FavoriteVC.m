//
//  FavoriteVC.m
//  chgk
//
//  Created by Semen Ignatov on 12/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import "FavoriteVC.h"
#import "DB.h"
#import "FullQuestionInfoVC.h"
#import "Question.h"

@class MenuVC;

@interface FavoriteVC () <UITableViewDelegate, UITableViewDataSource, FullQuestionInfoVCDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *questions;
@property (nonatomic) BOOL isDeletable;

@end

@implementation FavoriteVC

@synthesize questions = questions_;
@synthesize tableView = tableView_;
@synthesize isDeletable = isDeletable_;

- (instancetype)initWithQuestions:(NSArray *)questions deletable:(BOOL)isDeletable
{
    if (self = [super init]){
        questions_ = questions;
        isDeletable_ = isDeletable;
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
//    self.tableView
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
                     cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReusableCellID";
    UITableViewCell *tableViewCell = [[UITableViewCell alloc]
                                      initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    tableViewCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    tableViewCell.textLabel.font  = [UIFont systemFontOfSize:12];
    tableViewCell.detailTextLabel.font  = [UIFont systemFontOfSize:10];
    tableViewCell.detailTextLabel.textColor = [UIColor darkGrayColor];
    
    NSString *title = [NSString stringWithFormat:@"%ld. %@",
                       indexPath.row+1,
                       [[self.questions objectAtIndex:indexPath.row] answer]];
    tableViewCell.textLabel.text = title;
    tableViewCell.detailTextLabel.text = [[self.questions objectAtIndex:indexPath.row] question];
    tableViewCell.detailTextLabel.numberOfLines = 4;
    if (self.isDeletable){
        [tableViewCell setEditing:UITableViewCellEditingStyleDelete];
    }else{
        [tableViewCell setEditing:UITableViewCellEditingStyleInsert];
    }
    return tableViewCell;
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FullQuestionInfoVC *const viewController = [[FullQuestionInfoVC alloc]
                                                         initWithQuestion:self.questions[indexPath.row]];
    viewController.delegate = self;
    UINavigationController *const navigationController =
    [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:NULL];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)FullQuestionInfoVCdidFinish:(FullQuestionInfoVC *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView
        commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //action after delete button is pressed
        if (self.isDeletable){
            NSMutableArray *mutableQuestions = [self.questions mutableCopy];
            
            Question *questionToDelete = mutableQuestions[indexPath.row];
            [[DB standardBase] removeFromFavorite:questionToDelete.IdByOrder];

            [mutableQuestions removeObjectAtIndex:indexPath.row];
            self.questions = [mutableQuestions copy];
            
            [self.tableView reloadData];
        }
        else {
            UIAlertView *quickInfoAlert = [[UIAlertView alloc] initWithTitle:@"Эй!"
                                                                     message:@"Не пытайтесь изменить ход истории!"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
            [quickInfoAlert show];
        }
    }
}

@end
