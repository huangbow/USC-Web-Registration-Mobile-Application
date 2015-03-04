//
//  WRLog.m
//  mac15wr
//
//  Created by zwein on 2/8/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//


#import "WRLog.h"



@implementation WRLog




- (instancetype)init {
    
    if ((self = [super init])) {
        
        WRLogFormatter *formatter = [[WRLogFormatter alloc] init];
        [[DDTTYLogger sharedInstance] setLogFormatter:formatter];
        [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:ddLogLevel];
        
        [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
        
        /**
         *  Define color for log flag
         */
        [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
        [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor iOS7greenColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
        [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor iOS7darkGrayColor] backgroundColor:nil forFlag:DDLogFlagDebug];
        [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor iOS7lightBlueColor] backgroundColor:nil forFlag:DDLogFlagInfo];
        [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor iOS7orangeColor] backgroundColor:nil forFlag:DDLogFlagWarning];
        [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor iOS7redColor] backgroundColor:nil forFlag:DDLogFlagError];
        

        
    }
    return self;
}

@end


@interface WRLogFormatter ()

@property (nonatomic, strong) NSDateFormatter *threadUnsafeDateFormatter;   // for date/time formatting

@end


@implementation WRLogFormatter

- (id)init {
    if (self = [super init]) {
        _threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
        [_threadUnsafeDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [_threadUnsafeDateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    }
    
    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *dateAndTime = [self.threadUnsafeDateFormatter stringFromDate:(logMessage->_timestamp)];
    
    NSString *logLevel = nil;
    switch (logMessage->_flag) {
        case DDLogFlagError     : logLevel = @"E"; break;
        case DDLogFlagWarning   : logLevel = @"W"; break;
        case DDLogFlagInfo      : logLevel = @"I"; break;
        case DDLogFlagDebug     : logLevel = @"D"; break;
        case DDLogFlagVerbose   : logLevel = @"V"; break;
        default                 : logLevel = @"?"; break;
    }
    
    NSString *formattedLog = [NSString stringWithFormat:@"%@ |%@| [%@ %@] #%@: %@",
                              dateAndTime,
                              logLevel,
                              logMessage->_fileName,
                              logMessage->_function,
                              @(logMessage->_line),
                              logMessage->_message];
    
    return formattedLog;
}

@end

