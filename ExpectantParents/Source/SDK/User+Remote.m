#import "APObject+Remote.h"
#import "User+Remote.h"

@implementation User (Remote)

#pragma mark - Public

+ (NSArray *)allError:(NSError **)error {

    return [self query:@"all" params:nil error:error];
}

+ (NSArray *)allWithOffset:(NSUInteger)offset limit:(NSUInteger)limit error:(NSError **)error {

    return [self query:@"all" params:nil offset:offset limit:limit error:error];
}

+ (NSArray *)exactMatchWithParams:(NSDictionary *)params error:(NSError **)error {

    return [self query:@"exact_match" params:params error:error];
}

+ (NSArray *)exactMatchWithParams:(NSDictionary *)params offset:(NSUInteger)offset limit:(NSUInteger)limit error:(NSError **)error {

    return [self query:@"exact_match" params:params offset:offset limit:limit error:error];
}

+ (NSNumber *)countError:(NSError **)error {

    return [self aggregateQuery:@"count" params:nil error:error];
}

+ (NSNumber *)countExactMatchWithParams:(NSDictionary *)params error:(NSError **)error {

    return [self aggregateQuery:@"count_exact_match" params:params error:error];
}

+ (NSArray *)allAsync:(APObjectsCallback)callback {

    return [self query:@"all" params:nil async:callback];
}

+ (NSArray *)allWithOffset:(NSUInteger)offset limit:(NSUInteger)limit async:(APObjectsCallback)callback {

    return [self query:@"all" params:nil offset:offset limit:limit async:callback];
}

+ (NSArray *)exactMatchWithParams:(NSDictionary *)params async:(APObjectsCallback)callback {

    return [self query:@"exact_match" params:params async:callback];
}

+ (NSArray *)exactMatchWithParams:(NSDictionary *)params offset:(NSUInteger)offset limit:(NSUInteger)limit async:(APObjectsCallback)callback {

    return [self query:@"exact_match" params:params offset:offset limit:limit async:callback];
}

+ (void)countAsync:(APObjectsCallback)callback {

    [self aggregateQuery:@"count" params:nil async:callback];
}

+ (void)countExactMatchWithParams:(NSDictionary *)params async:(APObjectsCallback)callback {

    [self aggregateQuery:@"count_exact_match" params:params async:callback];
}

@end