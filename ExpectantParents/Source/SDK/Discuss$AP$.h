//
//  MyValInternal.h
//  AnyPresence SDK
//
//  Created by Ruslan Sokolov on 9/7/13.
//  Copyright (c) 2013 AnyPresence, Inc. All rights reserved.
//

#import "APInternalObject.h"
#import "Typedefs.h"

@class Week$AP$;

@interface Discuss$AP$ : APInternalObject

@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSArray * items;
@property (nonatomic, strong) NSString * weekId;
@property (nonatomic, strong) Week$AP$ * week;

@end