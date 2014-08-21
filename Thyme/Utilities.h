//
//  Utilities.h
//  Thyme
//
//  Created by Daniel Suo on 8/20/14.
//  Copyright (c) 2014 The Leather Apron Club. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject
+ (void) setSettingsValue:(NSString *) value forKey:(NSString *) key;
+ (NSString *) getSettingsValue:(NSString *) key;
+ (void) setSettingsObject:(NSObject *) object forKey:(NSString *) key;
+ (NSObject *) getSettingsObject:(NSString *) key;
@end
