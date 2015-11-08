//
//  TMJSONTests.m
//  TMJSONTests
//
//  Created by Captain Teemo on 11/08/2015.
//  Copyright (c) 2015 Captain Teemo. All rights reserved.
//

@import XCTest;
@import TMJSON;

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCTestExpectation *exception = [self expectationWithDescription:@"FetchJSON"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://jsonplaceholder.typicode.com/users"]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"request error: %@", error.localizedDescription);
            return;
        }
        
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        TMJSON *json = [[TMJSON alloc] initWithObject:responseObject];
        
        NSArray *rootArray = json.arrayValue;
        NSLog(@"array: %@", rootArray);
        
        TMJSON *firstObject = rootArray[0];
        
        NSString *wrongKey = firstObject[@"Teemo"].stringValue;
        NSLog(@"wrongKey: %@", wrongKey);
        
        NSString *name = firstObject[@"name"].stringValue;
        NSLog(@"name: %@", name);
        
        NSDictionary *address = firstObject[@"address"].dictionaryValue;
        NSLog(@"address: %@", address);
        
        double latitude = firstObject[@"address"][@"geo"][@"lat"].doubleValue;
        NSLog(@"lat: %f", latitude);
        
        [exception fulfill];
    }];
    
    [task resume];
    
    [self waitForExpectationsWithTimeout:15.f handler:nil];
}

@end

