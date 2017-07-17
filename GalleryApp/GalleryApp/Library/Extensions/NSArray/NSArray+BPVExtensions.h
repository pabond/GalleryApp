//
//  NSArray+BPVExtensions.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^BPVArrayFiltredUsingBlock)(id object);

@interface NSArray (BPVExtensions)

+ (instancetype)arrayWithObjectsFactoryWithCount:(NSUInteger)count block:(id(^)())block;

- (NSArray *)filteredUsingBlock:(BPVArrayFiltredUsingBlock)block;
- (id)objectWithClass:(Class)cls;

@end
