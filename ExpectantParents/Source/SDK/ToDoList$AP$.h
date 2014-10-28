//
//  MyValInternal.h
//  AnyPresence SDK
//
//  Created by Ruslan Sokolov on 9/7/13.
//  Copyright (c) 2013 AnyPresence, Inc. All rights reserved.
//

#import "APInternalObject.h"
#import "Typedefs.h"


@interface ToDoList$AP$ : APInternalObject

@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSNumber * order;
@property (nonatomic, strong) NSOrderedSet * sections;

@end