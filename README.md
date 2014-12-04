COMING SOON

HadoopMobileWS
==============

This project provides objective-c wrapper classes for Hadoop WebHDFS and WebhCat REST web services. The main motivation to develop this interface for me is to upload body sensor data to hadoop for further analysis. I already have products out like MOTIV8 that collects a lot of body sensor data like heartrate and step counts from people. This library is developed to upload this type of data from an iOS device to a scalable Hadoop platform. Please note the library will not be hardwired to a specific hadoop instance it is designed to point to any hadoop instance.

The objective-c wrapper classes will hnadle the web service protocol and provide easy to use functions to create, delete, append and upload files to hadoop from your mobile phone. 

There will also be classes to support the WebHCat interface to add data to a hive DB and tables, create and drop tables, execute hive sql statement from any iOS device.

In order to use this library on an iOS deivce you need to have the full domain name of the hadoop instance, e.g. sandbox.hortonworks.com or similar. Just the ip address will not work, because the Hadoop REST API works quit a bit with redirected URI's using the full domain name. So the network you use the iOS device on needs to be able to resolve this domain name. If you are planning to use it in the internet the hadoop instance would need a unique domain name registered with a DNS provider.

