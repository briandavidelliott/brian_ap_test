//
//  MyValInternal.h
//  AnyPresence SDK
//
//  Created by Ruslan Sokolov on 9/7/13.
//  Copyright (c) 2013 AnyPresence, Inc. All rights reserved.
//

#import "APInternalObject.h"
#import "Typedefs.h"


@interface User$AP$ : APInternalObject

@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * authToken;
@property (nonatomic, strong) NSString * babyGender;
@property (nonatomic, strong) NSString * babyName;
@property (nonatomic, strong) NSString * changedPassword;
@property (nonatomic, strong) NSString * country;
@property (nonatomic, strong) NSDate * dueDate;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSArray * favorites;
@property (nonatomic, strong) NSDate * favoritesLastUpdated;
@property (nonatomic, strong) NSString * firstName;
@property (nonatomic, strong) NSString * lastName;
@property (nonatomic, strong) NSNumber * optIn;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * provider;
@property (nonatomic, strong) NSNumber * purchased;
@property (nonatomic, strong) NSString * role;
@property (nonatomic, strong) NSString * sessionSecret;
@property (nonatomic, strong) NSString * sessionToken;
@property (nonatomic, strong) NSString * sourceCode;
@property (nonatomic, strong) NSNumber * terms;
@property (nonatomic, strong) NSArray * todos;
@property (nonatomic, strong) NSString * xSessionId;

@end