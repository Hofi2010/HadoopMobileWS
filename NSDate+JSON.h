//
//  NSDate+JSON.h
//  RunKeeper-iOS
//
//  Created by Reid van Melle on 11-09-15.
//  Copyright 2011 Brierwood Design Co-operative. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (JSON)

- (id)proxyForJson;

+ (NSDate*)dateFromJSONDate:(NSString*)string;

@end
