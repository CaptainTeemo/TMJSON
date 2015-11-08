# TMJSON

[![CI Status](http://img.shields.io/travis/Captain Teemo/TMJSON.svg?style=flat)](https://travis-ci.org/Captain Teemo/TMJSON)
[![Version](https://img.shields.io/cocoapods/v/TMJSON.svg?style=flat)](http://cocoapods.org/pods/TMJSON)
[![License](https://img.shields.io/cocoapods/l/TMJSON.svg?style=flat)](http://cocoapods.org/pods/TMJSON)
[![Platform](https://img.shields.io/cocoapods/p/TMJSON.svg?style=flat)](http://cocoapods.org/pods/TMJSON)

TMJSON is a [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) style tool to deal with JSON. The implementation is totally inspired by SwiftyJSON.

# Requirements
- iOS 7.0+
- Xcode 7

# Adding to your project

##Using CocoaPods

Just add pod 'TMJSON' to your Podfile.

# Usage

The APIs are quite like SwiftyJSON.

``` Objective-C
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
```

## License

TMJSON is available under the MIT license. See the LICENSE file for more info.
