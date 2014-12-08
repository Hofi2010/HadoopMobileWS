//
//  HDFSFileStatus.h
//  HadoopConnect
//
//  Created by KLAUS HOFENBITZER on 12/7/14.
//  Copyright (c) 2014 KLAUS HOFENBITZER. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "accessTime"      : 1320171722771,
 "blockSize"       : 33554432,
 "group"           : "supergroup",
 "length"          : 24930,
 "modificationTime": 1320171722771,
 "owner"           : "webuser",
 "pathSuffix"      : "a.patch",
 "permission"      : "644",
 "replication"     : 1,
 "type"            : "FILE" / "DIRECTORY"
 
 
 "accessTime"      : 0,
 "blockSize"       : 0,
 "group"           : "supergroup",
 "length"          : 0,
 "modificationTime": 1320895981256,
 "owner"           : "szetszwo",
 "pathSuffix"      : "bar",
 "permission"      : "711",
 "replication"     : 0,
 "type"            : "DIRECTORY"
*/

@interface HDFSFileStatus : NSObject

// The time last accessed
@property (nonatomic, strong) NSDate* accessTime;

// blocksize
@property (nonatomic, strong) NSNumber* blockSize;

@property (nonatomic, strong) NSString* userGroup;

@property (nonatomic, strong) NSNumber* fileLength;

@property (nonatomic, strong) NSDate* modificationTime;

@property (nonatomic, strong) NSString* fileOwner;

// this is actual file or directory name
@property (nonatomic, strong) NSString* pathSuffix;

@property (nonatomic, strong) NSNumber* filePermission;

@property (nonatomic, strong) NSNumber* fileReplication;

@property (nonatomic, strong) NSString* fileType;

@end
