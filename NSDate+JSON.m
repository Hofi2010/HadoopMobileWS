//
//  NSDate+JSON.m
//  RunKeeper-iOS
//
//  Created by Reid van Melle on 11-09-15.
//  Copyright 2011 Brierwood Design Co-operative. All rights reserved.
//

#import "NSDate+JSON.h"


@implementation NSDate (JSON)

/// "Sat, 1 Jan 2011 00:00:00"
- (id)proxyForJson {
    NSDate *date = [NSDate date];
    time_t time = [date timeIntervalSince1970];
    struct tm timeStruct;
    localtime_r(&time, &timeStruct);
    char buffer[80];
    strftime(buffer, 80, "%a, %d %b %Y %H:%M:%S", &timeStruct);
    return [NSString stringWithCString:buffer encoding:NSASCIIStringEncoding];
}

+ (NSDate*)dateFromJSONDate:(NSString*)string
{
    if (!string) {
        return nil;
    }
    
    struct tm tm;
    time_t t;
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%a, %d %b %Y %H:%M:%S", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    
    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
}

@end