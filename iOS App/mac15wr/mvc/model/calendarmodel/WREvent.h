//
//  WREvent.h
//  mac15wr
//
//  Created by zwein on 2/23/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WREvent : NSManagedObject

@property (nonatomic, strong) NSNumber *remoteID;
@property (nonatomic, strong) NSDate *start;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSNumber *timeToBeDecided;
@property (nonatomic, strong) NSNumber *dateToBeDecided;

- (NSDate *)day; // Derived attribute to make it easy to sort events into days by equality



@end
