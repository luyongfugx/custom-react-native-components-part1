//
//  MCFileWriterUtil.m
//  CustomComponent
//
//  Created by Jesus Garcia on 3/30/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "MCFileWriterUtil.h"

@implementation MCFileWriterUtil


// Persist data
- (void) writeFile:(NSString *)fileName
            withContents:(NSString *)contents
            errorCallback:(RCTResponseSenderBlock)failureCallback
            callback:(RCTResponseSenderBlock)successCallback {
    
    // #Step 1
    RCT_EXPORT();
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));

    successCallback(@[@{ @"key" : @"Write method called"}]);
}

            
// Load data from disk and return the String.
- (void) readFile:(NSString *)fileName
            errorCallback:(RCTResponseSenderBlock)failureCallback
            callback:(__unused RCTResponseSenderBlock)successCallback {

    // #Step 1
    RCT_EXPORT();
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    
    successCallback(@[@"Read method called"]);

}

@end
