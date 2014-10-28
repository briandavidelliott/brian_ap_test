#import "APObject+Internal.h"
#import "APObject+Remote.h"
#import "APObject+RemoteID.h"
#import "APObject+Local.h"
#import "APObject+RemoteConfig.h"
#import "APObjectRemoteConfig.h"
#import "Week.h"
#import "Week$AP$.h"
#import "Development.h"
#import "Devo.h"
#import "Discuss.h"
#import "Letter.h"
#import "Prayer.h"

@interface Week ()

@property (nonatomic, strong) Week$AP$ * internal;

@end

@implementation Week

@synthesize development = _development;
@synthesize devo = _devo;
@synthesize discuss = _discuss;
@synthesize letter = _letter;
@synthesize prayer = _prayer;

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

- (NSString *)theme {
    return ThreadSafeReturn(^id{
        return self.internal.theme;
    });
}

- (void)setTheme:(NSString *)theme {
    ThreadSafe(^{
        self.internal.theme = theme;
    });
}

- (NSNumber *)weekNumber {
    return ThreadSafeReturn(^id{
        return self.internal.weekNumber;
    });
}

- (void)setWeekNumber:(NSNumber *)weekNumber {
    ThreadSafe(^{
        self.internal.weekNumber = weekNumber;
    });
}

- (Development *)development {
    if (!_development && self.internal.development) {
        _development = [[Development alloc] initWithInternal:(APInternalObject *)self.internal.development];
    }
    
    return _development;
}

- (void)setDevelopment:(Development *)development {
    if (_development != development) {
        _development = development;
        
        ThreadSafe(^{
            self.internal.development = (id)development.internal;
        });
    }
}

- (Devo *)devo {
    if (!_devo && self.internal.devo) {
        _devo = [[Devo alloc] initWithInternal:(APInternalObject *)self.internal.devo];
    }
    
    return _devo;
}

- (void)setDevo:(Devo *)devo {
    if (_devo != devo) {
        _devo = devo;
        
        ThreadSafe(^{
            self.internal.devo = (id)devo.internal;
        });
    }
}

- (Discuss *)discuss {
    if (!_discuss && self.internal.discuss) {
        _discuss = [[Discuss alloc] initWithInternal:(APInternalObject *)self.internal.discuss];
    }
    
    return _discuss;
}

- (void)setDiscuss:(Discuss *)discuss {
    if (_discuss != discuss) {
        _discuss = discuss;
        
        ThreadSafe(^{
            self.internal.discuss = (id)discuss.internal;
        });
    }
}

- (Letter *)letter {
    if (!_letter && self.internal.letter) {
        _letter = [[Letter alloc] initWithInternal:(APInternalObject *)self.internal.letter];
    }
    
    return _letter;
}

- (void)setLetter:(Letter *)letter {
    if (_letter != letter) {
        _letter = letter;
        
        ThreadSafe(^{
            self.internal.letter = (id)letter.internal;
        });
    }
}

- (Prayer *)prayer {
    if (!_prayer && self.internal.prayer) {
        _prayer = [[Prayer alloc] initWithInternal:(APInternalObject *)self.internal.prayer];
    }
    
    return _prayer;
}

- (void)setPrayer:(Prayer *)prayer {
    if (_prayer != prayer) {
        _prayer = prayer;
        
        ThreadSafe(^{
            self.internal.prayer = (id)prayer.internal;
        });
    }
}

#pragma mark - NSObject

- (id)initWithInternal:(APInternalObject *)internal {
    if ((self = [super initWithInternal:internal])) {
        [self.class remoteConfig].remoteIDProperty = @"id";
        
    ThreadSafe(^{
        [self addObserver:self forKeyPath:@"internal.development" options:0 context:nil];
        [self addObserver:self forKeyPath:@"internal.devo" options:0 context:nil];
        [self addObserver:self forKeyPath:@"internal.discuss" options:0 context:nil];
        [self addObserver:self forKeyPath:@"internal.letter" options:0 context:nil];
        [self addObserver:self forKeyPath:@"internal.prayer" options:0 context:nil];
    });
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"internal.development"];
    [self removeObserver:self forKeyPath:@"internal.devo"];
    [self removeObserver:self forKeyPath:@"internal.discuss"];
    [self removeObserver:self forKeyPath:@"internal.letter"];
    [self removeObserver:self forKeyPath:@"internal.prayer"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self && [keyPath isEqualToString:@"internal.development"]) {
        _development = nil;
    } else
    if (object == self && [keyPath isEqualToString:@"internal.devo"]) {
        _devo = nil;
    } else
    if (object == self && [keyPath isEqualToString:@"internal.discuss"]) {
        _discuss = nil;
    } else
    if (object == self && [keyPath isEqualToString:@"internal.letter"]) {
        _letter = nil;
    } else
    if (object == self && [keyPath isEqualToString:@"internal.prayer"]) {
        _prayer = nil;
    } else
 {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
