#import "APObject+Internal.h"
#import "APObject+Remote.h"
#import "APObject+RemoteID.h"
#import "APObject+Local.h"
#import "APObject+RemoteConfig.h"
#import "APObjectRemoteConfig.h"
#import "Letter.h"
#import "Letter$AP$.h"
#import "Week.h"

@interface Letter ()

@property (nonatomic, strong) Letter$AP$ * internal;

@end

@implementation Letter

@synthesize week = _week;

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

- (NSString *)body {
    return ThreadSafeReturn(^id{
        return self.internal.body;
    });
}

- (void)setBody:(NSString *)body {
    ThreadSafe(^{
        self.internal.body = body;
    });
}

- (NSString *)title {
    return ThreadSafeReturn(^id{
        return self.internal.title;
    });
}

- (void)setTitle:(NSString *)title {
    ThreadSafe(^{
        self.internal.title = title;
    });
}

- (NSString *)weekId {
    return ThreadSafeReturn(^id{
        return self.internal.weekId;
    });
}

- (void)setWeekId:(NSString *)weekId {
    ThreadSafe(^{
        self.internal.weekId = weekId;
    });
}

- (Week *)week {
    if (!_week && self.internal.week) {
        _week = [[Week alloc] initWithInternal:(APInternalObject *)self.internal.week];
    }
    
    return _week;
}

- (void)setWeek:(Week *)week {
    if (_week != week) {
        _week = week;
        
        ThreadSafe(^{
            self.internal.week = (id)week.internal;
        });
    }
}

#pragma mark - NSObject

- (id)initWithInternal:(APInternalObject *)internal {
    if ((self = [super initWithInternal:internal])) {
        [self.class remoteConfig].remoteIDProperty = @"id";
        
    ThreadSafe(^{
        [self addObserver:self forKeyPath:@"internal.week" options:0 context:nil];
    });
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"internal.week"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self && [keyPath isEqualToString:@"internal.week"]) {
        _week = nil;
    } else
 {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
