//
//  NSData+JSON.m
//  Created by AnyPresence, Inc. on 11/8/12.
//
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

#pragma mark - Public

- (id)objectFromJSON {
    NSError * error = nil;
    return [self objectFromJSONError:&error];
}

- (id)objectFromJSONError:(NSError **)error {
    return [NSJSONSerialization JSONObjectWithData:self
                                           options:NSJSONReadingAllowFragments
                                             error:error];
}

+ (NSData *)dataFromObject:(id)object {
    NSError * error = nil;
    return [self dataFromObject:object error:&error];
}

+ (NSData *)dataFromObject:(id)object error:(NSError **)error {
    return [NSJSONSerialization dataWithJSONObject:object
                                           options:0
                                             error:error];
}

@end