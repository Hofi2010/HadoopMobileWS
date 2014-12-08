//
//  HDFSClient.m
//  HadoopConnect
//
//  Created by KLAUS HOFENBITZER on 12/2/14.
//  Copyright (c) 2014 KLAUS HOFENBITZER. All rights reserved.
//
#import "NSDate+JSON.h"
#import "AFNetworking.h"
#import "AFJSONRequestOperation.h"

#import "HDFSClient.h"
#import "HDFSFileStatus.h"


AFHTTPClient *httpClient;

@implementation HDFSClient

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


// hdfs does not seem to look at the parameters
- (void) getList:(NSString *)dirPath success:(FileStatusArray)success {
    
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    // /user/hive/pokes.output/stdout?op=APPEND
    NSString * fullPath = [[NSString alloc] initWithFormat:@"webhdfs/v1%@?op=LISTSTATUS",dirPath];
    
    [httpClient getPath:fullPath parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    
                    //extract JSON FileStatus objects
                    /*
                    NSRange startRange = [responseStr rangeOfString:@"\["];
                    NSRange endRange = [responseStr rangeOfString:@"]"];
                    
                    if (startRange.location != NSNotFound && endRange.location != NSNotFound && endRange.location > startRange.location) {
                        responseStr = [responseStr substringWithRange:NSMakeRange(startRange.location, endRange.location-(startRange.location))];
                    }
                    */
                    
                    id responseArray = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                             options:0 error:nil];
                    
                    NSArray* itemDicts = [[responseArray objectForKey:@"FileStatuses"] objectForKey:@"FileStatus"];
                    NSMutableArray* items = [NSMutableArray arrayWithCapacity:itemDicts.count];
                    for( NSDictionary* itemDict in itemDicts ) {
                        HDFSFileStatus* item = [[HDFSFileStatus alloc] init];
                        [self fillFileStatus:item fromSummaryDict:itemDict];
                        [items addObject:item];
                    }

                    
                    if(success)
                        success(items);
                    
                    NSLog(@"Request Successful, response \n %@", responseStr);
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
                }];
}

- (void)fillFileStatus:(HDFSFileStatus*)item fromSummaryDict:(NSDictionary*)itemDict
{
    NSTimeInterval longDate = [[itemDict objectForKey:@"accessTime"] doubleValue]/1000;
    item.accessTime = [NSDate dateFromLong:longDate];
    item.blockSize = [itemDict objectForKey:@"blockSize"];
    item.userGroup = [itemDict objectForKey:@"group"];
    item.fileLength = [itemDict objectForKey:@"length"];
    item.modificationTime = [NSDate dateFromLong:[[itemDict objectForKey:@"modificationTime"] doubleValue]/1000];
    item.fileOwner = [itemDict objectForKey:@"owner"];
    item.pathSuffix = [itemDict objectForKey:@"pathSuffix"];
    item.filePermission = [itemDict objectForKey:@"permission"] ;
    item.fileReplication = [itemDict objectForKey:@"replication"];
    item.fileType = [itemDict objectForKey:@"type"];
}

// hdfs does not seem to look at the parameters
- (void) openFile:(NSString *)flePath success:(StringResult)success {
    

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
- (void)deleteFile:(NSString *)flePath success:(BoolResult)success{

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    // /user/hive/pokes.output/stdout?op=APPEND
    NSString * fullPath = [[NSString alloc] initWithFormat:@"webhdfs/v1%@?op=DELETE",flePath];
    
    [httpClient deletePath:fullPath parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"ASCII Delete File Successful, response '%@'", responseStr);
                    if(success)
                        success(true);
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"[ASCII Delete File Error]: %@", error.localizedDescription);
                }];
}

// hdfs does not seem to look at the parameters
- (void)createDir:(NSString *)flePath success:(BoolResult)success{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    // /user/hive/pokes.output/stdout?op=APPEND
    NSString * fullPath = [[NSString alloc] initWithFormat:@"webhdfs/v1%@?op=MKDIRS",flePath];
    
    [httpClient putPath:fullPath parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"ASCII Create Dir Successful, response '%@'", responseStr);
                    if(success)
                        success(true);
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"[ASCII Create Dir Error]: %@", error.localizedDescription);
                }];
}

// hdfs does not seem to look at the parameters
- (void)createFile:(NSString *)flePath success:(BoolResult)success{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    // /user/hive/pokes.output/stdout?op=APPEND
    NSString * fullPath = [[NSString alloc] initWithFormat:@"webhdfs/v1%@?op=CREATE",flePath];
    
    [httpClient putPath:fullPath parameters:params
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                     
                     NSLog(@"ASCII Create File Successful, response '%@'", responseStr);
                     if(success)
                         success(true);
    
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"[ASCII Create File Error]: %@", error.localizedDescription);
                 }];
}

// hdfs does not seem to look at the parameters
- (void)appendStringToFile:(NSString *)flePath string:(NSString *)string success:(BoolResult)success{
    
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
              success(true);
         }];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) redirectWriteFile:(NSURL *)url writeString:(NSString *)writeString op:(NSString *)op success:(StringResult)success{
    
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
