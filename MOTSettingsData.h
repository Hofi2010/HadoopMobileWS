//
//  MOTSettingsData.h
//  MOTIV8
//
//  Created by KLAUS HOFENBITZER on 2/13/14.
//  Copyright (c) 2014 KLAUS HOFENBITZER. All rights reserved.
//

#import <Foundation/Foundation.h>
@import HealthKit;


@interface MOTSettingsData : NSObject<NSCoding>

enum egender{
    female = 0,
    male = 1
};

enum eunit_system{
    metrics = 0,
    imperial =1
};

@property (assign) int age;                      // gae in years
@property (assign) double weight;                   // weight in kg
@property (assign) int height;                   // in cm
@property (assign) int unit_system;              // 1 = metrics 0 = imperial
@property (assign) int gender;                   // 1 = male 0 = female

@property (assign) int show_seconds;             // show the secondds on the watch
@property (assign) int show_graph;               // enable the graph function on the pebble
@property (assign) int show_heartrate;           // show heartrate instead of activities
@property (assign) int reset_counts;             // reset counts on the pebble when set to 1

@property (assign) int activity_goal;
@property (assign) int calorie_burned_goal;
@property (assign) int calorie_consumed_goal;
@property (assign) int min_heartrate;
@property (assign) int max_heartrate;

@property (assign) bool dirty_settings;         // true if data has chnaged and not saved to watch

@property (strong,nonatomic) NSString *heartMonitorDevice;
@property (strong,nonatomic) NSString *pbbleAppUUID;

@property (strong,nonatomic) NSString *MOTIV8_UUID;
@property (strong,nonatomic) NSString *ON11_UUID;

@property (nonatomic) HKHealthStore *healthStore;

-(void) saveData;
-(void) loadData;

+ (MOTSettingsData *)sharedInstance;
@end
