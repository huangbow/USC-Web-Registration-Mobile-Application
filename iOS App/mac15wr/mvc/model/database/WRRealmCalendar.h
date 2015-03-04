//
//  WRRealmCalendar.h
//  mac15wr
//
//  Created by Alex on 2/27/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <Realm/Realm.h>

@interface WRRealmCalendar : RLMObject
@property int calendarNum;
@property NSData* courseSection;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<WRRealmCalendar>
RLM_ARRAY_TYPE(WRRealmCalendar)
