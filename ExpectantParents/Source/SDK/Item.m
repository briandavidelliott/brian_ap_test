#import "APObject+Internal.h"
#import "APObject+Remote.h"
#import "APObject+RemoteID.h"
#import "APObject+Local.h"
#import "APObject+RemoteConfig.h"
#import "APObjectRemoteConfig.h"
#import "Item.h"
#import "Item$AP$.h"
#import "Section.h"

@interface Item ()

@property (nonatomic, strong) Item$AP$ * internal;

@end

@implementation Item

@synthesize section = _section;

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

- (NSString *)sectionId {
    return ThreadSafeReturn(^id{
        return self.internal.sectionId;
    });
}

- (void)setSectionId:(NSString *)sectionId {
    ThreadSafe(^{
        self.internal.sectionId = sectionId;
    });
}

- (NSString *)value {
    return ThreadSafeReturn(^id{
        return self.internal.value;
    });
}

- (void)setValue:(NSString *)value {
    ThreadSafe(^{
        self.internal.value = value;
    });
}

- (Section *)section {
    if (!_section && self.internal.section) {
        _section = [[Section alloc] initWithInternal:(APInternalObject *)self.internal.section];
    }
    
    return _section;
}

- (void)setSection:(Section *)section {
    if (_section != section) {
        _section = section;
        
        ThreadSafe(^{
            self.internal.section = (id)section.internal;
        });
    }
}

#pragma mark - NSObject

- (id)initWithInternal:(APInternalObject *)internal {
    if ((self = [super initWithInternal:internal])) {
        [self.class remoteConfig].remoteIDProperty = @"id";
        
    ThreadSafe(^{
        [self addObserver:self forKeyPath:@"internal.section" options:0 context:nil];
    });
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"internal.section"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self && [keyPath isEqualToString:@"internal.section"]) {
        _section = nil;
    } else
 {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
