//
//  HDFSClient.h
//  HadoopConnect
//
//  Created by KLAUS HOFENBITZER on 12/2/14.
//  Copyright (c) 2014 KLAUS HOFENBITZER. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ASCIIFileContent)(NSString *);
typedef void(^NoContent) (void);

@interface HDFSClient : NSObject
    - (void) appendStringToFile:(NSString *)flePath string:(NSString *)string success:(NoContent)success;
    - (void) openFile:(NSString *)flePath success:(ASCIIFileContent)success;
    - (void)createFile:(NSString *)flePath success:(NoContent)success;
    - (void)deleteFile:(NSString *)flePath success:(NoContent)success;
@end
