//
//  ULXLoginWorker.h
//  UCASLogin-osx
//
//  Calls the script/
//
//  Created by Sun Peng on 2/26/13.
//  Copyright (c) 2013 Void Main Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ULXAppDelegate.h"
#import "ULXLoginKeyWrapper.h"

@interface ULXLoginWorker : NSObject {
    IBOutlet NSMenuItem *itemLoginCity;
    IBOutlet NSMenuItem *itemLoginContry;
    IBOutlet NSMenuItem *itemLoginWorld;
    
    IBOutlet NSMenuItem *itemLogout;
}

@property (retain, nonatomic) ULXAppDelegate* mainApp;

- (IBAction)login:(id)sender;
- (IBAction)logout:(id)sender;

- (void) executeScript:(NSString *)script withArguments:(NSArray *)arguments;
- (void) executeHelper:(NSArray *)arguments;

- (void) runScriptInNewThread:(NSArray *) array;

@end
