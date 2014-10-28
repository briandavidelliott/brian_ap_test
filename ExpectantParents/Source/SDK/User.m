#import "APObject+Internal.h"
#import "APObject+Remote.h"
#import "APObject+RemoteID.h"
#import "APObject+Local.h"
#import "APObject+RemoteConfig.h"
#import "APObjectRemoteConfig.h"
#import "User.h"
#import "User$AP$.h"

@interface User ()

@property (nonatomic, strong) User$AP$ * internal;

@end

@implementation User


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

- (NSString *)authToken {
    return ThreadSafeReturn(^id{
        return self.internal.authToken;
    });
}

- (void)setAuthToken:(NSString *)authToken {
    ThreadSafe(^{
        self.internal.authToken = authToken;
    });
}

- (NSString *)babyGender {
    return ThreadSafeReturn(^id{
        return self.internal.babyGender;
    });
}

- (void)setBabyGender:(NSString *)babyGender {
    ThreadSafe(^{
        self.internal.babyGender = babyGender;
    });
}

- (NSString *)babyName {
    return ThreadSafeReturn(^id{
        return self.internal.babyName;
    });
}

- (void)setBabyName:(NSString *)babyName {
    ThreadSafe(^{
        self.internal.babyName = babyName;
    });
}

- (NSString *)changedPassword {
    return ThreadSafeReturn(^id{
        return self.internal.changedPassword;
    });
}

- (void)setChangedPassword:(NSString *)changedPassword {
    ThreadSafe(^{
        self.internal.changedPassword = changedPassword;
    });
}

- (NSString *)country {
    return ThreadSafeReturn(^id{
        return self.internal.country;
    });
}

- (void)setCountry:(NSString *)country {
    ThreadSafe(^{
        self.internal.country = country;
    });
}

- (NSDate *)dueDate {
    return ThreadSafeReturn(^id{
        return self.internal.dueDate;
    });
}

- (void)setDueDate:(NSDate *)dueDate {
    ThreadSafe(^{
        self.internal.dueDate = dueDate;
    });
}

- (NSString *)email {
    return ThreadSafeReturn(^id{
        return self.internal.email;
    });
}

- (void)setEmail:(NSString *)email {
    ThreadSafe(^{
        self.internal.email = email;
    });
}

- (NSArray *)favorites {
    return ThreadSafeReturn(^id{
        return self.internal.favorites;
    });
}

- (void)setFavorites:(NSArray *)favorites {
    ThreadSafe(^{
        self.internal.favorites = favorites;
    });
}

- (NSDate *)favoritesLastUpdated {
    return ThreadSafeReturn(^id{
        return self.internal.favoritesLastUpdated;
    });
}

- (void)setFavoritesLastUpdated:(NSDate *)favoritesLastUpdated {
    ThreadSafe(^{
        self.internal.favoritesLastUpdated = favoritesLastUpdated;
    });
}

- (NSString *)firstName {
    return ThreadSafeReturn(^id{
        return self.internal.firstName;
    });
}

- (void)setFirstName:(NSString *)firstName {
    ThreadSafe(^{
        self.internal.firstName = firstName;
    });
}

- (NSString *)lastName {
    return ThreadSafeReturn(^id{
        return self.internal.lastName;
    });
}

- (void)setLastName:(NSString *)lastName {
    ThreadSafe(^{
        self.internal.lastName = lastName;
    });
}

- (NSNumber *)optIn {
    return ThreadSafeReturn(^id{
        return self.internal.optIn;
    });
}

- (void)setOptIn:(NSNumber *)optIn {
    ThreadSafe(^{
        self.internal.optIn = optIn;
    });
}

- (NSString *)password {
    return ThreadSafeReturn(^id{
        return self.internal.password;
    });
}

- (void)setPassword:(NSString *)password {
    ThreadSafe(^{
        self.internal.password = password;
    });
}

- (NSString *)provider {
    return ThreadSafeReturn(^id{
        return self.internal.provider;
    });
}

- (void)setProvider:(NSString *)provider {
    ThreadSafe(^{
        self.internal.provider = provider;
    });
}

- (NSNumber *)purchased {
    return ThreadSafeReturn(^id{
        return self.internal.purchased;
    });
}

- (void)setPurchased:(NSNumber *)purchased {
    ThreadSafe(^{
        self.internal.purchased = purchased;
    });
}

- (NSString *)role {
    return ThreadSafeReturn(^id{
        return self.internal.role;
    });
}

- (void)setRole:(NSString *)role {
    ThreadSafe(^{
        self.internal.role = role;
    });
}

- (NSString *)sessionSecret {
    return ThreadSafeReturn(^id{
        return self.internal.sessionSecret;
    });
}

- (void)setSessionSecret:(NSString *)sessionSecret {
    ThreadSafe(^{
        self.internal.sessionSecret = sessionSecret;
    });
}

- (NSString *)sessionToken {
    return ThreadSafeReturn(^id{
        return self.internal.sessionToken;
    });
}

- (void)setSessionToken:(NSString *)sessionToken {
    ThreadSafe(^{
        self.internal.sessionToken = sessionToken;
    });
}

- (NSString *)sourceCode {
    return ThreadSafeReturn(^id{
        return self.internal.sourceCode;
    });
}

- (void)setSourceCode:(NSString *)sourceCode {
    ThreadSafe(^{
        self.internal.sourceCode = sourceCode;
    });
}

- (NSNumber *)terms {
    return ThreadSafeReturn(^id{
        return self.internal.terms;
    });
}

- (void)setTerms:(NSNumber *)terms {
    ThreadSafe(^{
        self.internal.terms = terms;
    });
}

- (NSArray *)todos {
    return ThreadSafeReturn(^id{
        return self.internal.todos;
    });
}

- (void)setTodos:(NSArray *)todos {
    ThreadSafe(^{
        self.internal.todos = todos;
    });
}

- (NSString *)xSessionId {
    return ThreadSafeReturn(^id{
        return self.internal.xSessionId;
    });
}

- (void)setXSessionId:(NSString *)xSessionId {
    ThreadSafe(^{
        self.internal.xSessionId = xSessionId;
    });
}

#pragma mark - NSObject

- (id)initWithInternal:(APInternalObject *)internal {
    if ((self = [super initWithInternal:internal])) {
        [self.class remoteConfig].remoteIDProperty = @"id";
        
    ThreadSafe(^{
    });
    }
    return self;
}

@end
