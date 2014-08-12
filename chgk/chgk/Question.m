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
    NSLog(@"Please use initWithParseObject: instead");
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
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

- (NSString *)trimString:(NSString *)string
{
    NSString *text = [string stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    text = [text stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    return text;
}

- (NSString *)description
{
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"Вопрос:\n"];
    [text appendString:self.question];
    [text appendString:@"\n\nОтвет:\n"];
    [text appendString:self.answer];
    [text appendString:@"\n\nАннотация:\n"];
    [text appendString:self.annotation];
    [text appendString:@"\n\nАвторы:\n"];
    [text appendString:self.authors];
    [text appendString:@"\n\nИсточники:\n"];
    [text appendString:self.sources];
    return [text copy];
}

@end
