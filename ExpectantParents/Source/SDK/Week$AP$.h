//
//  MyValInternal.h
//  AnyPresence SDK
//
//  Created by Ruslan Sokolov on 9/7/13.
//  Copyright (c) 2013 AnyPresence, Inc. All rights reserved.
//

#import "APInternalObject.h"
#import "Typedefs.h"

@class Development$AP$;
@class Devo$AP$;
@class Discuss$AP$;
@class Letter$AP$;
@class Prayer$AP$;

@interface Week$AP$ : APInternalObject

@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * theme;
@property (nonatomic, strong) NSNumber * weekNumber;
@property (nonatomic, strong) Development$AP$ * development;
@property (nonatomic, strong) Devo$AP$ * devo;
@property (nonatomic, strong) Discuss$AP$ * discuss;
@property (nonatomic, strong) Letter$AP$ * letter;
@property (nonatomic, strong) Prayer$AP$ * prayer;

@end