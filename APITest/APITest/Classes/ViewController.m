//
//  ViewController.m
//  APITest
//
//  Created by apple on 22/03/18.
//  Copyright © 2018 N_Apple. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<GetAppointmentDetails xmlns=\"www.skylinecms.co.uk/\">\n"
                             "<SLUsername>%@</SLUsername>\n"
                             "<SLPassword>%@</SLPassword>\n"
                             "<CurrentDate>%@</CcurrentDate>\n"
                             "</GetAppointmentDetails>\n"
                             , @"ON"
                             , @"andriodtest"
                             , @"23/03/2018"
                             ];
    NSLog(@"soapMessage: \n%@",soapMessage);
    //???.asmx
    
    NSURL *url = [NSURL URLWithString:@"https://www.skylinecms.co.uk/alpha/RemoteEngineerAPI/GetAppointmentDetails"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //SOAPAction
    [theRequest addValue: @"GetAppointmentDetails" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionConfiguration *defaultCon = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultCon.timeoutIntervalForRequest = 120.00;
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultCon delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:theRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSLog(@"response is..%@",response);
                                                           NSLog(@"error is..%@",error.userInfo);
                                                           if(error == nil)
                                                           {
                                                             
                                                               NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                               NSLog(@"%@",str);
                                                               
                                                            
                                                               
                                                           }else
                                                           {
                                                               
                                                           }
                                                       }];
    [dataTask resume];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
