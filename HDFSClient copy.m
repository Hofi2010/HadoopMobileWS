//
//  HDFSClient.m
//  HadoopConnect
//
//  Created by KLAUS HOFENBITZER on 12/2/14.
//  Copyright (c) 2014 KLAUS HOFENBITZER. All rights reserved.
//
#import "AFNetworking.h"
#import "AFJSONRequestOperation.h"

#import "HDFSClient.h"

NSString *const kHDFSBaseURL = @"http://192.168.1.129:50070/";

@implementation HDFSClient

// hdfs does not seem to look at the parameters
- (void) openFile:(NSString *)flePath success:(ASCIIFileContent)success {
    NSURL *url = [NSURL URLWithString:kHDFSBaseURL];
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    // /user/hive/pokes.output/stdout?op=APPEND
    NSString * fullPath = [[NSString alloc] initWithFormat:@"webhdfs/v1%@?op=OPEN",flePath];
    
    [httpClient getPath:fullPath parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         success(responseStr);
         
         NSLog(@"Request Successful, response \n %@", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

// hdfs does not seem to look at the parameters
- (void)deleteFile:(NSString *)flePath success:(NoContent)success{
    NSURL *url = [NSURL URLWithString:kHDFSBaseURL];
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    //httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    // /user/hive/pokes.output/stdout?op=APPEND
    NSString * fullPath = [[NSString alloc] initWithFormat:@"webhdfs/v1%@?op=DELETE",flePath];
    
    [httpClient deletePath:fullPath parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"ASCII Delete File Successful, response '%@'", responseStr);
                    if(success)
                        success();
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"[ASCII Delete File Error]: %@", error.localizedDescription);
                }];
}

// hdfs does not seem to look at the parameters
- (void)createFile:(NSString *)flePath success:(NoContent)success{
    NSURL *url = [NSURL URLWithString:kHDFSBaseURL];
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    //httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    // /user/hive/pokes.output/stdout?op=APPEND
    NSString * fullPath = [[NSString alloc] initWithFormat:@"webhdfs/v1%@?op=CREATE",flePath];
    
    [httpClient putPath:fullPath parameters:params
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                     
                     NSLog(@"ASCII Create File Successful, response '%@'", responseStr);
                     if(success)
                         success();
    
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"[ASCII Create File Error]: %@", error.localizedDescription);
                 }];
}

// hdfs does not seem to look at the parameters
- (void)appendStringToFile:(NSString *)flePath string:(NSString *)string success:(NoContent)success{
    NSURL *url = [NSURL URLWithString:kHDFSBaseURL];
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    //httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    // /user/hive/pokes.output/stdout?op=APPEND
    NSString * fullPath = [[NSString alloc] initWithFormat:@"webhdfs/v1%@?op=APPEND",flePath];
    
    [httpClient postPath:fullPath parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         NSURL * redirectURL = [[operation response] URL];
         NSString * redirectStr = [redirectURL absoluteString];
         redirectStr = [redirectStr stringByReplacingOccurrencesOfString:@"sandbox.hortonworks.com"
                                                withString:@"192.168.1.129"];
        
         redirectURL = [NSURL URLWithString:redirectStr];
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         // pass on the re-direct path
         //[self redirectAppendFile:[[operation response] URL] appendString:string];
         [self redirectWriteFile:redirectURL writeString:string op:@"POST" success:^(NSString *content){
             if(success)
              success();
         }];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) redirectWriteFile:(NSURL *)url writeString:(NSString *)writeString op:(NSString *)op success:(ASCIIFileContent)success{
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url.absoluteString]];
    [request setHTTPMethod:op];
    
    //set headers
    NSString *contentType = @"text/xml";
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request addValue:@"any-value" forHTTPHeaderField: @"User-Agent"];
    
    //create the body
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[writeString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //post
    [request setHTTPBody:postBody];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSLog(@"Append Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        success(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Append Error: %@", error);
    }];
    [operation start];
}

@end
