#import "APObject+Internal.h"
#import "APObject+Remote.h"
#import "APObject+RemoteID.h"
#import "APObject+Local.h"
#import "APObject+RemoteConfig.h"
#import "APObjectRemoteConfig.h"
#import "Section.h"
#import "Section$AP$.h"
#import "Item.h"
#import "ToDoList.h"

@interface Section ()

@property (nonatomic, strong) Section$AP$ * internal;

@end

@implementation Section

@synthesize items = _items;
@synthesize toDoList = _toDoList;

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

- (NSString *)toDoListId {
    return ThreadSafeReturn(^id{
        return self.internal.toDoListId;
    });
}

- (void)setToDoListId:(NSString *)toDoListId {
    ThreadSafe(^{
        self.internal.toDoListId = toDoListId;
    });
}

- (NSOrderedSet *)items {
    if (!_items) {
        _items = ThreadSafeReturn(^{
            NSMutableOrderedSet * set = [[NSMutableOrderedSet alloc] initWithCapacity:self.internal.items.count];
            for (APInternalObject * internal in self.internal.items) {
                Item * obj = [[Item alloc] initWithInternal:internal];
                [set addObject:obj];
            }
            
            return [set copy];
        });
    }
    
    return _items;
}

- (void)setItems:(NSOrderedSet *)items {
    if (_items != items) {
        _items = items;
        
        NSMutableOrderedSet * set = [[NSMutableOrderedSet alloc] initWithCapacity:items.count];
        for (Item * obj in items) {
            [set addObject:obj.internal];
        }
        
        ThreadSafe(^{
            self.internal.items = [set copy];
        });
    }
}

- (ToDoList *)toDoList {
    if (!_toDoList && self.internal.toDoList) {
        _toDoList = [[ToDoList alloc] initWithInternal:(APInternalObject *)self.internal.toDoList];
    }
    
    return _toDoList;
}

- (void)setToDoList:(ToDoList *)toDoList {
    if (_toDoList != toDoList) {
        _toDoList = toDoList;
        
        ThreadSafe(^{
            self.internal.toDoList = (id)toDoList.internal;
        });
    }
}

#pragma mark - NSObject

- (id)initWithInternal:(APInternalObject *)internal {
    if ((self = [super initWithInternal:internal])) {
        [self.class remoteConfig].remoteIDProperty = @"id";
        
    ThreadSafe(^{
        [self addObserver:self forKeyPath:@"internal.items" options:0 context:nil];
        [self addObserver:self forKeyPath:@"internal.toDoList" options:0 context:nil];
    });
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"internal.items"];
    [self removeObserver:self forKeyPath:@"internal.toDoList"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self && [keyPath isEqualToString:@"internal.items"]) {
        _items = nil;
    } else
    if (object == self && [keyPath isEqualToString:@"internal.toDoList"]) {
        _toDoList = nil;
    } else
 {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
