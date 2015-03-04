//
//  WRLog.h
//  mac15wr
//
//  Created by zwein on 2/8/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//


#import "WRPrecompile.h"
#import "UIColor+iOS7Colors.h"
#import "CocoaLumberjack.h"
#import "DDDispatchQueueLogFormatter.h"


// Log levels: debug, error, warn, info, verbose
#undef WR_LOG_LEVEL
#if ( __ON__ == __WR_LOG__ )    
// Debug mode
// Show all logs
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else   
// Release mode
// Only show warning and error logs
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

#define WRLOG_INIT [[WRLog alloc] init];

/**
 *  5 level log
 *  e.g.
 *  DDLogVerbose(@"Verbose");
 *  DDLogDebug(@"Debug");
 *  DDLogInfo(@"Info");
 *  DDLogWarn(@"Warn");     // always show
 *  DDLogError(@"Error");   // always show
 */
@interface WRLog : NSObject

@end

@interface WRLogFormatter : DDDispatchQueueLogFormatter<DDLogFormatter>

@end







