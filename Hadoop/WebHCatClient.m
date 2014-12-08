//
//  WebHCatClient.m
//  HadoopConnect
//
//  Created by KLAUS HOFENBITZER on 12/6/14.
//  Copyright (c) 2014 KLAUS HOFENBITZER. All rights reserved.
//
#import "AFNetworking.h"
#import "AFJSONRequestOperation.h"

#import "WebHCatClient.h"

AFHTTPClient *httpClient;

@implementation WebHCatClient

@synthesize baseURL = _baseURL;

- (id)initWithBaseURL:(NSURL *)url {
    
    NSParameterAssert(url);
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.baseURL = url;
    
    httpClient = [[AFHTTPClient alloc] initWithBaseURL:self.baseURL];
    
    return self;
}

- (void) executeHiveCommand: (NSString *)cmd outputFile:(NSString *)outputFile success:(StringResult)success{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"hive", @"user.name",
                            cmd, @"execute",
                            outputFile,@"statusdir",
                            nil];
    
    [httpClient postPath:@"/templeton/v1/hive" parameters:params
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                     NSLog(@"Request Successful, response '%@'", responseStr);
                     
                     if(success)
                         success(responseStr);
                     
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
                 }];
}


@end
