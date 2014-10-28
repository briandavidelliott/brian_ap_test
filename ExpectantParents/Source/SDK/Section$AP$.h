//
//  MyValInternal.h
//  AnyPresence SDK
//
//  Created by Ruslan Sokolov on 9/7/13.
//  Copyright (c) 2013 AnyPresence, Inc. All rights reserved.
//

#import "APInternalObject.h"
#import "Typedefs.h"

@class ToDoList$AP$;

@interface Section$AP$ : APInternalObject

@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSNumber * order;
@property (nonatomic, strong) NSString * toDoListId;
@property (nonatomic, strong) NSOrderedSet * items;
@property (nonatomic, strong) ToDoList$AP$ * toDoList;

@end