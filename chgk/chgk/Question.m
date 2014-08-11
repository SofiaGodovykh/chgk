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
        question_ = object[@"Question"];
        answer_ = object[@"Answer"];
        annotation_ = object[@"Annotation"];
        authors_ = object[@"Authors"];
        sources_ = object[@"Sources"];
        pictureName_ = object[@"PictureName"];
        ID_ = [object[@"Id"] intValue];
        IdByOrder_ = [object[@"IdByOrder"] intValue];
        
    }
    
    return self;
}

@end
