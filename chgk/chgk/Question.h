//
//  Question.h
//  chgk
//
//  Created by Semen Ignatov on 05/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFObject;

@interface Question : NSObject <NSCopying>

@property (nonatomic, copy, readonly) NSString *question;
@property (nonatomic, copy, readonly) NSString *answer;
@property (nonatomic, copy, readonly) NSString *annotation;
@property (nonatomic, copy, readonly) NSString *authors;
@property (nonatomic, copy, readonly) NSString *sources;
@property (nonatomic, copy, readonly) NSString *pictureName;
@property (nonatomic, readonly) NSInteger ID;
@property (nonatomic, readonly) NSInteger IdByOrder;

- (instancetype)initWithParseObject:(PFObject *)object;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (id)init NS_UNAVAILABLE;
- (NSMutableAttributedString *)fullInfoWithMainFont:(UIFont *)mainFont andBoldFont:(UIFont *)boldFont;

@end
