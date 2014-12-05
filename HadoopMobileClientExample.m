//
//  FirstViewController.m
//  HadoopConnect
//
//  Created by KLAUS HOFENBITZER on 11/29/14.
//  Copyright (c) 2014 KLAUS HOFENBITZER. All rights reserved.
//
#import "AFNetworking.h"
#import "AFJSONRequestOperation.h"


#import "FirstViewController.h"
#import "HDFSClient.h"


@interface FirstViewController () <NSXMLParserDelegate>



@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
// This method will create a file in Hadoop
// and append string to it. Then will open the file
// and display the content in a text box
- (IBAction)UploadFileToHadoop:(id)sender{
   HDFSClient *client = [[HDFSClient alloc] init];
    
   [client createFile:@"/user/hive/klaus.out" success:^(void) {
       [client appendStringToFile:@"/user/hive/myfile.out" string:@"\n100\tHDFSClient" success:^(void) {
           [client openFile:@"/user/hive/myfile.out" success:^(NSString *contentStr) {
               _OutputLbl.text =  [[NSString alloc] initWithFormat:@"%@",contentStr];
           }];
       }];
   }];
   
}



@end

