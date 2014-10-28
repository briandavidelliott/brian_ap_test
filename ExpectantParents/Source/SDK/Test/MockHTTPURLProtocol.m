//
//  MockHTTPURLProtocol.m
//  Tests
//
//  Created by AnyPresence, Inc. on 10/22/12.
//  Copyright (c) 2012 AnyPresence, Inc.. All rights reserved.
//

#import "MockHTTPURLProtocol.h"

@implementation MockHTTPURLProtocol

__strong InspectRequest __inspectRequest;
__strong InspectResponse __inspectResponse;

#pragma mark - Public

+ (NSString *)responsePath:(NSURLRequest *)request
                   options:(MockHTTPURLProtocolPathOptions)options {
    NSString * path = [[[NSBundle mainBundle] resourcePath]
                       stringByAppendingPathComponent:@"mock"];
    path = [path stringByAppendingPathComponent:request.URL.host];
    
    if (request.URL.pathComponents.count > 1) {
        NSInteger idx = ((options & MockHTTPURLProtocolPathOptionIncludePath) ?
                         1 :
                         request.URL.pathComponents.count - 1);
        path = [path stringByAppendingPathComponent:[[request.URL.pathComponents subarrayWithRange:NSMakeRange(idx, request.URL.pathComponents.count - idx)] componentsJoinedByString:@"-"]];
    }
    
    if ((options & MockHTTPURLProtocolPathOptionIncludeQuery) && request.URL.query)
        path = [path stringByAppendingFormat:@"-%@",
                [request.URL.query stringByReplacingOccurrencesOfString:@"&"
                                                             withString:@"-"]];
    
    return [path stringByAppendingFormat:@"+%@", request.HTTPMethod];
}

+ (void)setRequestCallback:(InspectRequest)inspectRequest {
    __inspectRequest = [inspectRequest copy];
}

+ (void)setResponseCallback:(InspectResponse)inspectResponse {
    __inspectResponse = [inspectResponse copy];
}

#pragma mark - Overridables

+ (NSString *)responsePath:(NSURLRequest *)request {
    return [self responsePath:request
                      options:(MockHTTPURLProtocolPathOptionIncludePath |
                               MockHTTPURLProtocolPathOptionIncludeQuery)];
}

#pragma mark - Overrides

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return [[[request URL] scheme] isEqualToString:@"http"];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)stopLoading {
    
}

- (void)startLoading {
    // TODO: Make /, ?, & replacements configurable to avoid clashes.
    
#define ASSERT_OR_RETURN_PARSE_ERROR(c) \
if (!(c)) { \
/* TODO: Make sure domain/code are correct. */ \
[client URLProtocol:self didFailWithError:[NSError errorWithDomain:NSXMLParserErrorDomain \
code:NSXMLParserInternalError \
userInfo:@{ }]]; \
return; \
}
    
    NSURLRequest *request = [self request];
    id client = [self client];
    
    if (__inspectRequest)
        __inspectRequest(request);
    
    NSString * path = [[self class] responsePath:request];
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    NSString * separator = @"\n\n";
    NSRange separatorRange = [data rangeOfData:[separator dataUsingEncoding:NSUTF8StringEncoding]
                                       options:0
                                         range:NSMakeRange(0, data.length)];
    ASSERT_OR_RETURN_PARSE_ERROR(separatorRange.location != NSNotFound);
    
    NSString * header = [[NSString alloc] initWithBytes:data.bytes length:separatorRange.location encoding:NSUTF8StringEncoding];
    NSArray * lines = [header componentsSeparatedByString:@"\n"];
    ASSERT_OR_RETURN_PARSE_ERROR(lines.count > 0);
    
    NSString * firstLine = [lines objectAtIndex:0];
    NSInteger codeIdx = [firstLine rangeOfString:@" "].location;
    ASSERT_OR_RETURN_PARSE_ERROR(codeIdx != NSNotFound && codeIdx < firstLine.length - 1);
    ++codeIdx;
    
    NSInteger codeLength = [firstLine rangeOfString:@" " options:0 range:NSMakeRange(codeIdx,
                                                                                     firstLine.length - codeIdx)].location - codeIdx;
    ASSERT_OR_RETURN_PARSE_ERROR(codeLength != NSNotFound);
    
    NSInteger code = [[firstLine substringWithRange:NSMakeRange(codeIdx, codeLength)] integerValue];
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] initWithCapacity:lines.count - 1];
    for (NSInteger i = 1; i < lines.count; i++) {
        NSString * header = [lines objectAtIndex:i];
        NSInteger valueIdx = [header rangeOfString:@":"].location;
        ASSERT_OR_RETURN_PARSE_ERROR(valueIdx != NSNotFound && valueIdx < header.length - 1);
        
        [headers setObject:[[header substringWithRange:NSMakeRange(valueIdx + 1, header.length - valueIdx - 1)]
                            stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
                    forKey:[[header substringWithRange:NSMakeRange(0, valueIdx)]
                            stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
    
    NSHTTPURLResponse * response = [[NSHTTPURLResponse alloc] initWithURL:request.URL
                                                               statusCode:code
                                                              HTTPVersion:@"1.0"
                                                             headerFields:headers];
    NSData * body = [data subdataWithRange:NSMakeRange(separatorRange.location + separatorRange.length,
                                                       data.length - separatorRange.location - separatorRange.length)];
    if (__inspectResponse)
        __inspectResponse(response, data);
    
    [client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [client URLProtocol:self didLoadData:body];
    [client URLProtocolDidFinishLoading:self];
}

@end
