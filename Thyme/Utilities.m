//
//  Utilities.m
//  Thyme
//
//  Created by Daniel Suo on 8/20/14.
//  Copyright (c) 2014 The Leather Apron Club. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities
+ (void) setSettingsValue:(NSString *) value forKey:(NSString *) key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
};

+ (NSString *) getSettingsValue:(NSString *) key {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
};

+ (void) setSettingsObject:(NSObject *) object forKey:(NSString *) key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
};

+ (NSObject *) getSettingsObject:(NSString *) key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
};
@end
