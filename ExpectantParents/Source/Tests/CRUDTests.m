//
//  CRUDTests.m
//  Tests
//
//  Created by AnyPresence, Inc. on 10/21/12.
//  Copyright (c) 2012 AnyPresence, Inc.. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "Development.h"
#import "Devo.h"
#import "Discuss.h"
#import "Item.h"
#import "Letter.h"
#import "Prayer.h"
#import "Section.h"
#import "ToDoList.h"
#import "Week.h"
#import "APDataManager.h"
#import "APObject+Remote.h"
#import "APObject+Local.h"
#import "MockHTTPURLProtocol.h"

@interface CRUDTests : GHAsyncTestCase { }

@end

@implementation CRUDTests


#pragma mark - 
#pragma mark Development

- (void)testDevelopmentCreate {
    Development * obj = [Development new];
    obj.body = @"testBody";
    obj.length = @"testLength";
    obj.weekId = @"testWeekId";
    obj.weight = @"testWeight";

    Week * week = [Week new];
    week.id = @"generated_testId";
    obj.week = week;

    [MockHTTPURLProtocol setRequestCallback:^(NSURLRequest *request) {
        NSString * data = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        
    
        NSError * weekError = nil;
        NSString * weekPattern = [NSString stringWithFormat:@"([\"'])%@\\1\\s*:\\s*([\"'])?%@\\2?",
                              [NSRegularExpression escapedPatternForString:@"week_id"],
                              [NSRegularExpression escapedPatternForString:[NSString stringWithFormat:@"%@", (week.id)]]];
        NSRegularExpression * weekRegex = [NSRegularExpression regularExpressionWithPattern:weekPattern options:0 error:&weekError];
        GHAssertNil(weekError, @"Error in regex: %@", [weekError localizedDescription]);
        GHAssertTrue([weekRegex numberOfMatchesInString:data options:0 range:NSMakeRange(0, data.length)] == 1, @"Unable to find correct FK value (%@) in request: %@", (week.id), data);

    }];

    NSError * error = nil;
    BOOL created = [obj create:&error];

    [MockHTTPURLProtocol setRequestCallback:nil];

    GHAssertTrue(created, @"Failed to create: Development");
    GHAssertNil(error, @"Failed to create: Development (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.length isEqual:(@"testLength")], @"Expected '%@', got '%@'", @"testLength", obj.length);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
    GHAssertTrue([obj.weight isEqual:(@"testWeight")], @"Expected '%@', got '%@'", @"testWeight", obj.weight);
}

- (void)testDevelopmentRead {
    Development * obj = [Development new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL read = [obj refresh:&error];

    GHAssertTrue(read, @"Failed to read: Development");
    GHAssertNil(error, @"Failed to read: Development (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.length isEqual:(@"testLength")], @"Expected '%@', got '%@'", @"testLength", obj.length);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
    GHAssertTrue([obj.weight isEqual:(@"testWeight")], @"Expected '%@', got '%@'", @"testWeight", obj.weight);
}

- (void)testDevelopmentReadAll {
    NSError * error = nil;
    NSArray * objs = [Development query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Development");
    GHAssertNotNil(objs, @"Failed to read all: Development");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    Development * obj = [objs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.length isEqual:(@"testLength")], @"Expected '%@', got '%@'", @"testLength", obj.length);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
    GHAssertTrue([obj.weight isEqual:(@"testWeight")], @"Expected '%@', got '%@'", @"testWeight", obj.weight);
}

- (void)testDevelopmentReadAllLocal {
    NSError * error = nil;
    NSArray * objs = [Development query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Development");
    GHAssertNotNil(objs, @"Failed to read all: Development");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Development queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Development");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Development");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);
    Development * obj = [localObjs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.length isEqual:(@"testLength")], @"Expected '%@', got '%@'", @"testLength", obj.length);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
    GHAssertTrue([obj.weight isEqual:(@"testWeight")], @"Expected '%@', got '%@'", @"testWeight", obj.weight);
}

- (void)testDevelopmentUpdate {
    Development * obj = [Development new];
    obj.id = @"generated_testId";
    obj.body = @"testBody";
    obj.length = @"testLength";
    obj.weekId = @"testWeekId";
    obj.weight = @"testWeight";

    NSError * error = nil;
    BOOL updated = [obj update:&error];

    GHAssertTrue(updated, @"Failed to update: Development");
    GHAssertNil(error, @"Failed to update: Development (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.length isEqual:(@"testLength")], @"Expected '%@', got '%@'", @"testLength", obj.length);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
    GHAssertTrue([obj.weight isEqual:(@"testWeight")], @"Expected '%@', got '%@'", @"testWeight", obj.weight);
}

- (void)testDevelopmentDelete {
    Development * obj = [Development new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL deleted = [obj destroy:&error];

    GHAssertTrue(deleted, @"Failed to delete: Development");
    GHAssertNil(error, @"Failed to delete: Development (%@)", [error localizedDescription]);
}

- (void)testDevelopmentDeleteAllLocal {
    NSError * error = nil;
    NSArray * objs = [Development query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Development");
    GHAssertNotNil(objs, @"Failed to read all: Development");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Development queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Development");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Development");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);

    [Development deleteAllLocal];
    GHAssertNil(error, @"Failed to delete all locally: Development");

    NSArray * deletedObjs = [Development queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Development");
    GHAssertNotNil(deletedObjs, @"Failed to read all locally: Development");
    GHAssertTrue(deletedObjs.count == 0, @"Expected '0' object(s), got '%d'", deletedObjs.count);
}

- (void)testDevelopmentCreateAsync {
    [self prepare];

    Development * obj = [Development new];
    obj.body = @"testBody";
    obj.length = @"testLength";
    obj.weekId = @"testWeekId";
    obj.weight = @"testWeight";

    [obj createAsync:^(id object, NSError * error) {
        Development * obj = (Development *)object;

        GHAssertNotNil(obj, @"Failed to create: Development");
        GHAssertNil(error, @"Failed to create: Development (%@)", [error localizedDescription]);        
        GHAssertTrue([obj isKindOfClass:[Development class]], @"Expected 'Development', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
        GHAssertTrue([obj.length isEqual:(@"testLength")], @"Expected '%@', got '%@'", @"testLength", obj.length);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
        GHAssertTrue([obj.weight isEqual:(@"testWeight")], @"Expected '%@', got '%@'", @"testWeight", obj.weight);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testDevelopmentReadAsync {
    [self prepare];

    Development * obj = [Development new];
    obj.id = @"generated_testId";

    [obj refreshAsync:^(id object, NSError * error) {
        Development * obj = (Development *)object;

        GHAssertNotNil(obj, @"Failed to read: Development");
        GHAssertNil(error, @"Failed to read: Development (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Development class]], @"Expected 'Development', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
        GHAssertTrue([obj.length isEqual:(@"testLength")], @"Expected '%@', got '%@'", @"testLength", obj.length);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
        GHAssertTrue([obj.weight isEqual:(@"testWeight")], @"Expected '%@', got '%@'", @"testWeight", obj.weight);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testDevelopmentReadAllAsync {
    [self prepare];

    [Development query:@"all" params:@{ } async:^(NSArray * objs, NSError * error) {
        GHAssertNil(error, @"Failed to read all: Development");
        GHAssertNotNil(objs, @"Failed to read all: Development");
        GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

        Development * obj = [objs objectAtIndex:0];
        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
        GHAssertTrue([obj.length isEqual:(@"testLength")], @"Expected '%@', got '%@'", @"testLength", obj.length);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
        GHAssertTrue([obj.weight isEqual:(@"testWeight")], @"Expected '%@', got '%@'", @"testWeight", obj.weight);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testDevelopmentUpdateAsync {
    [self prepare];

    Development * obj = [Development new];
    obj.id = @"generated_testId";
    obj.body = @"testBody";
    obj.length = @"testLength";
    obj.weekId = @"testWeekId";
    obj.weight = @"testWeight";

    [obj updateAsync:^(id object, NSError * error) {
        Development * obj = (Development *)object;

        GHAssertNotNil(obj, @"Failed to update: Development");
        GHAssertNil(error, @"Failed to update: Development (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Development class]], @"Expected 'Development', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
        GHAssertTrue([obj.length isEqual:(@"testLength")], @"Expected '%@', got '%@'", @"testLength", obj.length);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
        GHAssertTrue([obj.weight isEqual:(@"testWeight")], @"Expected '%@', got '%@'", @"testWeight", obj.weight);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testDevelopmentDeleteAsync {
    [self prepare];

    Development * obj = [Development new];
    obj.id = @"generated_testId";

    [obj destroyAsync:^(id obj, NSError * error) {
        GHAssertNil(obj, @"Failed to delete: Development");
        GHAssertNil(error, @"Failed to delete: Development (%@)", [error localizedDescription]);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}


#pragma mark - 
#pragma mark Devo

- (void)testDevoCreate {
    Devo * obj = [Devo new];
    obj.insight = @"testInsight";
    obj.reference = @"testReference";
    obj.verse = @"testVerse";
    obj.weekId = @"testWeekId";

    Week * week = [Week new];
    week.id = @"generated_testId";
    obj.week = week;

    [MockHTTPURLProtocol setRequestCallback:^(NSURLRequest *request) {
        NSString * data = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        
    
        NSError * weekError = nil;
        NSString * weekPattern = [NSString stringWithFormat:@"([\"'])%@\\1\\s*:\\s*([\"'])?%@\\2?",
                              [NSRegularExpression escapedPatternForString:@"week_id"],
                              [NSRegularExpression escapedPatternForString:[NSString stringWithFormat:@"%@", (week.id)]]];
        NSRegularExpression * weekRegex = [NSRegularExpression regularExpressionWithPattern:weekPattern options:0 error:&weekError];
        GHAssertNil(weekError, @"Error in regex: %@", [weekError localizedDescription]);
        GHAssertTrue([weekRegex numberOfMatchesInString:data options:0 range:NSMakeRange(0, data.length)] == 1, @"Unable to find correct FK value (%@) in request: %@", (week.id), data);

    }];

    NSError * error = nil;
    BOOL created = [obj create:&error];

    [MockHTTPURLProtocol setRequestCallback:nil];

    GHAssertTrue(created, @"Failed to create: Devo");
    GHAssertNil(error, @"Failed to create: Devo (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.insight isEqual:(@"testInsight")], @"Expected '%@', got '%@'", @"testInsight", obj.insight);
    GHAssertTrue([obj.reference isEqual:(@"testReference")], @"Expected '%@', got '%@'", @"testReference", obj.reference);
    GHAssertTrue([obj.verse isEqual:(@"testVerse")], @"Expected '%@', got '%@'", @"testVerse", obj.verse);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testDevoRead {
    Devo * obj = [Devo new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL read = [obj refresh:&error];

    GHAssertTrue(read, @"Failed to read: Devo");
    GHAssertNil(error, @"Failed to read: Devo (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.insight isEqual:(@"testInsight")], @"Expected '%@', got '%@'", @"testInsight", obj.insight);
    GHAssertTrue([obj.reference isEqual:(@"testReference")], @"Expected '%@', got '%@'", @"testReference", obj.reference);
    GHAssertTrue([obj.verse isEqual:(@"testVerse")], @"Expected '%@', got '%@'", @"testVerse", obj.verse);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testDevoReadAll {
    NSError * error = nil;
    NSArray * objs = [Devo query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Devo");
    GHAssertNotNil(objs, @"Failed to read all: Devo");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    Devo * obj = [objs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.insight isEqual:(@"testInsight")], @"Expected '%@', got '%@'", @"testInsight", obj.insight);
    GHAssertTrue([obj.reference isEqual:(@"testReference")], @"Expected '%@', got '%@'", @"testReference", obj.reference);
    GHAssertTrue([obj.verse isEqual:(@"testVerse")], @"Expected '%@', got '%@'", @"testVerse", obj.verse);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testDevoReadAllLocal {
    NSError * error = nil;
    NSArray * objs = [Devo query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Devo");
    GHAssertNotNil(objs, @"Failed to read all: Devo");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Devo queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Devo");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Devo");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);
    Devo * obj = [localObjs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.insight isEqual:(@"testInsight")], @"Expected '%@', got '%@'", @"testInsight", obj.insight);
    GHAssertTrue([obj.reference isEqual:(@"testReference")], @"Expected '%@', got '%@'", @"testReference", obj.reference);
    GHAssertTrue([obj.verse isEqual:(@"testVerse")], @"Expected '%@', got '%@'", @"testVerse", obj.verse);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testDevoUpdate {
    Devo * obj = [Devo new];
    obj.id = @"generated_testId";
    obj.insight = @"testInsight";
    obj.reference = @"testReference";
    obj.verse = @"testVerse";
    obj.weekId = @"testWeekId";

    NSError * error = nil;
    BOOL updated = [obj update:&error];

    GHAssertTrue(updated, @"Failed to update: Devo");
    GHAssertNil(error, @"Failed to update: Devo (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.insight isEqual:(@"testInsight")], @"Expected '%@', got '%@'", @"testInsight", obj.insight);
    GHAssertTrue([obj.reference isEqual:(@"testReference")], @"Expected '%@', got '%@'", @"testReference", obj.reference);
    GHAssertTrue([obj.verse isEqual:(@"testVerse")], @"Expected '%@', got '%@'", @"testVerse", obj.verse);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testDevoDelete {
    Devo * obj = [Devo new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL deleted = [obj destroy:&error];

    GHAssertTrue(deleted, @"Failed to delete: Devo");
    GHAssertNil(error, @"Failed to delete: Devo (%@)", [error localizedDescription]);
}

- (void)testDevoDeleteAllLocal {
    NSError * error = nil;
    NSArray * objs = [Devo query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Devo");
    GHAssertNotNil(objs, @"Failed to read all: Devo");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Devo queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Devo");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Devo");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);

    [Devo deleteAllLocal];
    GHAssertNil(error, @"Failed to delete all locally: Devo");

    NSArray * deletedObjs = [Devo queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Devo");
    GHAssertNotNil(deletedObjs, @"Failed to read all locally: Devo");
    GHAssertTrue(deletedObjs.count == 0, @"Expected '0' object(s), got '%d'", deletedObjs.count);
}

- (void)testDevoCreateAsync {
    [self prepare];

    Devo * obj = [Devo new];
    obj.insight = @"testInsight";
    obj.reference = @"testReference";
    obj.verse = @"testVerse";
    obj.weekId = @"testWeekId";

    [obj createAsync:^(id object, NSError * error) {
        Devo * obj = (Devo *)object;

        GHAssertNotNil(obj, @"Failed to create: Devo");
        GHAssertNil(error, @"Failed to create: Devo (%@)", [error localizedDescription]);        
        GHAssertTrue([obj isKindOfClass:[Devo class]], @"Expected 'Devo', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.insight isEqual:(@"testInsight")], @"Expected '%@', got '%@'", @"testInsight", obj.insight);
        GHAssertTrue([obj.reference isEqual:(@"testReference")], @"Expected '%@', got '%@'", @"testReference", obj.reference);
        GHAssertTrue([obj.verse isEqual:(@"testVerse")], @"Expected '%@', got '%@'", @"testVerse", obj.verse);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testDevoReadAsync {
    [self prepare];

    Devo * obj = [Devo new];
    obj.id = @"generated_testId";

    [obj refreshAsync:^(id object, NSError * error) {
        Devo * obj = (Devo *)object;

        GHAssertNotNil(obj, @"Failed to read: Devo");
        GHAssertNil(error, @"Failed to read: Devo (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Devo class]], @"Expected 'Devo', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.insight isEqual:(@"testInsight")], @"Expected '%@', got '%@'", @"testInsight", obj.insight);
        GHAssertTrue([obj.reference isEqual:(@"testReference")], @"Expected '%@', got '%@'", @"testReference", obj.reference);
        GHAssertTrue([obj.verse isEqual:(@"testVerse")], @"Expected '%@', got '%@'", @"testVerse", obj.verse);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testDevoReadAllAsync {
    [self prepare];

    [Devo query:@"all" params:@{ } async:^(NSArray * objs, NSError * error) {
        GHAssertNil(error, @"Failed to read all: Devo");
        GHAssertNotNil(objs, @"Failed to read all: Devo");
        GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

        Devo * obj = [objs objectAtIndex:0];
        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.insight isEqual:(@"testInsight")], @"Expected '%@', got '%@'", @"testInsight", obj.insight);
        GHAssertTrue([obj.reference isEqual:(@"testReference")], @"Expected '%@', got '%@'", @"testReference", obj.reference);
        GHAssertTrue([obj.verse isEqual:(@"testVerse")], @"Expected '%@', got '%@'", @"testVerse", obj.verse);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testDevoUpdateAsync {
    [self prepare];

    Devo * obj = [Devo new];
    obj.id = @"generated_testId";
    obj.insight = @"testInsight";
    obj.reference = @"testReference";
    obj.verse = @"testVerse";
    obj.weekId = @"testWeekId";

    [obj updateAsync:^(id object, NSError * error) {
        Devo * obj = (Devo *)object;

        GHAssertNotNil(obj, @"Failed to update: Devo");
        GHAssertNil(error, @"Failed to update: Devo (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Devo class]], @"Expected 'Devo', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.insight isEqual:(@"testInsight")], @"Expected '%@', got '%@'", @"testInsight", obj.insight);
        GHAssertTrue([obj.reference isEqual:(@"testReference")], @"Expected '%@', got '%@'", @"testReference", obj.reference);
        GHAssertTrue([obj.verse isEqual:(@"testVerse")], @"Expected '%@', got '%@'", @"testVerse", obj.verse);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testDevoDeleteAsync {
    [self prepare];

    Devo * obj = [Devo new];
    obj.id = @"generated_testId";

    [obj destroyAsync:^(id obj, NSError * error) {
        GHAssertNil(obj, @"Failed to delete: Devo");
        GHAssertNil(error, @"Failed to delete: Devo (%@)", [error localizedDescription]);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}


#pragma mark - 
#pragma mark Discuss

- (void)testDiscussCreate {
    Discuss * obj = [Discuss new];
    obj.items = @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ];
    obj.weekId = @"testWeekId";

    Week * week = [Week new];
    week.id = @"generated_testId";
    obj.week = week;

    [MockHTTPURLProtocol setRequestCallback:^(NSURLRequest *request) {
        NSString * data = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        
    
        NSError * weekError = nil;
        NSString * weekPattern = [NSString stringWithFormat:@"([\"'])%@\\1\\s*:\\s*([\"'])?%@\\2?",
                              [NSRegularExpression escapedPatternForString:@"week_id"],
                              [NSRegularExpression escapedPatternForString:[NSString stringWithFormat:@"%@", (week.id)]]];
        NSRegularExpression * weekRegex = [NSRegularExpression regularExpressionWithPattern:weekPattern options:0 error:&weekError];
        GHAssertNil(weekError, @"Error in regex: %@", [weekError localizedDescription]);
        GHAssertTrue([weekRegex numberOfMatchesInString:data options:0 range:NSMakeRange(0, data.length)] == 1, @"Unable to find correct FK value (%@) in request: %@", (week.id), data);

    }];

    NSError * error = nil;
    BOOL created = [obj create:&error];

    [MockHTTPURLProtocol setRequestCallback:nil];

    GHAssertTrue(created, @"Failed to create: Discuss");
    GHAssertNil(error, @"Failed to create: Discuss (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.items isEqual:(@[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ])], @"Expected '%@', got '%@'", @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ], obj.items);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testDiscussRead {
    Discuss * obj = [Discuss new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL read = [obj refresh:&error];

    GHAssertTrue(read, @"Failed to read: Discuss");
    GHAssertNil(error, @"Failed to read: Discuss (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.items isEqual:(@[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ])], @"Expected '%@', got '%@'", @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ], obj.items);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testDiscussReadAll {
    NSError * error = nil;
    NSArray * objs = [Discuss query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Discuss");
    GHAssertNotNil(objs, @"Failed to read all: Discuss");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    Discuss * obj = [objs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.items isEqual:(@[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ])], @"Expected '%@', got '%@'", @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ], obj.items);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testDiscussReadAllLocal {
    NSError * error = nil;
    NSArray * objs = [Discuss query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Discuss");
    GHAssertNotNil(objs, @"Failed to read all: Discuss");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Discuss queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Discuss");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Discuss");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);
    Discuss * obj = [localObjs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.items isEqual:(@[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ])], @"Expected '%@', got '%@'", @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ], obj.items);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testDiscussUpdate {
    Discuss * obj = [Discuss new];
    obj.id = @"generated_testId";
    obj.items = @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ];
    obj.weekId = @"testWeekId";

    NSError * error = nil;
    BOOL updated = [obj update:&error];

    GHAssertTrue(updated, @"Failed to update: Discuss");
    GHAssertNil(error, @"Failed to update: Discuss (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.items isEqual:(@[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ])], @"Expected '%@', got '%@'", @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ], obj.items);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testDiscussDelete {
    Discuss * obj = [Discuss new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL deleted = [obj destroy:&error];

    GHAssertTrue(deleted, @"Failed to delete: Discuss");
    GHAssertNil(error, @"Failed to delete: Discuss (%@)", [error localizedDescription]);
}

- (void)testDiscussDeleteAllLocal {
    NSError * error = nil;
    NSArray * objs = [Discuss query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Discuss");
    GHAssertNotNil(objs, @"Failed to read all: Discuss");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Discuss queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Discuss");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Discuss");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);

    [Discuss deleteAllLocal];
    GHAssertNil(error, @"Failed to delete all locally: Discuss");

    NSArray * deletedObjs = [Discuss queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Discuss");
    GHAssertNotNil(deletedObjs, @"Failed to read all locally: Discuss");
    GHAssertTrue(deletedObjs.count == 0, @"Expected '0' object(s), got '%d'", deletedObjs.count);
}

- (void)testDiscussCreateAsync {
    [self prepare];

    Discuss * obj = [Discuss new];
    obj.items = @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ];
    obj.weekId = @"testWeekId";

    [obj createAsync:^(id object, NSError * error) {
        Discuss * obj = (Discuss *)object;

        GHAssertNotNil(obj, @"Failed to create: Discuss");
        GHAssertNil(error, @"Failed to create: Discuss (%@)", [error localizedDescription]);        
        GHAssertTrue([obj isKindOfClass:[Discuss class]], @"Expected 'Discuss', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.items isEqual:(@[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ])], @"Expected '%@', got '%@'", @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ], obj.items);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testDiscussReadAsync {
    [self prepare];

    Discuss * obj = [Discuss new];
    obj.id = @"generated_testId";

    [obj refreshAsync:^(id object, NSError * error) {
        Discuss * obj = (Discuss *)object;

        GHAssertNotNil(obj, @"Failed to read: Discuss");
        GHAssertNil(error, @"Failed to read: Discuss (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Discuss class]], @"Expected 'Discuss', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.items isEqual:(@[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ])], @"Expected '%@', got '%@'", @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ], obj.items);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testDiscussReadAllAsync {
    [self prepare];

    [Discuss query:@"all" params:@{ } async:^(NSArray * objs, NSError * error) {
        GHAssertNil(error, @"Failed to read all: Discuss");
        GHAssertNotNil(objs, @"Failed to read all: Discuss");
        GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

        Discuss * obj = [objs objectAtIndex:0];
        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.items isEqual:(@[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ])], @"Expected '%@', got '%@'", @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ], obj.items);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testDiscussUpdateAsync {
    [self prepare];

    Discuss * obj = [Discuss new];
    obj.id = @"generated_testId";
    obj.items = @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ];
    obj.weekId = @"testWeekId";

    [obj updateAsync:^(id object, NSError * error) {
        Discuss * obj = (Discuss *)object;

        GHAssertNotNil(obj, @"Failed to update: Discuss");
        GHAssertNil(error, @"Failed to update: Discuss (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Discuss class]], @"Expected 'Discuss', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.items isEqual:(@[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ])], @"Expected '%@', got '%@'", @[ @"test", [NSNumber numberWithInt:-1], @[ @"nested", @{ @"nested": @"hash" } ] ], obj.items);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testDiscussDeleteAsync {
    [self prepare];

    Discuss * obj = [Discuss new];
    obj.id = @"generated_testId";

    [obj destroyAsync:^(id obj, NSError * error) {
        GHAssertNil(obj, @"Failed to delete: Discuss");
        GHAssertNil(error, @"Failed to delete: Discuss (%@)", [error localizedDescription]);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}


#pragma mark - 
#pragma mark Item

- (void)testItemCreate {
    Item * obj = [Item new];
    obj.order = [NSNumber numberWithInt:-3639010014029403819];
    obj.sectionId = @"testSectionId";
    obj.value = @"testValue";

    Section * section = [Section new];
    section.id = @"generated_testId";
    obj.section = section;

    [MockHTTPURLProtocol setRequestCallback:^(NSURLRequest *request) {
        NSString * data = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        
    
        NSError * sectionError = nil;
        NSString * sectionPattern = [NSString stringWithFormat:@"([\"'])%@\\1\\s*:\\s*([\"'])?%@\\2?",
                              [NSRegularExpression escapedPatternForString:@"section_id"],
                              [NSRegularExpression escapedPatternForString:[NSString stringWithFormat:@"%@", (section.id)]]];
        NSRegularExpression * sectionRegex = [NSRegularExpression regularExpressionWithPattern:sectionPattern options:0 error:&sectionError];
        GHAssertNil(sectionError, @"Error in regex: %@", [sectionError localizedDescription]);
        GHAssertTrue([sectionRegex numberOfMatchesInString:data options:0 range:NSMakeRange(0, data.length)] == 1, @"Unable to find correct FK value (%@) in request: %@", (section.id), data);

    }];

    NSError * error = nil;
    BOOL created = [obj create:&error];

    [MockHTTPURLProtocol setRequestCallback:nil];

    GHAssertTrue(created, @"Failed to create: Item");
    GHAssertNil(error, @"Failed to create: Item (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
    GHAssertTrue([obj.sectionId isEqual:(@"testSectionId")], @"Expected '%@', got '%@'", @"testSectionId", obj.sectionId);
    GHAssertTrue([obj.value isEqual:(@"testValue")], @"Expected '%@', got '%@'", @"testValue", obj.value);
}

- (void)testItemRead {
    Item * obj = [Item new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL read = [obj refresh:&error];

    GHAssertTrue(read, @"Failed to read: Item");
    GHAssertNil(error, @"Failed to read: Item (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
    GHAssertTrue([obj.sectionId isEqual:(@"testSectionId")], @"Expected '%@', got '%@'", @"testSectionId", obj.sectionId);
    GHAssertTrue([obj.value isEqual:(@"testValue")], @"Expected '%@', got '%@'", @"testValue", obj.value);
}

- (void)testItemReadAll {
    NSError * error = nil;
    NSArray * objs = [Item query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Item");
    GHAssertNotNil(objs, @"Failed to read all: Item");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    Item * obj = [objs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
    GHAssertTrue([obj.sectionId isEqual:(@"testSectionId")], @"Expected '%@', got '%@'", @"testSectionId", obj.sectionId);
    GHAssertTrue([obj.value isEqual:(@"testValue")], @"Expected '%@', got '%@'", @"testValue", obj.value);
}

- (void)testItemReadAllLocal {
    NSError * error = nil;
    NSArray * objs = [Item query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Item");
    GHAssertNotNil(objs, @"Failed to read all: Item");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Item queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Item");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Item");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);
    Item * obj = [localObjs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
    GHAssertTrue([obj.sectionId isEqual:(@"testSectionId")], @"Expected '%@', got '%@'", @"testSectionId", obj.sectionId);
    GHAssertTrue([obj.value isEqual:(@"testValue")], @"Expected '%@', got '%@'", @"testValue", obj.value);
}

- (void)testItemUpdate {
    Item * obj = [Item new];
    obj.id = @"generated_testId";
    obj.order = [NSNumber numberWithInt:-3639010014029403819];
    obj.sectionId = @"testSectionId";
    obj.value = @"testValue";

    NSError * error = nil;
    BOOL updated = [obj update:&error];

    GHAssertTrue(updated, @"Failed to update: Item");
    GHAssertNil(error, @"Failed to update: Item (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
    GHAssertTrue([obj.sectionId isEqual:(@"testSectionId")], @"Expected '%@', got '%@'", @"testSectionId", obj.sectionId);
    GHAssertTrue([obj.value isEqual:(@"testValue")], @"Expected '%@', got '%@'", @"testValue", obj.value);
}

- (void)testItemDelete {
    Item * obj = [Item new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL deleted = [obj destroy:&error];

    GHAssertTrue(deleted, @"Failed to delete: Item");
    GHAssertNil(error, @"Failed to delete: Item (%@)", [error localizedDescription]);
}

- (void)testItemDeleteAllLocal {
    NSError * error = nil;
    NSArray * objs = [Item query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Item");
    GHAssertNotNil(objs, @"Failed to read all: Item");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Item queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Item");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Item");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);

    [Item deleteAllLocal];
    GHAssertNil(error, @"Failed to delete all locally: Item");

    NSArray * deletedObjs = [Item queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Item");
    GHAssertNotNil(deletedObjs, @"Failed to read all locally: Item");
    GHAssertTrue(deletedObjs.count == 0, @"Expected '0' object(s), got '%d'", deletedObjs.count);
}

- (void)testItemCreateAsync {
    [self prepare];

    Item * obj = [Item new];
    obj.order = [NSNumber numberWithInt:-3639010014029403819];
    obj.sectionId = @"testSectionId";
    obj.value = @"testValue";

    [obj createAsync:^(id object, NSError * error) {
        Item * obj = (Item *)object;

        GHAssertNotNil(obj, @"Failed to create: Item");
        GHAssertNil(error, @"Failed to create: Item (%@)", [error localizedDescription]);        
        GHAssertTrue([obj isKindOfClass:[Item class]], @"Expected 'Item', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
        GHAssertTrue([obj.sectionId isEqual:(@"testSectionId")], @"Expected '%@', got '%@'", @"testSectionId", obj.sectionId);
        GHAssertTrue([obj.value isEqual:(@"testValue")], @"Expected '%@', got '%@'", @"testValue", obj.value);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testItemReadAsync {
    [self prepare];

    Item * obj = [Item new];
    obj.id = @"generated_testId";

    [obj refreshAsync:^(id object, NSError * error) {
        Item * obj = (Item *)object;

        GHAssertNotNil(obj, @"Failed to read: Item");
        GHAssertNil(error, @"Failed to read: Item (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Item class]], @"Expected 'Item', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
        GHAssertTrue([obj.sectionId isEqual:(@"testSectionId")], @"Expected '%@', got '%@'", @"testSectionId", obj.sectionId);
        GHAssertTrue([obj.value isEqual:(@"testValue")], @"Expected '%@', got '%@'", @"testValue", obj.value);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testItemReadAllAsync {
    [self prepare];

    [Item query:@"all" params:@{ } async:^(NSArray * objs, NSError * error) {
        GHAssertNil(error, @"Failed to read all: Item");
        GHAssertNotNil(objs, @"Failed to read all: Item");
        GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

        Item * obj = [objs objectAtIndex:0];
        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
        GHAssertTrue([obj.sectionId isEqual:(@"testSectionId")], @"Expected '%@', got '%@'", @"testSectionId", obj.sectionId);
        GHAssertTrue([obj.value isEqual:(@"testValue")], @"Expected '%@', got '%@'", @"testValue", obj.value);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testItemUpdateAsync {
    [self prepare];

    Item * obj = [Item new];
    obj.id = @"generated_testId";
    obj.order = [NSNumber numberWithInt:-3639010014029403819];
    obj.sectionId = @"testSectionId";
    obj.value = @"testValue";

    [obj updateAsync:^(id object, NSError * error) {
        Item * obj = (Item *)object;

        GHAssertNotNil(obj, @"Failed to update: Item");
        GHAssertNil(error, @"Failed to update: Item (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Item class]], @"Expected 'Item', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
        GHAssertTrue([obj.sectionId isEqual:(@"testSectionId")], @"Expected '%@', got '%@'", @"testSectionId", obj.sectionId);
        GHAssertTrue([obj.value isEqual:(@"testValue")], @"Expected '%@', got '%@'", @"testValue", obj.value);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testItemDeleteAsync {
    [self prepare];

    Item * obj = [Item new];
    obj.id = @"generated_testId";

    [obj destroyAsync:^(id obj, NSError * error) {
        GHAssertNil(obj, @"Failed to delete: Item");
        GHAssertNil(error, @"Failed to delete: Item (%@)", [error localizedDescription]);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}


#pragma mark - 
#pragma mark Letter

- (void)testLetterCreate {
    Letter * obj = [Letter new];
    obj.body = @"testBody";
    obj.title = @"testTitle";
    obj.weekId = @"testWeekId";

    Week * week = [Week new];
    week.id = @"generated_testId";
    obj.week = week;

    [MockHTTPURLProtocol setRequestCallback:^(NSURLRequest *request) {
        NSString * data = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        
    
        NSError * weekError = nil;
        NSString * weekPattern = [NSString stringWithFormat:@"([\"'])%@\\1\\s*:\\s*([\"'])?%@\\2?",
                              [NSRegularExpression escapedPatternForString:@"week_id"],
                              [NSRegularExpression escapedPatternForString:[NSString stringWithFormat:@"%@", (week.id)]]];
        NSRegularExpression * weekRegex = [NSRegularExpression regularExpressionWithPattern:weekPattern options:0 error:&weekError];
        GHAssertNil(weekError, @"Error in regex: %@", [weekError localizedDescription]);
        GHAssertTrue([weekRegex numberOfMatchesInString:data options:0 range:NSMakeRange(0, data.length)] == 1, @"Unable to find correct FK value (%@) in request: %@", (week.id), data);

    }];

    NSError * error = nil;
    BOOL created = [obj create:&error];

    [MockHTTPURLProtocol setRequestCallback:nil];

    GHAssertTrue(created, @"Failed to create: Letter");
    GHAssertNil(error, @"Failed to create: Letter (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.title isEqual:(@"testTitle")], @"Expected '%@', got '%@'", @"testTitle", obj.title);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testLetterRead {
    Letter * obj = [Letter new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL read = [obj refresh:&error];

    GHAssertTrue(read, @"Failed to read: Letter");
    GHAssertNil(error, @"Failed to read: Letter (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.title isEqual:(@"testTitle")], @"Expected '%@', got '%@'", @"testTitle", obj.title);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testLetterReadAll {
    NSError * error = nil;
    NSArray * objs = [Letter query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Letter");
    GHAssertNotNil(objs, @"Failed to read all: Letter");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    Letter * obj = [objs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.title isEqual:(@"testTitle")], @"Expected '%@', got '%@'", @"testTitle", obj.title);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testLetterReadAllLocal {
    NSError * error = nil;
    NSArray * objs = [Letter query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Letter");
    GHAssertNotNil(objs, @"Failed to read all: Letter");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Letter queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Letter");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Letter");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);
    Letter * obj = [localObjs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.title isEqual:(@"testTitle")], @"Expected '%@', got '%@'", @"testTitle", obj.title);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testLetterUpdate {
    Letter * obj = [Letter new];
    obj.id = @"generated_testId";
    obj.body = @"testBody";
    obj.title = @"testTitle";
    obj.weekId = @"testWeekId";

    NSError * error = nil;
    BOOL updated = [obj update:&error];

    GHAssertTrue(updated, @"Failed to update: Letter");
    GHAssertNil(error, @"Failed to update: Letter (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.title isEqual:(@"testTitle")], @"Expected '%@', got '%@'", @"testTitle", obj.title);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testLetterDelete {
    Letter * obj = [Letter new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL deleted = [obj destroy:&error];

    GHAssertTrue(deleted, @"Failed to delete: Letter");
    GHAssertNil(error, @"Failed to delete: Letter (%@)", [error localizedDescription]);
}

- (void)testLetterDeleteAllLocal {
    NSError * error = nil;
    NSArray * objs = [Letter query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Letter");
    GHAssertNotNil(objs, @"Failed to read all: Letter");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Letter queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Letter");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Letter");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);

    [Letter deleteAllLocal];
    GHAssertNil(error, @"Failed to delete all locally: Letter");

    NSArray * deletedObjs = [Letter queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Letter");
    GHAssertNotNil(deletedObjs, @"Failed to read all locally: Letter");
    GHAssertTrue(deletedObjs.count == 0, @"Expected '0' object(s), got '%d'", deletedObjs.count);
}

- (void)testLetterCreateAsync {
    [self prepare];

    Letter * obj = [Letter new];
    obj.body = @"testBody";
    obj.title = @"testTitle";
    obj.weekId = @"testWeekId";

    [obj createAsync:^(id object, NSError * error) {
        Letter * obj = (Letter *)object;

        GHAssertNotNil(obj, @"Failed to create: Letter");
        GHAssertNil(error, @"Failed to create: Letter (%@)", [error localizedDescription]);        
        GHAssertTrue([obj isKindOfClass:[Letter class]], @"Expected 'Letter', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
        GHAssertTrue([obj.title isEqual:(@"testTitle")], @"Expected '%@', got '%@'", @"testTitle", obj.title);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testLetterReadAsync {
    [self prepare];

    Letter * obj = [Letter new];
    obj.id = @"generated_testId";

    [obj refreshAsync:^(id object, NSError * error) {
        Letter * obj = (Letter *)object;

        GHAssertNotNil(obj, @"Failed to read: Letter");
        GHAssertNil(error, @"Failed to read: Letter (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Letter class]], @"Expected 'Letter', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
        GHAssertTrue([obj.title isEqual:(@"testTitle")], @"Expected '%@', got '%@'", @"testTitle", obj.title);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testLetterReadAllAsync {
    [self prepare];

    [Letter query:@"all" params:@{ } async:^(NSArray * objs, NSError * error) {
        GHAssertNil(error, @"Failed to read all: Letter");
        GHAssertNotNil(objs, @"Failed to read all: Letter");
        GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

        Letter * obj = [objs objectAtIndex:0];
        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
        GHAssertTrue([obj.title isEqual:(@"testTitle")], @"Expected '%@', got '%@'", @"testTitle", obj.title);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testLetterUpdateAsync {
    [self prepare];

    Letter * obj = [Letter new];
    obj.id = @"generated_testId";
    obj.body = @"testBody";
    obj.title = @"testTitle";
    obj.weekId = @"testWeekId";

    [obj updateAsync:^(id object, NSError * error) {
        Letter * obj = (Letter *)object;

        GHAssertNotNil(obj, @"Failed to update: Letter");
        GHAssertNil(error, @"Failed to update: Letter (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Letter class]], @"Expected 'Letter', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
        GHAssertTrue([obj.title isEqual:(@"testTitle")], @"Expected '%@', got '%@'", @"testTitle", obj.title);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testLetterDeleteAsync {
    [self prepare];

    Letter * obj = [Letter new];
    obj.id = @"generated_testId";

    [obj destroyAsync:^(id obj, NSError * error) {
        GHAssertNil(obj, @"Failed to delete: Letter");
        GHAssertNil(error, @"Failed to delete: Letter (%@)", [error localizedDescription]);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}


#pragma mark - 
#pragma mark Prayer

- (void)testPrayerCreate {
    Prayer * obj = [Prayer new];
    obj.body = @"testBody";
    obj.salutation = @"testSalutation";
    obj.weekId = @"testWeekId";

    Week * week = [Week new];
    week.id = @"generated_testId";
    obj.week = week;

    [MockHTTPURLProtocol setRequestCallback:^(NSURLRequest *request) {
        NSString * data = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        
    
        NSError * weekError = nil;
        NSString * weekPattern = [NSString stringWithFormat:@"([\"'])%@\\1\\s*:\\s*([\"'])?%@\\2?",
                              [NSRegularExpression escapedPatternForString:@"week_id"],
                              [NSRegularExpression escapedPatternForString:[NSString stringWithFormat:@"%@", (week.id)]]];
        NSRegularExpression * weekRegex = [NSRegularExpression regularExpressionWithPattern:weekPattern options:0 error:&weekError];
        GHAssertNil(weekError, @"Error in regex: %@", [weekError localizedDescription]);
        GHAssertTrue([weekRegex numberOfMatchesInString:data options:0 range:NSMakeRange(0, data.length)] == 1, @"Unable to find correct FK value (%@) in request: %@", (week.id), data);

    }];

    NSError * error = nil;
    BOOL created = [obj create:&error];

    [MockHTTPURLProtocol setRequestCallback:nil];

    GHAssertTrue(created, @"Failed to create: Prayer");
    GHAssertNil(error, @"Failed to create: Prayer (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.salutation isEqual:(@"testSalutation")], @"Expected '%@', got '%@'", @"testSalutation", obj.salutation);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testPrayerRead {
    Prayer * obj = [Prayer new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL read = [obj refresh:&error];

    GHAssertTrue(read, @"Failed to read: Prayer");
    GHAssertNil(error, @"Failed to read: Prayer (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.salutation isEqual:(@"testSalutation")], @"Expected '%@', got '%@'", @"testSalutation", obj.salutation);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testPrayerReadAll {
    NSError * error = nil;
    NSArray * objs = [Prayer query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Prayer");
    GHAssertNotNil(objs, @"Failed to read all: Prayer");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    Prayer * obj = [objs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.salutation isEqual:(@"testSalutation")], @"Expected '%@', got '%@'", @"testSalutation", obj.salutation);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testPrayerReadAllLocal {
    NSError * error = nil;
    NSArray * objs = [Prayer query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Prayer");
    GHAssertNotNil(objs, @"Failed to read all: Prayer");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Prayer queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Prayer");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Prayer");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);
    Prayer * obj = [localObjs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.salutation isEqual:(@"testSalutation")], @"Expected '%@', got '%@'", @"testSalutation", obj.salutation);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testPrayerUpdate {
    Prayer * obj = [Prayer new];
    obj.id = @"generated_testId";
    obj.body = @"testBody";
    obj.salutation = @"testSalutation";
    obj.weekId = @"testWeekId";

    NSError * error = nil;
    BOOL updated = [obj update:&error];

    GHAssertTrue(updated, @"Failed to update: Prayer");
    GHAssertNil(error, @"Failed to update: Prayer (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
    GHAssertTrue([obj.salutation isEqual:(@"testSalutation")], @"Expected '%@', got '%@'", @"testSalutation", obj.salutation);
    GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);
}

- (void)testPrayerDelete {
    Prayer * obj = [Prayer new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL deleted = [obj destroy:&error];

    GHAssertTrue(deleted, @"Failed to delete: Prayer");
    GHAssertNil(error, @"Failed to delete: Prayer (%@)", [error localizedDescription]);
}

- (void)testPrayerDeleteAllLocal {
    NSError * error = nil;
    NSArray * objs = [Prayer query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Prayer");
    GHAssertNotNil(objs, @"Failed to read all: Prayer");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Prayer queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Prayer");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Prayer");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);

    [Prayer deleteAllLocal];
    GHAssertNil(error, @"Failed to delete all locally: Prayer");

    NSArray * deletedObjs = [Prayer queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Prayer");
    GHAssertNotNil(deletedObjs, @"Failed to read all locally: Prayer");
    GHAssertTrue(deletedObjs.count == 0, @"Expected '0' object(s), got '%d'", deletedObjs.count);
}

- (void)testPrayerCreateAsync {
    [self prepare];

    Prayer * obj = [Prayer new];
    obj.body = @"testBody";
    obj.salutation = @"testSalutation";
    obj.weekId = @"testWeekId";

    [obj createAsync:^(id object, NSError * error) {
        Prayer * obj = (Prayer *)object;

        GHAssertNotNil(obj, @"Failed to create: Prayer");
        GHAssertNil(error, @"Failed to create: Prayer (%@)", [error localizedDescription]);        
        GHAssertTrue([obj isKindOfClass:[Prayer class]], @"Expected 'Prayer', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
        GHAssertTrue([obj.salutation isEqual:(@"testSalutation")], @"Expected '%@', got '%@'", @"testSalutation", obj.salutation);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testPrayerReadAsync {
    [self prepare];

    Prayer * obj = [Prayer new];
    obj.id = @"generated_testId";

    [obj refreshAsync:^(id object, NSError * error) {
        Prayer * obj = (Prayer *)object;

        GHAssertNotNil(obj, @"Failed to read: Prayer");
        GHAssertNil(error, @"Failed to read: Prayer (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Prayer class]], @"Expected 'Prayer', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
        GHAssertTrue([obj.salutation isEqual:(@"testSalutation")], @"Expected '%@', got '%@'", @"testSalutation", obj.salutation);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testPrayerReadAllAsync {
    [self prepare];

    [Prayer query:@"all" params:@{ } async:^(NSArray * objs, NSError * error) {
        GHAssertNil(error, @"Failed to read all: Prayer");
        GHAssertNotNil(objs, @"Failed to read all: Prayer");
        GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

        Prayer * obj = [objs objectAtIndex:0];
        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
        GHAssertTrue([obj.salutation isEqual:(@"testSalutation")], @"Expected '%@', got '%@'", @"testSalutation", obj.salutation);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testPrayerUpdateAsync {
    [self prepare];

    Prayer * obj = [Prayer new];
    obj.id = @"generated_testId";
    obj.body = @"testBody";
    obj.salutation = @"testSalutation";
    obj.weekId = @"testWeekId";

    [obj updateAsync:^(id object, NSError * error) {
        Prayer * obj = (Prayer *)object;

        GHAssertNotNil(obj, @"Failed to update: Prayer");
        GHAssertNil(error, @"Failed to update: Prayer (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Prayer class]], @"Expected 'Prayer', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.body isEqual:(@"testBody")], @"Expected '%@', got '%@'", @"testBody", obj.body);
        GHAssertTrue([obj.salutation isEqual:(@"testSalutation")], @"Expected '%@', got '%@'", @"testSalutation", obj.salutation);
        GHAssertTrue([obj.weekId isEqual:(@"testWeekId")], @"Expected '%@', got '%@'", @"testWeekId", obj.weekId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testPrayerDeleteAsync {
    [self prepare];

    Prayer * obj = [Prayer new];
    obj.id = @"generated_testId";

    [obj destroyAsync:^(id obj, NSError * error) {
        GHAssertNil(obj, @"Failed to delete: Prayer");
        GHAssertNil(error, @"Failed to delete: Prayer (%@)", [error localizedDescription]);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}


#pragma mark - 
#pragma mark Section

- (void)testSectionCreate {
    Section * obj = [Section new];
    obj.name = @"testName";
    obj.order = [NSNumber numberWithInt:-3639010014029403819];
    obj.toDoListId = @"testToDoListId";

    ToDoList * toDoList = [ToDoList new];
    toDoList.id = @"generated_testId";
    obj.toDoList = toDoList;

    [MockHTTPURLProtocol setRequestCallback:^(NSURLRequest *request) {
        NSString * data = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        
    
        NSError * toDoListError = nil;
        NSString * toDoListPattern = [NSString stringWithFormat:@"([\"'])%@\\1\\s*:\\s*([\"'])?%@\\2?",
                              [NSRegularExpression escapedPatternForString:@"to_do_list_id"],
                              [NSRegularExpression escapedPatternForString:[NSString stringWithFormat:@"%@", (toDoList.id)]]];
        NSRegularExpression * toDoListRegex = [NSRegularExpression regularExpressionWithPattern:toDoListPattern options:0 error:&toDoListError];
        GHAssertNil(toDoListError, @"Error in regex: %@", [toDoListError localizedDescription]);
        GHAssertTrue([toDoListRegex numberOfMatchesInString:data options:0 range:NSMakeRange(0, data.length)] == 1, @"Unable to find correct FK value (%@) in request: %@", (toDoList.id), data);

    }];

    NSError * error = nil;
    BOOL created = [obj create:&error];

    [MockHTTPURLProtocol setRequestCallback:nil];

    GHAssertTrue(created, @"Failed to create: Section");
    GHAssertNil(error, @"Failed to create: Section (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
    GHAssertTrue([obj.toDoListId isEqual:(@"testToDoListId")], @"Expected '%@', got '%@'", @"testToDoListId", obj.toDoListId);
}

- (void)testSectionRead {
    Section * obj = [Section new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL read = [obj refresh:&error];

    GHAssertTrue(read, @"Failed to read: Section");
    GHAssertNil(error, @"Failed to read: Section (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
    GHAssertTrue([obj.toDoListId isEqual:(@"testToDoListId")], @"Expected '%@', got '%@'", @"testToDoListId", obj.toDoListId);
}

- (void)testSectionReadAll {
    NSError * error = nil;
    NSArray * objs = [Section query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Section");
    GHAssertNotNil(objs, @"Failed to read all: Section");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    Section * obj = [objs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
    GHAssertTrue([obj.toDoListId isEqual:(@"testToDoListId")], @"Expected '%@', got '%@'", @"testToDoListId", obj.toDoListId);
}

- (void)testSectionReadAllLocal {
    NSError * error = nil;
    NSArray * objs = [Section query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Section");
    GHAssertNotNil(objs, @"Failed to read all: Section");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Section queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Section");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Section");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);
    Section * obj = [localObjs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
    GHAssertTrue([obj.toDoListId isEqual:(@"testToDoListId")], @"Expected '%@', got '%@'", @"testToDoListId", obj.toDoListId);
}

- (void)testSectionUpdate {
    Section * obj = [Section new];
    obj.id = @"generated_testId";
    obj.name = @"testName";
    obj.order = [NSNumber numberWithInt:-3639010014029403819];
    obj.toDoListId = @"testToDoListId";

    NSError * error = nil;
    BOOL updated = [obj update:&error];

    GHAssertTrue(updated, @"Failed to update: Section");
    GHAssertNil(error, @"Failed to update: Section (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
    GHAssertTrue([obj.toDoListId isEqual:(@"testToDoListId")], @"Expected '%@', got '%@'", @"testToDoListId", obj.toDoListId);
}

- (void)testSectionDelete {
    Section * obj = [Section new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL deleted = [obj destroy:&error];

    GHAssertTrue(deleted, @"Failed to delete: Section");
    GHAssertNil(error, @"Failed to delete: Section (%@)", [error localizedDescription]);
}

- (void)testSectionDeleteAllLocal {
    NSError * error = nil;
    NSArray * objs = [Section query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Section");
    GHAssertNotNil(objs, @"Failed to read all: Section");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Section queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Section");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Section");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);

    [Section deleteAllLocal];
    GHAssertNil(error, @"Failed to delete all locally: Section");

    NSArray * deletedObjs = [Section queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Section");
    GHAssertNotNil(deletedObjs, @"Failed to read all locally: Section");
    GHAssertTrue(deletedObjs.count == 0, @"Expected '0' object(s), got '%d'", deletedObjs.count);
}

- (void)testSectionCreateAsync {
    [self prepare];

    Section * obj = [Section new];
    obj.name = @"testName";
    obj.order = [NSNumber numberWithInt:-3639010014029403819];
    obj.toDoListId = @"testToDoListId";

    [obj createAsync:^(id object, NSError * error) {
        Section * obj = (Section *)object;

        GHAssertNotNil(obj, @"Failed to create: Section");
        GHAssertNil(error, @"Failed to create: Section (%@)", [error localizedDescription]);        
        GHAssertTrue([obj isKindOfClass:[Section class]], @"Expected 'Section', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
        GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
        GHAssertTrue([obj.toDoListId isEqual:(@"testToDoListId")], @"Expected '%@', got '%@'", @"testToDoListId", obj.toDoListId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testSectionReadAsync {
    [self prepare];

    Section * obj = [Section new];
    obj.id = @"generated_testId";

    [obj refreshAsync:^(id object, NSError * error) {
        Section * obj = (Section *)object;

        GHAssertNotNil(obj, @"Failed to read: Section");
        GHAssertNil(error, @"Failed to read: Section (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Section class]], @"Expected 'Section', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
        GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
        GHAssertTrue([obj.toDoListId isEqual:(@"testToDoListId")], @"Expected '%@', got '%@'", @"testToDoListId", obj.toDoListId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testSectionReadAllAsync {
    [self prepare];

    [Section query:@"all" params:@{ } async:^(NSArray * objs, NSError * error) {
        GHAssertNil(error, @"Failed to read all: Section");
        GHAssertNotNil(objs, @"Failed to read all: Section");
        GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

        Section * obj = [objs objectAtIndex:0];
        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
        GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
        GHAssertTrue([obj.toDoListId isEqual:(@"testToDoListId")], @"Expected '%@', got '%@'", @"testToDoListId", obj.toDoListId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testSectionUpdateAsync {
    [self prepare];

    Section * obj = [Section new];
    obj.id = @"generated_testId";
    obj.name = @"testName";
    obj.order = [NSNumber numberWithInt:-3639010014029403819];
    obj.toDoListId = @"testToDoListId";

    [obj updateAsync:^(id object, NSError * error) {
        Section * obj = (Section *)object;

        GHAssertNotNil(obj, @"Failed to update: Section");
        GHAssertNil(error, @"Failed to update: Section (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Section class]], @"Expected 'Section', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
        GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
        GHAssertTrue([obj.toDoListId isEqual:(@"testToDoListId")], @"Expected '%@', got '%@'", @"testToDoListId", obj.toDoListId);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testSectionDeleteAsync {
    [self prepare];

    Section * obj = [Section new];
    obj.id = @"generated_testId";

    [obj destroyAsync:^(id obj, NSError * error) {
        GHAssertNil(obj, @"Failed to delete: Section");
        GHAssertNil(error, @"Failed to delete: Section (%@)", [error localizedDescription]);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}


#pragma mark - 
#pragma mark ToDoList

- (void)testToDoListCreate {
    ToDoList * obj = [ToDoList new];
    obj.name = @"testName";
    obj.order = [NSNumber numberWithInt:-3639010014029403819];

    NSError * error = nil;
    BOOL created = [obj create:&error];

    GHAssertTrue(created, @"Failed to create: ToDoList");
    GHAssertNil(error, @"Failed to create: ToDoList (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
}

- (void)testToDoListRead {
    ToDoList * obj = [ToDoList new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL read = [obj refresh:&error];

    GHAssertTrue(read, @"Failed to read: ToDoList");
    GHAssertNil(error, @"Failed to read: ToDoList (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
}

- (void)testToDoListReadAll {
    NSError * error = nil;
    NSArray * objs = [ToDoList query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: ToDoList");
    GHAssertNotNil(objs, @"Failed to read all: ToDoList");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    ToDoList * obj = [objs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
}

- (void)testToDoListReadAllLocal {
    NSError * error = nil;
    NSArray * objs = [ToDoList query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: ToDoList");
    GHAssertNotNil(objs, @"Failed to read all: ToDoList");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [ToDoList queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: ToDoList");
    GHAssertNotNil(localObjs, @"Failed to read all locally: ToDoList");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);
    ToDoList * obj = [localObjs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
}

- (void)testToDoListUpdate {
    ToDoList * obj = [ToDoList new];
    obj.id = @"generated_testId";
    obj.name = @"testName";
    obj.order = [NSNumber numberWithInt:-3639010014029403819];

    NSError * error = nil;
    BOOL updated = [obj update:&error];

    GHAssertTrue(updated, @"Failed to update: ToDoList");
    GHAssertNil(error, @"Failed to update: ToDoList (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
    GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);
}

- (void)testToDoListDelete {
    ToDoList * obj = [ToDoList new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL deleted = [obj destroy:&error];

    GHAssertTrue(deleted, @"Failed to delete: ToDoList");
    GHAssertNil(error, @"Failed to delete: ToDoList (%@)", [error localizedDescription]);
}

- (void)testToDoListDeleteAllLocal {
    NSError * error = nil;
    NSArray * objs = [ToDoList query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: ToDoList");
    GHAssertNotNil(objs, @"Failed to read all: ToDoList");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [ToDoList queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: ToDoList");
    GHAssertNotNil(localObjs, @"Failed to read all locally: ToDoList");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);

    [ToDoList deleteAllLocal];
    GHAssertNil(error, @"Failed to delete all locally: ToDoList");

    NSArray * deletedObjs = [ToDoList queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: ToDoList");
    GHAssertNotNil(deletedObjs, @"Failed to read all locally: ToDoList");
    GHAssertTrue(deletedObjs.count == 0, @"Expected '0' object(s), got '%d'", deletedObjs.count);
}

- (void)testToDoListCreateAsync {
    [self prepare];

    ToDoList * obj = [ToDoList new];
    obj.name = @"testName";
    obj.order = [NSNumber numberWithInt:-3639010014029403819];

    [obj createAsync:^(id object, NSError * error) {
        ToDoList * obj = (ToDoList *)object;

        GHAssertNotNil(obj, @"Failed to create: ToDoList");
        GHAssertNil(error, @"Failed to create: ToDoList (%@)", [error localizedDescription]);        
        GHAssertTrue([obj isKindOfClass:[ToDoList class]], @"Expected 'ToDoList', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
        GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testToDoListReadAsync {
    [self prepare];

    ToDoList * obj = [ToDoList new];
    obj.id = @"generated_testId";

    [obj refreshAsync:^(id object, NSError * error) {
        ToDoList * obj = (ToDoList *)object;

        GHAssertNotNil(obj, @"Failed to read: ToDoList");
        GHAssertNil(error, @"Failed to read: ToDoList (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[ToDoList class]], @"Expected 'ToDoList', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
        GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testToDoListReadAllAsync {
    [self prepare];

    [ToDoList query:@"all" params:@{ } async:^(NSArray * objs, NSError * error) {
        GHAssertNil(error, @"Failed to read all: ToDoList");
        GHAssertNotNil(objs, @"Failed to read all: ToDoList");
        GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

        ToDoList * obj = [objs objectAtIndex:0];
        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
        GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testToDoListUpdateAsync {
    [self prepare];

    ToDoList * obj = [ToDoList new];
    obj.id = @"generated_testId";
    obj.name = @"testName";
    obj.order = [NSNumber numberWithInt:-3639010014029403819];

    [obj updateAsync:^(id object, NSError * error) {
        ToDoList * obj = (ToDoList *)object;

        GHAssertNotNil(obj, @"Failed to update: ToDoList");
        GHAssertNil(error, @"Failed to update: ToDoList (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[ToDoList class]], @"Expected 'ToDoList', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.name isEqual:(@"testName")], @"Expected '%@', got '%@'", @"testName", obj.name);
        GHAssertTrue([obj.order isEqual:([NSNumber numberWithInt:-3639010014029403819])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:-3639010014029403819], obj.order);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testToDoListDeleteAsync {
    [self prepare];

    ToDoList * obj = [ToDoList new];
    obj.id = @"generated_testId";

    [obj destroyAsync:^(id obj, NSError * error) {
        GHAssertNil(obj, @"Failed to delete: ToDoList");
        GHAssertNil(error, @"Failed to delete: ToDoList (%@)", [error localizedDescription]);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}


#pragma mark - 
#pragma mark Week

- (void)testWeekCreate {
    Week * obj = [Week new];
    obj.theme = @"testTheme";
    obj.weekNumber = [NSNumber numberWithInt:3332882137257756470];

    NSError * error = nil;
    BOOL created = [obj create:&error];

    GHAssertTrue(created, @"Failed to create: Week");
    GHAssertNil(error, @"Failed to create: Week (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.theme isEqual:(@"testTheme")], @"Expected '%@', got '%@'", @"testTheme", obj.theme);
    GHAssertTrue([obj.weekNumber isEqual:([NSNumber numberWithInt:3332882137257756470])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:3332882137257756470], obj.weekNumber);
}

- (void)testWeekRead {
    Week * obj = [Week new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL read = [obj refresh:&error];

    GHAssertTrue(read, @"Failed to read: Week");
    GHAssertNil(error, @"Failed to read: Week (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.theme isEqual:(@"testTheme")], @"Expected '%@', got '%@'", @"testTheme", obj.theme);
    GHAssertTrue([obj.weekNumber isEqual:([NSNumber numberWithInt:3332882137257756470])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:3332882137257756470], obj.weekNumber);
}

- (void)testWeekReadAll {
    NSError * error = nil;
    NSArray * objs = [Week query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Week");
    GHAssertNotNil(objs, @"Failed to read all: Week");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    Week * obj = [objs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.theme isEqual:(@"testTheme")], @"Expected '%@', got '%@'", @"testTheme", obj.theme);
    GHAssertTrue([obj.weekNumber isEqual:([NSNumber numberWithInt:3332882137257756470])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:3332882137257756470], obj.weekNumber);
}

- (void)testWeekReadAllLocal {
    NSError * error = nil;
    NSArray * objs = [Week query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Week");
    GHAssertNotNil(objs, @"Failed to read all: Week");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Week queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Week");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Week");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);
    Week * obj = [localObjs objectAtIndex:0];
    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.theme isEqual:(@"testTheme")], @"Expected '%@', got '%@'", @"testTheme", obj.theme);
    GHAssertTrue([obj.weekNumber isEqual:([NSNumber numberWithInt:3332882137257756470])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:3332882137257756470], obj.weekNumber);
}

- (void)testWeekUpdate {
    Week * obj = [Week new];
    obj.id = @"generated_testId";
    obj.theme = @"testTheme";
    obj.weekNumber = [NSNumber numberWithInt:3332882137257756470];

    NSError * error = nil;
    BOOL updated = [obj update:&error];

    GHAssertTrue(updated, @"Failed to update: Week");
    GHAssertNil(error, @"Failed to update: Week (%@)", [error localizedDescription]);

    GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
    GHAssertTrue([obj.theme isEqual:(@"testTheme")], @"Expected '%@', got '%@'", @"testTheme", obj.theme);
    GHAssertTrue([obj.weekNumber isEqual:([NSNumber numberWithInt:3332882137257756470])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:3332882137257756470], obj.weekNumber);
}

- (void)testWeekDelete {
    Week * obj = [Week new];
    obj.id = @"generated_testId";

    NSError * error = nil;
    BOOL deleted = [obj destroy:&error];

    GHAssertTrue(deleted, @"Failed to delete: Week");
    GHAssertNil(error, @"Failed to delete: Week (%@)", [error localizedDescription]);
}

- (void)testWeekDeleteAllLocal {
    NSError * error = nil;
    NSArray * objs = [Week query:@"all" params:@{ } error:&error];

    GHAssertNil(error, @"Failed to read all: Week");
    GHAssertNotNil(objs, @"Failed to read all: Week");
    GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

    NSArray * localObjs = [Week queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Week");
    GHAssertNotNil(localObjs, @"Failed to read all locally: Week");
    GHAssertTrue(localObjs.count == 1, @"Expected '1' object(s), got '%d'", localObjs.count);

    [Week deleteAllLocal];
    GHAssertNil(error, @"Failed to delete all locally: Week");

    NSArray * deletedObjs = [Week queryLocal:@"all" params:@{ }];
    GHAssertNil(error, @"Failed to read all locally: Week");
    GHAssertNotNil(deletedObjs, @"Failed to read all locally: Week");
    GHAssertTrue(deletedObjs.count == 0, @"Expected '0' object(s), got '%d'", deletedObjs.count);
}

- (void)testWeekCreateAsync {
    [self prepare];

    Week * obj = [Week new];
    obj.theme = @"testTheme";
    obj.weekNumber = [NSNumber numberWithInt:3332882137257756470];

    [obj createAsync:^(id object, NSError * error) {
        Week * obj = (Week *)object;

        GHAssertNotNil(obj, @"Failed to create: Week");
        GHAssertNil(error, @"Failed to create: Week (%@)", [error localizedDescription]);        
        GHAssertTrue([obj isKindOfClass:[Week class]], @"Expected 'Week', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.theme isEqual:(@"testTheme")], @"Expected '%@', got '%@'", @"testTheme", obj.theme);
        GHAssertTrue([obj.weekNumber isEqual:([NSNumber numberWithInt:3332882137257756470])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:3332882137257756470], obj.weekNumber);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testWeekReadAsync {
    [self prepare];

    Week * obj = [Week new];
    obj.id = @"generated_testId";

    [obj refreshAsync:^(id object, NSError * error) {
        Week * obj = (Week *)object;

        GHAssertNotNil(obj, @"Failed to read: Week");
        GHAssertNil(error, @"Failed to read: Week (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Week class]], @"Expected 'Week', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.theme isEqual:(@"testTheme")], @"Expected '%@', got '%@'", @"testTheme", obj.theme);
        GHAssertTrue([obj.weekNumber isEqual:([NSNumber numberWithInt:3332882137257756470])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:3332882137257756470], obj.weekNumber);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testWeekReadAllAsync {
    [self prepare];

    [Week query:@"all" params:@{ } async:^(NSArray * objs, NSError * error) {
        GHAssertNil(error, @"Failed to read all: Week");
        GHAssertNotNil(objs, @"Failed to read all: Week");
        GHAssertTrue(objs.count == 1, @"Expected '1' object(s), got '%d'", objs.count);

        Week * obj = [objs objectAtIndex:0];
        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.theme isEqual:(@"testTheme")], @"Expected '%@', got '%@'", @"testTheme", obj.theme);
        GHAssertTrue([obj.weekNumber isEqual:([NSNumber numberWithInt:3332882137257756470])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:3332882137257756470], obj.weekNumber);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testWeekUpdateAsync {
    [self prepare];

    Week * obj = [Week new];
    obj.id = @"generated_testId";
    obj.theme = @"testTheme";
    obj.weekNumber = [NSNumber numberWithInt:3332882137257756470];

    [obj updateAsync:^(id object, NSError * error) {
        Week * obj = (Week *)object;

        GHAssertNotNil(obj, @"Failed to update: Week");
        GHAssertNil(error, @"Failed to update: Week (%@)", [error localizedDescription]);
        GHAssertTrue([obj isKindOfClass:[Week class]], @"Expected 'Week', got '%@'", [obj class]);

        GHAssertTrue([obj.id isEqual:(@"generated_testId")], @"Expected '%@', got '%@'", @"generated_testId", obj.id);
        GHAssertTrue([obj.theme isEqual:(@"testTheme")], @"Expected '%@', got '%@'", @"testTheme", obj.theme);
        GHAssertTrue([obj.weekNumber isEqual:([NSNumber numberWithInt:3332882137257756470])], @"Expected '%@', got '%@'", [NSNumber numberWithInt:3332882137257756470], obj.weekNumber);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)testWeekDeleteAsync {
    [self prepare];

    Week * obj = [Week new];
    obj.id = @"generated_testId";

    [obj destroyAsync:^(id obj, NSError * error) {
        GHAssertNil(obj, @"Failed to delete: Week");
        GHAssertNil(error, @"Failed to delete: Week (%@)", [error localizedDescription]);

        [self notify:kGHUnitWaitStatusSuccess];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}


#pragma mark -
#pragma mark Overrides

- (void)setUp {
    [NSURLProtocol registerClass:[MockHTTPURLProtocol class]];

    [APDataManager setDataManager:[[APDataManager alloc] initWithStore:kAPDataManagerStoreInMemory]];
    [APObject setBaseURL:[NSURL URLWithString:@"http://tests"]];
}

- (void)tearDown {
    [NSURLProtocol unregisterClass:[MockHTTPURLProtocol class]];
}

@end
