//
//  MCFileWriterUtil.m
//  CustomComponent
//
//  Created by Jesus Garcia on 3/30/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "MCFileWriterUtil.h"

@implementation MCFileWriterUtil


NSString * convertDictToJsonString(NSDictionary *dict) {
    
    NSData *jsonData = [NSJSONSerialization
                            dataWithJSONObject : dict
                            options            : NSJSONWritingPrettyPrinted
                            error              : nil
                       ];
    
    
    return [[NSString alloc]
                initWithData : jsonData
                encoding     : NSUTF8StringEncoding
           ];
}


// Persist data
- (void) writeFile:(NSString *)fileName
            withContents:(NSString *)contents
            errorCallback:(RCTResponseSenderBlock)failureCallback
            callback:(RCTResponseSenderBlock)successCallback {
    
    // #Step 1
    RCT_EXPORT();
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));

    NSString *resultJsonString;
    
    if ([fileName length] < 1) {
        // Craft a failure message
        resultJsonString = convertDictToJsonString(@{
            @"success" : @NO,
            @"errMsg"  : @"No file name."
        });
        
        // Execute the JavaScript failure callback handler
        failureCallback(@[resultJsonString]);
        
        return; // Halt execution of this function
    }
    
    // Create an array of directory Paths, to allow us to get the documents directory 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // The documents directory is the first item
    NSString *documentsDirectory = [paths objectAtIndex:0];

    // Create a string that prepends the documents directory path to a text file name
    // using NSString's stringWithFormat method.
    fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    NSLog(@"Writing to %@", fileName);
    
    // Initialize an NSError variable
    NSError *writeError;
    
    // Here we save contents to disk by executing the writeToFile method of 
    // the fileContents String, which is the first argument to this function.
    [contents writeToFile : fileName
                  atomically  : NO
                  encoding    : NSStringEncodingConversionAllowLossy
                  error       : &writeError];


    // Error Condition handling
    if (writeError) {
        // Craft a failure message
        resultJsonString = convertDictToJsonString(@{
            @"success" : @NO,
            @"errMsg"  : [writeError localizedDescription]
        });
        
        // Execute the JavaScript failure callback handler
        failureCallback(@[resultJsonString]);
    }
    // Success handling
    else {
    
        // Craft a success return message
        resultJsonString = convertDictToJsonString(@{
            @"success" : @YES
        });
        
        // Call the JavaScript sucess handler
        successCallback(@[resultJsonString]);
    }
}

            


// Load data from disk and return the String.
- (void) readFile:(NSString *)fileName
            errorCallback:(RCTResponseSenderBlock)failureCallback
            callback:(__unused RCTResponseSenderBlock)successCallback {

    // #Step 1
    RCT_EXPORT();
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));

    NSString *resultJsonString;
    
    if ([fileName length] < 1) {
        // Craft a failure message
        resultJsonString = convertDictToJsonString(@{
            @"success" : @NO,
            @"errMsg"  : @"No file name."
        });
        
        // Execute the JavaScript failure callback handler
        failureCallback(@[resultJsonString]);
        
        return; // Halt execution of this function
    }
    
    // Create an array of directory Paths, to allow us to get the documents directory 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // The documents directory is the first item
    NSString *documentsDirectory = [paths objectAtIndex:0];

    // Create a string that prepends the documents directory path to a text file name
    // using NSString's stringWithFormat method.
    fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    NSLog(@"Writing to %@", fileName);
    
    // Initialize an NSError variable
    NSError *readError;
    
    // Allocate a string and initialize it with the contents of the file via
    // the initWithContentsOfFile instance method.
    NSString *fileContents = [[NSString alloc]
                               initWithContentsOfFile : fileName
                               usedEncoding           : nil
                               error                  : &readError
                             ];

    // Error Condition handling
    if (readError) {
        // Craft a failure message
        resultJsonString = convertDictToJsonString(@{
            @"success" : @NO,
            @"errMsg"  : [readError localizedDescription]
        });
        
        // Execute the JavaScript failure callback handler
        failureCallback(@[resultJsonString]);
    }
    // Success handling
    else {
    
        // Craft a success return message
        resultJsonString = convertDictToJsonString(@{
            @"success" : @YES,
            @"contents" : fileContents
        });
        
        // Call the JavaScript sucess handler
        successCallback(@[resultJsonString]);
    }


}

@end
