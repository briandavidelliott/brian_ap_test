//
//  NSObject+Reflection.h
//  AnyPresence SDK
//
//  Created by Ruslan Sokolov on 3/31/13.
//  Copyright (c) 2013 AnyPresence, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Reflection)

- (id)encodeValue:(id)value ofType:(Class)type;
- (id)decodeValue:(id)string ofType:(Class)type;

@end
