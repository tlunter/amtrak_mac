//
//  TLTrain.m
//  Amtrak Status
//
//  Created by Todd Lunter on 8/11/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLTrain.h"

@implementation TLTrain

@synthesize number, scheduled, estimated;

- (BOOL)isEqualToTrain:(TLTrain *)other {
    if (!other) return NO;

    BOOL haveEqualNumbers = (!self.number && !other.number) || [self.number isEqualToString:other.number];
    BOOL haveEqualScheduled = (!self.scheduled && !other.scheduled) || [self.scheduled isEqualToString:other.scheduled];
    BOOL haveEqualEstimated = (!self.estimated && !other.estimated) || [self.estimated isEqualToString:other.estimated];

    return haveEqualNumbers && haveEqualScheduled && haveEqualEstimated;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[TLTrain class]]) {
        return NO;
    }

    return [self isEqualToTrain:(TLTrain *)object];
}

- (NSUInteger)hash {
    return [self.number hash] ^ [self.scheduled hash] ^ [self.estimated hash];
}

@end
