//
//  MCFileWriterUtil.h
//  CustomComponent
//
//  Created by Jesus Garcia on 3/30/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "RCTViewManager.h"

@interface MCFileWriterUtil : RCTViewManager


#pragma mark - Util_Methods

// Persist data
- (void) writeFile:(NSString *)fileName
//            withContents:(NSString *)contents
            errorCallback:(RCTResponseSenderBlock)failureCallback
            callback:(__unused RCTResponseSenderBlock)successCallback;


// Load data from disk and return the String.
- (void) readFile:(NSString *)fileName
                errorCallback:(RCTResponseSenderBlock)failureCallback
                callback:(__unused RCTResponseSenderBlock)successCallback;


@end
