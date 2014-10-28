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

@interface Letter$AP$ : APInternalObject

@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * body;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * weekId;
@property (nonatomic, strong) Week$AP$ * week;

@end