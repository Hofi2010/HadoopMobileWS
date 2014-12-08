//
//  MOTSettingsData.m
//  MOTIV8
//
//  Created by KLAUS HOFENBITZER on 2/13/14.
//  Copyright (c) 2014 KLAUS HOFENBITZER. All rights reserved.
//

#import "MOTSettingsData.h"

@implementation MOTSettingsData

- (id) init
{
    self = [super init];
    if (self)
    {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        // load from single file
        NSString *fileName = [NSString stringWithFormat:@"SettingsData"];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        
        NSLog(@"Read from file: %@ %d", filePath, fileExists);
        
        if(fileExists == YES)
            self = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        _MOTIV8_UUID = @"4b5894ad-2919-442d-9300-7493669046e4";
        _ON11_UUID = @"dfcf128d-a88c-4f26-9d26-1dba2e31ef2e";
    }
    return self;
}

-(bool)writeToFile{
    bool return_val = NO;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // save to single file
    NSString *fileName = [NSString stringWithFormat:@"SettingsData"];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSLog(@"Write to file: %@", filePath);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory])
        NSLog(@"applicationDocumentsDir exists");
    
    
    if([NSKeyedArchiver archiveRootObject:self toFile:filePath] == NO)
        NSLog(@"Not a valid array");
    else return_val = YES;
    
    return return_val;
}

-(void)saveData
{
    [self writeToFile];
}

-(void)loadData
{
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:_age forKey:@"age"];
    [encoder encodeDouble:_weight forKey:@"weight"];
    [encoder encodeInt:_height forKey:@"height"];
    [encoder encodeInt:_unit_system forKey:@"unit_system"];
    [encoder encodeInt:_gender forKey:@"gender"];
    
    [encoder encodeInt:_show_seconds forKey:@"show_seconds"];
    [encoder encodeInt:_show_graph forKey:@"show_graph"];
    [encoder encodeInt:_show_heartrate forKey:@"show_heartrate"];
    
    [encoder encodeInt:_activity_goal forKey:@"activity_goal"];
    [encoder encodeInt:_calorie_burned_goal forKey:@"calorie_burned_goal"];
    [encoder encodeInt:_calorie_consumed_goal forKey:@"calorie_consumed_goal"];
    [encoder encodeInt:_min_heartrate forKey:@"min_heartrate"];
    [encoder encodeInt:_max_heartrate forKey:@"max_heartrate"];
    
    [encoder encodeBool:_dirty_settings forKey:@"dirty_settings"];
    [encoder encodeObject:_heartMonitorDevice forKey:@"HeartMonitorDevice"];
    [encoder encodeObject:_pbbleAppUUID forKey:@"PebbleAppUUID"];

}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _age = [decoder decodeIntForKey:@"age"];
        _weight = [decoder decodeDoubleForKey:@"weight"];
        _height = [decoder decodeIntForKey:@"height"];
        _unit_system = [decoder decodeIntForKey:@"unit_system"];
        _gender = [decoder decodeIntForKey:@"gender"];
        
        _show_seconds = [decoder decodeIntForKey:@"show_seconds"];
        _show_graph = [decoder decodeIntForKey:@"show_graph"];
        _show_heartrate = [decoder decodeIntForKey:@"show_heartrate"];
        
        _activity_goal = [decoder decodeIntForKey:@"activity_goal"];
        _calorie_burned_goal = [decoder decodeIntForKey:@"calorie_burned_goal"];
        _calorie_consumed_goal = [decoder decodeIntForKey:@"calorie_consumed_goal"];
        _min_heartrate = [decoder decodeIntForKey:@"min_heartrate"];
        _max_heartrate = [decoder decodeIntForKey:@"max_heartrate"];
        
        _dirty_settings = [decoder decodeBoolForKey:@"dirty_settings"];
        _heartMonitorDevice = [decoder decodeObjectForKey:@"HeartMonitorDevice"];
        _pbbleAppUUID =  [decoder decodeObjectForKey:@"PebbleAppUUID"];
        
        if(_pbbleAppUUID == (NSString *)nil)
        {
            // default MOTIV8
            _pbbleAppUUID =_MOTIV8_UUID;
        }
    }
    return self;
}

+ (MOTSettingsData *)sharedInstance
{
    static MOTSettingsData *_sharedInstance = nil;
    static dispatch_once_t onceSecurePredicate;
    dispatch_once(&onceSecurePredicate,^
                  {
                      _sharedInstance = [[self alloc] init];
                  });
    
    return _sharedInstance;
}

@end
