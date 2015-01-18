//
//  TLOperatingSystemVersion.m
//  Amtrak Status
//
//  Created by Todd Lunter on 1/6/15.
//  Copyright (c) 2015 Todd Lunter. All rights reserved.
//

#import "TLOperatingSystemVersion.h"

@implementation TLOperatingSystemVersion

+ (NSOperatingSystemVersion)yosemite {
    NSOperatingSystemVersion os;
    os.majorVersion = 10;
    os.minorVersion = 10;
    os.patchVersion = 0;
    return os;
}

@end
