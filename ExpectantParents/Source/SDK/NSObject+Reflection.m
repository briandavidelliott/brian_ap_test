//
//  NSObject+Reflection.m
//  AnyPresence SDK
//
//  Created by Ruslan Sokolov on 3/31/13.
//  Copyright (c) 2013 AnyPresence, Inc. All rights reserved.
//

#import <objc/runtime.h>
#import "ISO8601DateFormatter.h"
#import "NSObject+Reflection.h"
#import "NSString+Inflections.h"

@implementation NSObject (Reflection)

#pragma mark - Public

- (id)encodeValue:(id)value ofType:(Class)type {
    if (type == [NSDate class] || class_getSuperclass(type) == [NSDate class]) {
        assert([value isKindOfClass:[NSDate class]]);
        
        // Submit in UTC instead of local time zone.
        NSTimeZone * defaultTimeZone = [NSTimeZone defaultTimeZone];
        [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        
        ISO8601DateFormatter * formatter = [ISO8601DateFormatter new];
        formatter.format = ISO8601DateFormatCalendar;
        formatter.includeTime = YES;
        
        NSString * formatted = [formatter stringFromDate:value];
        [NSTimeZone setDefaultTimeZone:defaultTimeZone];
        
        return formatted;
    } else {
        return value;
    }
}

- (id)decodeValue:(id)value ofType:(Class)type {
    if (![value isKindOfClass:type]) {
        if (!value || ([value isKindOfClass:[NSString class]] && [value length] == 0))
            return nil;
        
        if (type == [NSDate class]) {
            assert([value isKindOfClass:[NSString class]]);
            
            // HACK: Dates are returned without time zone; assume UTC instead of local time zone
            NSTimeZone * defaultTimeZone = [NSTimeZone defaultTimeZone];
            [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
            
            ISO8601DateFormatter * formatter = [ISO8601DateFormatter new];
            NSDate * date = [formatter dateFromString:value];
            [NSTimeZone setDefaultTimeZone:defaultTimeZone];
            
            return date;
        } else if (type == [NSNumber class]) {
            return [NSNumber numberWithDouble:[value doubleValue]];
        } else if (type == [NSString class]) {
            return [value description];
        } else if (type == [NSArray class]) {
            return @[ value ];
        } else if (type == [NSDictionary class]) {
            return @{ @"": value };
        }
    }
    
    return value;
}

@end
