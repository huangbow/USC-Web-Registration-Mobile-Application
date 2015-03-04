//
//  WRRealmSchoolList.h
//  mac15wr
//
//  Created by Alex on 2/27/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <Realm/Realm.h>

@interface WRRealmSchoolList : RLMObject
@property NSString* schoolAbb;
//@property NSString* schoolName;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<WRRealmSchoolList>
RLM_ARRAY_TYPE(WRRealmSchoolList)
