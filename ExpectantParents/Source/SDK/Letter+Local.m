#import "APObject+Local.h"
#import "Letter+Local.h"

@implementation Letter (Local)

#pragma mark - Public

+ (NSArray *)allLocalWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {

    return [self queryLocal:@"all" params:nil offset:offset limit:limit];
}

+ (NSArray *)exactMatchLocalWithParams:(NSDictionary *)params offset:(NSUInteger)offset limit:(NSUInteger)limit {

    return [self queryLocal:@"exact_match" params:params offset:offset limit:limit];
}

@end