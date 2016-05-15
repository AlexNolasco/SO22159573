//
//  SWGGameEventModel+Polymorphism.m
//  inheritance
//
//  Created by alexander nolasco on 5/14/16.
//  Copyright © 2016 coladapp.com. All rights reserved.
//

#import "SWGGameEventModel+Polymorphism.h"
#import "SWGGameEventModel.h"
#import "SWGGameTouchEventModel.h"
#import "SWGGameFooEventModel.h"

@implementation SWGGameEventModel (Polymorphism)

+ (Class)subclassForType:(NSString *)classType
{

    if ([classType isEqualToString:@"gameEventModel"]) {
        return [SWGGameEventModel class];
    } else if ([classType isEqualToString:@"gameFooEventModel"]) {
        return [SWGGameFooEventModel class];
    }
    return nil;
}

// returns true if class is a subclass of SWGGameEventModel (false if class is MyClass)
- (BOOL)isExclusiveSubclass
{
    if (![self isKindOfClass:SWGGameTouchEventModel.class])
        return false;

    return true;
}

// JSONModel calls this
- (instancetype)initWithDictionary23:(NSDictionary *)dict error:(NSError **)error
{
    if ([self isExclusiveSubclass])
        return [super initWithDictionary:dict error:error];

    self = nil;

    NSString * type = dict[@"gameEventModelType"];
    Class class = [SWGGameEventModel subclassForType:type];

    return [[class alloc] initWithDictionary:dict error:error];
}
@end
