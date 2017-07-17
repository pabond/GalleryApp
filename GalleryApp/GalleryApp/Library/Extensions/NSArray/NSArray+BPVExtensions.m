//
//  NSArray+BPVExtensions.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSArray+BPVExtensions.h"

@implementation NSArray (BPVExtensions)

+ (instancetype)arrayWithObjectsFactoryWithCount:(NSUInteger)count block:(id(^)())block {
    if (!block) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSUInteger index = 0; index < count; index++) {
        [array addObject:block()];
    }
    
    return [self arrayWithArray:array];
}

- (NSArray *)filteredUsingBlock:(BPVArrayFiltredUsingBlock)block {
    if (!block) {
        return nil;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return block(evaluatedObject);
    }];
    
    return [self filteredArrayUsingPredicate:predicate];
}

- (id)objectWithClass:(Class)class {
    for (id object in self) {
        if ([object isMemberOfClass:class]) {
            return object;
        }
    }
    
    return nil;
}

@end
