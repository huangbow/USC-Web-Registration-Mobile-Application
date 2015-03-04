//
//  WRRealmUsers.h
//  mac15wr
//
//  Created by Alex on 2/27/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <Realm/Realm.h>

@interface WRRealmUsers : RLMObject
@property NSString* email;
@property NSString* idToken;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<WRRealmUsers>
RLM_ARRAY_TYPE(WRRealmUsers)
