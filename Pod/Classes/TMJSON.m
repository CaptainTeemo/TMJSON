//
//  TMJSON.m
//  OCPlayground
//
//  Created by Captain Teemo on 11/8/15.
//  Copyright © 2015 Captain Teemo. All rights reserved.
//

#import "TMJSON.h"

@interface TMJSON()

@property (strong, nonatomic) NSObject *privateObject;
@property (strong, nonatomic) NSArray *rawArray;
@property (strong, nonatomic) NSMutableDictionary *rawDictionary;
@property (strong, nonatomic) NSString *rawString;
@property (strong, nonatomic) NSNumber *rawNumber;
@property (strong, nonatomic) NSNull *rawNull;

@end

@implementation TMJSON

- (instancetype)initWithObject: (NSObject *)object {
    self = [super init];
    if (self) {
        [self commonInit];
        self.privateObject = object;
    }
    return self;
}

- (void)commonInit {
    self.rawArray = [NSArray new];
    self.rawDictionary = [NSMutableDictionary new];
    self.rawNumber = [NSNumber numberWithInteger:0];
    self.rawString = @"";
    self.rawNull = [NSNull null];

    self.type = Null;
}

- (NSObject *)privateObject {
    switch (self.type) {
        case Number:
            return self.rawNumber;
            break;
        case Bool:
            return self.rawNumber;
            break;
        case Array:
            return self.rawArray;
            break;
        case Dictionary:
            return self.rawDictionary;
            break;
        case String:
            return self.rawString;
            break;
        case Null:
            return self.rawNull;
            break;
        default:
            return self.rawNull;
            break;
    }
}

- (void)setPrivateObject:(NSObject *)privateObject {
    if (!privateObject || [privateObject isKindOfClass:[NSNull class]]) {
        self.type = Null;
        self.rawNull = [NSNull null];
        return;
    }
    if ([privateObject isKindOfClass:[NSDictionary class]]) {
        self.type = Dictionary;
        self.rawDictionary = [(NSDictionary *)privateObject mutableCopy];
        return;
    }
    if ([privateObject isKindOfClass:[NSArray class]]) {
        self.type = Array;
        self.rawArray = (NSArray *)privateObject;
        return;
    }
    if ([privateObject isKindOfClass:[NSString class]]) {
        self.type = String;
        self.rawString = (NSString *)privateObject;
        return;
    }
    if ([privateObject isKindOfClass:[NSNumber class]]) {
        self.type = Number;
        self.rawNumber = (NSNumber *)privateObject;
        
        if ([self.rawNumber isEqual: @(YES)] || [self.rawNumber isEqual: @(NO)]) {
            self.type = Bool;
        }
        
        return;
    }
    
    NSAssert(NO, @"unsupported type with: %@", privateObject);
}

- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key {
    if (self.type == Dictionary) {
        self.rawDictionary[key] = obj;
    }
}

- (TMJSON *)objectForKeyedSubscript:(NSString *)key {
    if (self.type == Dictionary) {
        NSDictionary *object = self.rawDictionary[key];
        if (object) {
            return [[TMJSON alloc] initWithObject:object];
        }
    }
    return [[TMJSON alloc] initWithObject:[NSNull null]];
}

#pragma mark - Array Value

- (NSArray<TMJSON *> * _Nonnull)arrayValue {
    if (self.type == Array) {
        NSMutableArray *tempArray = [NSMutableArray new];
        for (NSObject *object in self.rawArray) {
            [tempArray addObject:[[TMJSON alloc] initWithObject:object]];
        }
        return tempArray;
    }
    return [NSArray new];
}

#pragma mark - Dictionary Value

- (NSDictionary *)dictionaryValue {
    if (self.type == Dictionary) {
        NSMutableDictionary *tempDictionary = [NSMutableDictionary new];
        [self.rawDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            tempDictionary[key] = [[TMJSON alloc] initWithObject:obj];
        }];
        return tempDictionary;
    }
    return [NSDictionary new];
}

#pragma mark - String Value

- (NSString *)stringValue {
    if (self.type == String) {
        return (NSString *)self.privateObject;
    }
    if (self.type == Number || self.type == Bool) {
        NSNumber *number = (NSNumber *)self.privateObject;
        return [NSString stringWithFormat:@"%@", number];
    }
    return @"";
}

- (void)setStringValue:(NSString *)stringValue {
    self.privateObject = stringValue;
}

#pragma mark - Bool Value

- (BOOL)boolValue {
    if (self.type == Number || self.type == Bool) {
        NSNumber *number = (NSNumber *)self.privateObject;
        return [number boolValue];
    }
    if (self.type == String) {
        NSString *string = (NSString *)self.privateObject;
        return [string boolValue];
    }
    return NO;
}

- (void)setBoolValue:(BOOL)boolValue {
    self.privateObject = [NSNumber numberWithBool:boolValue];
}

#pragma mark - Number Value

- (NSNumber *)numberValue {
    if (self.type == Number || self.type == Bool) {
        NSNumber *number = (NSNumber *)self.privateObject;
        return number;
    }
    if (self.type == String) {
        NSString *string = (NSString *)self.privateObject;
        return [NSNumber numberWithDouble:[string doubleValue]];
    }
    return [NSNumber numberWithDouble:0.0];
}

- (void)setNumberValue:(NSNumber *)numberValue {
    self.privateObject = numberValue;
}

#pragma mark - Integer Value

- (NSInteger)integerValue {
    NSNumber *number = (NSNumber *)self.privateObject;
    return [number integerValue];
}

- (void)setIntegerValue:(NSInteger)integerValue {
    self.privateObject = [NSNumber numberWithInteger:integerValue];
}

#pragma mark - Float Value

- (float)floatValue {
    return [self.numberValue floatValue];
}

- (void)setFloatValue:(float)floatValue {
    self.privateObject = [NSNumber numberWithFloat:floatValue];
}

#pragma  mark - Double Value

- (double)doubleValue {
    return [self.numberValue doubleValue];
}

- (void)setDoubleValue:(double)doubleValue {
    self.privateObject = [NSNumber numberWithDouble:doubleValue];
}



@end
