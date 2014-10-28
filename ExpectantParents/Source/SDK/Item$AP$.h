//
//  MyValInternal.h
//  AnyPresence SDK
//
//  Created by Ruslan Sokolov on 9/7/13.
//  Copyright (c) 2013 AnyPresence, Inc. All rights reserved.
//

#import "APInternalObject.h"
#import "Typedefs.h"

@class Section$AP$;

@interface Item$AP$ : APInternalObject

@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSNumber * order;
@property (nonatomic, strong) NSString * sectionId;
@property (nonatomic, strong) NSString * value;
@property (nonatomic, strong) Section$AP$ * section;

@end