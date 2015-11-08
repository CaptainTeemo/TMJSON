//
//  TMJSON.h
//  OCPlayground
//
//  Created by Captain Teemo on 11/8/15.
//  Copyright © 2015 Captain Teemo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger) {
    Number = 0,
    String,
    Bool,
    Array,
    Dictionary,
    Null
}Type;

@interface TMJSON : NSObject

@property (copy, nonatomic) NSString * _Nonnull stringValue;
@property (assign, nonatomic) BOOL boolValue;
@property (strong, nonatomic) NSNumber * _Nonnull numberValue;
@property (assign, nonatomic) NSInteger integerValue;
@property (assign, nonatomic) float floatValue;
@property (assign, nonatomic) double doubleValue;

@property (assign, nonatomic) Type type;

- (instancetype _Nonnull)initWithObject: (NSObject * _Nullable)object;
- (TMJSON * _Nonnull)objectForKeyedSubscript:(NSString * _Nonnull)key;
- (void)setObject:(id _Nonnull)obj forKeyedSubscript:(NSString * _Nonnull)key;

- (NSArray<TMJSON *> * _Nonnull)arrayValue;
- (NSDictionary * _Nonnull)dictionaryValue;
@end
