//
//  HDFSClient.h
//  HadoopConnect
//
//  Created by KLAUS HOFENBITZER on 12/2/14.
//  Copyright (c) 2014 KLAUS HOFENBITZER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefinitions.h"


@interface HDFSClient : NSObject

@property (readwrite, nonatomic, strong) NSURL *baseURL;

    - (void) appendStringToFile:(NSString *)flePath string:(NSString *)string success:(BoolResult)success;
    - (void) openFile:(NSString *)flePath success:(StringResult)success;
    - (void) createFile:(NSString *)flePath success:(BoolResult)success;
    - (void) createDir:(NSString *)flePath success:(BoolResult)success;
    - (void) deleteFile:(NSString *)flePath success:(BoolResult)success;
    - (void) getList:(NSString *)dirPath success:(FileStatusArray)success;
    /**
     Initializes an `HDFSClient` object with the specified base URL.
     
     This is the designated initializer.
     
     @param url The base URL for the HDFS client. This argument must not be `nil`.
     
     @return The newly-initialized HDFS client
     */
    - (id)initWithBaseURL:(NSURL *)url;
@end


