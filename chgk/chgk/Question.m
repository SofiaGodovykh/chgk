//
//  Question.m
//  chgk
//
//  Created by Semen Ignatov on 05/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import "Question.h"
#import "Parse/Parse.h"

@interface Question()

@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, copy) NSString *annotation;
@property (nonatomic, copy) NSString *authors;
@property (nonatomic, copy) NSString *sources;
@property (nonatomic, copy) NSString *pictureName;
@property (nonatomic) NSInteger ID;
@property (nonatomic) NSInteger IdByOrder;

@end

@implementation Question

@synthesize question = question_;
@synthesize answer = answer_;
@synthesize annotation = annotation_;
@synthesize authors = authors_;
@synthesize sources = sources_;
@synthesize pictureName = pictureName_;
@synthesize ID = ID_;
@synthesize IdByOrder = IdByOrder_;

- (id)init
{
    NSLog(@"Please use initWithParseObject: or initWithDictionary: instead");
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

/**
 *  Removes double spaces and new line characters from string
 */
- (NSString *)trimString:(NSString *)string
{
    NSString *text = [string stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    text = [text stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    return text;
}

- (instancetype)initWithParseObject:(PFObject *)object
{
    if (self = [super init]){
        question_ = [self trimString:object[@"Question"]];
        answer_ = [self trimString:object[@"Answer"]];
        annotation_ = [self trimString:object[@"Annotation"]];
        authors_ = [self trimString:object[@"Authors"]];
        sources_ = object[@"Sources"];
        NSString *picName = object[@"PictureName"];
        if (!picName){
            picName = @"";
        }
        pictureName_ = [self trimString:picName];
        ID_ = [object[@"Id"] intValue];
        IdByOrder_ = [object[@"IdByOrder"] intValue];
        
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self=[super init]){
        question_ = [self trimString:[dictionary objectForKey:@"question"]];
        answer_ = [self trimString:[dictionary objectForKey:@"answer"]];
        annotation_ = [self trimString:[dictionary objectForKey:@"annotation"]];
        authors_ = [self trimString:[dictionary objectForKey:@"authors"]];
        sources_ = [dictionary objectForKey:@"sources"];
        pictureName_ = [self trimString:[dictionary objectForKey:@"picture"]];
        ID_ = [[dictionary objectForKey:@"id"] integerValue];
        IdByOrder_ = [[dictionary objectForKey:@"idByOrder"] integerValue];
    }
    
    return self;
}

- (NSMutableAttributedString *)addFontAttribute:(UIFont *)font
                                       toString:(NSString *)inputString
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
                                         initWithString:inputString];
    [string beginEditing];
    [string addAttribute:NSFontAttributeName
                   value:font
                   range:NSMakeRange(0, [inputString length])];
    
    [string endEditing];
    
    return string;
}

- (NSMutableAttributedString *)fullInfoWithMainFont:(UIFont *)mainFont
                                       andTitleFont:(UIFont *)boldFont
{
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];

    [result appendAttributedString:[self addFontAttribute:boldFont toString:@"Вопрос:\n"]];
    [result appendAttributedString:[self addFontAttribute:mainFont toString:self.question]];
    [result appendAttributedString:[self addFontAttribute:boldFont toString:@"\n\nОтвет:\n"]];
    [result appendAttributedString:[self addFontAttribute:mainFont toString:self.answer]];
    [result appendAttributedString:[self addFontAttribute:boldFont toString:@"\n\nАннотация:\n"]];
    [result appendAttributedString:[self addFontAttribute:mainFont toString:self.annotation]];
    [result appendAttributedString:[self addFontAttribute:boldFont toString:@"\n\nАвторы:\n"]];
    [result appendAttributedString:[self addFontAttribute:mainFont toString:self.authors]];
    [result appendAttributedString:[self addFontAttribute:boldFont toString:@"\n\nИсточники:\n"]];
    [result appendAttributedString:[self addFontAttribute:mainFont toString:self.sources]];

    return result;
}

- (id)copyWithZone:(NSZone *)zone
{
    Question *copy = [[Question alloc]initWithDictionary:nil];
    [copy setQuestion:self.question];
    [copy setAnswer:self.answer];
    [copy setAnnotation:self.annotation];
    [copy setAuthors:self.authors];
    [copy setSources:self.sources];
    [copy setPictureName:self.pictureName];
    [copy setID:self.ID];
    [copy setIdByOrder:self.IdByOrder];

    return copy;
}

@end
