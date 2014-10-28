#import "APObject+Internal.h"
#import "APObject+Remote.h"
#import "APObject+RemoteID.h"
#import "APObject+Local.h"
#import "APObject+RemoteConfig.h"
#import "APObjectRemoteConfig.h"
#import "ToDoList.h"
#import "ToDoList$AP$.h"
#import "Section.h"

@interface ToDoList ()

@property (nonatomic, strong) ToDoList$AP$ * internal;

@end

@implementation ToDoList

@synthesize sections = _sections;

#pragma mark - Public

- (NSString *)id {
    return ThreadSafeReturn(^id{
        return self.internal.id;
    });
}

- (void)setId:(NSString *)id {
    ThreadSafe(^{
        self.internal.id = id;
    });
}

- (NSString *)name {
    return ThreadSafeReturn(^id{
        return self.internal.name;
    });
}

- (void)setName:(NSString *)name {
    ThreadSafe(^{
        self.internal.name = name;
    });
}

- (NSNumber *)order {
    return ThreadSafeReturn(^id{
        return self.internal.order;
    });
}

- (void)setOrder:(NSNumber *)order {
    ThreadSafe(^{
        self.internal.order = order;
    });
}

- (NSOrderedSet *)sections {
    if (!_sections) {
        _sections = ThreadSafeReturn(^{
            NSMutableOrderedSet * set = [[NSMutableOrderedSet alloc] initWithCapacity:self.internal.sections.count];
            for (APInternalObject * internal in self.internal.sections) {
                Section * obj = [[Section alloc] initWithInternal:internal];
                [set addObject:obj];
            }
            
            return [set copy];
        });
    }
    
    return _sections;
}

- (void)setSections:(NSOrderedSet *)sections {
    if (_sections != sections) {
        _sections = sections;
        
        NSMutableOrderedSet * set = [[NSMutableOrderedSet alloc] initWithCapacity:sections.count];
        for (Section * obj in sections) {
            [set addObject:obj.internal];
        }
        
        ThreadSafe(^{
            self.internal.sections = [set copy];
        });
    }
}

#pragma mark - NSObject

- (id)initWithInternal:(APInternalObject *)internal {
    if ((self = [super initWithInternal:internal])) {
        [self.class remoteConfig].remoteIDProperty = @"id";
        
    ThreadSafe(^{
        [self addObserver:self forKeyPath:@"internal.sections" options:0 context:nil];
    });
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"internal.sections"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self && [keyPath isEqualToString:@"internal.sections"]) {
        _sections = nil;
    } else
 {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
