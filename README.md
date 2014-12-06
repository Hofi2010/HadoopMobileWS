Experimental - Work in Porgress but Working ... The code was compiled with AFNetworking 1.0 library

Hadoop Mobile Web Client (iOS)
==============

This project provides objective-c wrapper classes for Hadoop WebHDFS and WebhCat REST web services. The main motivation to develop this interface is to upload body sensor data captured via mobile devices, such as the iPhone, to Hadoop for further analysis. For example data from MOTIV8 that collects a lot of body sensor data like heartrate and step counts from users. The aim is <b>not</b> to support a single base URL rather than a generic library programmers can point to any Hadoop cluster.

The objective-c wrapper classes will handle the web service protocol and provide easy to use functions to create, delete, append and upload ascii files, images to Hadoop from a mobile device.
There will also be classes to support the WebHCat interface to add data to a hive DB and tables, create and drop tables, execute hive sql statement from any iOS device.

In order to use this library on an iOS device you need to have the full domain name of the Hadoop instance, e.g. sandbox.hortonworks.com or similar. Just the ip address will not work, because the Hadoop REST API works quit a bit with redirected URI's using the full domain name. So the network you use the iOS device on needs to be able to resolve this domain name. If you are planning to use it on the internet the Hadoop instance would need a unique domain name registered with a DNS provider.

#### Creating an Upload Task for a Multi-Part Request, with Progress

```objective-c
NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];

AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
NSProgress *progress = nil;

NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
    if (error) {
        NSLog(@"Error: %@", error);
    } else {
        NSLog(@"%@ %@", response, responseObject);
    }
}];

[uploadTask resume];
