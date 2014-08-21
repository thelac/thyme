//
//  Activity.h
//  Thyme
//
//  Created by Daniel Suo on 8/20/14.
//  Copyright (c) 2014 The Leather Apron Club. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSDate *start;
@property (strong, nonatomic) NSDate *end;
@end
