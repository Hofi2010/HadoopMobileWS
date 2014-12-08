//
//  WebHCatClient.h
//  HadoopConnect
//
//  Created by KLAUS HOFENBITZER on 12/6/14.
//  Copyright (c) 2014 KLAUS HOFENBITZER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefinitions.h"

@interface WebHCatClient : NSObject

@property (readwrite, nonatomic, strong) NSURL *baseURL;

    /**
     Initializes an `WebHCatClient` object with the specified base URL.
     
     This is the designated initializer.
     
     @param url The base URL for the WebHCatClient. This argument must not be `nil`.
     
     @return The newly-initialized WebHCatClient 
     */
    - (id)initWithBaseURL:(NSURL *)url;

    - (void) executeHiveCommand: (NSString *)cmd outputFile:(NSString *)outputFile success:(StringResult)success;
@end
